// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, unused_import, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ekareach/models/result_location_model.dart';
import 'package:ekareach/utils/fetch_data.dart';
import 'package:ekareach/utils/get_permission.dart';
import 'package:ekareach/utils/location_gps.dart';
import 'package:ekareach/utils/tools.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  final Location _location = Location();
  StreamSubscription<LocationData>? _locationSubscription;

  GpsBloc() : super(GpsInitial()) {
    on<GpsSetLocation>((event, emit) => emit(GpsIsLoaded(event.position)));
    on<GpsSetError>((event, emit) => emit(GpsIsFailure(event.msg)));
    on<GpsSetCheckInOut>(_handleCheckInOut);
    on<GpsGetLocation>(_getCurrentLocation);
    on<GpsGetEnable>(_enableRealtimeTracking);
  }

  Future<Map<String, Uint8List>> _loadIcons() async {
    final markerIcon =
        await Tools().getBytesFromAsset('assets/icons/etm.png', 130);
    final customerIcon = await Tools()
        .getBytesFromAsset('assets/icons/pincustomermaps.png', 130);
    return {
      'marker': markerIcon,
      'customer': customerIcon,
    };
  }

  Future<void> _getCurrentLocation(
    GpsGetLocation event,
    Emitter<GpsState> emit,
  ) async {
    try {
      await GetPermission.askLocation();
      emit(GpsIsLoading());

      final icons = await _loadIcons();
      Map<String, dynamic> config = {};

      if (event.checkInOut != null) {
        config = await FetchData(data: Data.config).FINDALL();
      }

      _location.changeSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: (event.distanceFilter ?? 0).toDouble(),
      );

      final currentLocation = await _location.getLocation();
      if (currentLocation.isMock == true) {
        add(GpsSetError("Fake location detected!"));
        return;
      }

      if (currentLocation.latitude == null ||
          currentLocation.longitude == null) {
        emit(GpsIsFailure("Invalid GPS data"));
        return;
      }

      final result = ResultLocation(
        latitude: currentLocation.latitude!,
        longitude: currentLocation.longitude!,
      );

      if (event.checkInOut != null) {
        add(GpsSetCheckInOut(
          config: config,
          customer: event.checkInOut?.customer ?? "",
          customerIcon: icons['customer']!,
          markerIcon: icons['marker']!,
          position: result,
        ));
      } else {
        add(GpsSetLocation(result));
      }

      await _startRealtimeUpdates(event, icons, config);
    } catch (e) {
      emit(GpsIsFailure(e.toString()));
    }
  }

  Future<void> _enableRealtimeTracking(
    GpsGetEnable event,
    Emitter<GpsState> emit,
  ) async {
    try {
      await GetPermission.askLocation();

      _location.changeSettings(
        accuracy: LocationAccuracy.navigation,
        distanceFilter: (event.distanceFilter ?? 0).toDouble(),
        interval: event.interval ?? 1000,
      );

      final currentLocation = await _location.getLocation();
      if (currentLocation.isMock == true) {
        add(GpsSetError("Fake location detected!"));
        return;
      }

      if (currentLocation.latitude == null ||
          currentLocation.longitude == null) {
        emit(GpsIsFailure("Invalid GPS data"));
        return;
      }

      final result = ResultLocation(
        latitude: currentLocation.latitude!,
        longitude: currentLocation.longitude!,
      );

      add(GpsSetLocation(result));

      await _startRealtimeUpdates(
        GpsGetLocation(distanceFilter: event.distanceFilter?.toInt()),
        await _loadIcons(),
        {},
      );
    } catch (e) {
      emit(GpsIsFailure(e.toString()));
    }
  }

  Future<void> _startRealtimeUpdates(
    GpsGetLocation event,
    Map<String, Uint8List> icons,
    Map<String, dynamic> config,
  ) async {
    try {
      emit(GpsIsLoading());

      await _locationSubscription?.cancel();
      _locationSubscription = _location.onLocationChanged.listen(
        (LocationData currentLocation) {
          if (currentLocation.isMock == true) {
            add(GpsSetError("Fake location detected!"));
            return;
          }

          if (currentLocation.latitude == null ||
              currentLocation.longitude == null) {
            return;
          }

          final resultLocation = ResultLocation(
            latitude: currentLocation.latitude!,
            longitude: currentLocation.longitude!,
          );

          if (kDebugMode) {
            // print(
            //     'Realtime GPS: ${resultLocation.latitude}, ${resultLocation.longitude}');
          }

          if (event.checkInOut != null) {
            add(GpsSetCheckInOut(
              config: config,
              customer: event.checkInOut?.customer ?? "",
              customerIcon: icons['customer']!,
              markerIcon: icons['marker']!,
              position: resultLocation,
            ));
          } else {
            add(GpsSetLocation(resultLocation));
          }
        },
      );
    } catch (e) {
      emit(GpsIsFailure(e.toString()));
    }
  }

  Future<void> _handleCheckInOut(
    GpsSetCheckInOut event,
    Emitter<GpsState> emit,
  ) async {
    try {
      bool isInsite = false;

      if ((event.customer ?? "").isNotEmpty) {
        final data = await FetchData(data: Data.customer).FINDALL(
          nearby:
              "&nearby=[${event.position.latitude},${event.position.longitude},${event.config['data']['visit']['checkInDistance']}]",
          filters: [
            ["_id", "=", event.customer!],
          ],
        );
        isInsite = data['data'] != null;
      }

      final address = await LocationGps().chekcAdress(event.position);

      emit(GpsCheckInOutIsLoaded(
        IconEtmMaps: BitmapDescriptor.fromBytes(event.markerIcon),
        IconCustomerMaps: BitmapDescriptor.fromBytes(event.customerIcon),
        distanceCheckIn: event.config['data']['visit']['checkInDistance'],
        distanceCheckOut: event.config['data']['visit']['checkOutDistance'],
        insite: isInsite,
        position: event.position,
        address: address,
      ));
    } catch (e) {
      emit(GpsIsFailure(e.toString()));
    }
  }

  @override
  Future<void> close() async {
    await stopGps();
    return super.close();
  }

  Future<void> stopGps() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
  }
}
