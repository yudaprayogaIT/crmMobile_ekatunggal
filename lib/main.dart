import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geofence_foreground_service/constants/geofence_event_type.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ekareach/bloc/auth/auth_bloc.dart';
import 'package:ekareach/bloc/gps/gps_bloc.dart';
import 'package:ekareach/repositories/auth_repository.dart';
import 'package:ekareach/screens/callsheet/callsheet_screen.dart';
import 'package:ekareach/screens/customer/customer_screen.dart';
import 'package:ekareach/screens/dn/dn_screen.dart';

// import 'package:ekareach/screens/facedetector/fc_register_screen.dart';
import 'package:ekareach/screens/home/home_screen.dart';
import 'package:ekareach/screens/invoice/invoice_screen.dart';
import 'package:ekareach/screens/item/item_screen.dart';
import 'package:ekareach/screens/login_screen.dart';
import 'package:ekareach/screens/order/order_screen.dart';
// import 'package:ekareach/screens/visit/checkin_screen.dart';
import 'package:ekareach/screens/visit/visit_screen.dart';
import 'package:geofence_foreground_service/geofence_foreground_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:developer';
import 'package:geofence_foreground_service/exports.dart';
import 'package:geofence_foreground_service/models/notification_icon_data.dart';
import 'package:geofence_foreground_service/models/zone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ekareach/models/callsheet_model.dart';
import 'package:ekareach/services/hive_service.dart';
import 'package:ekareach/services/sync_service.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

void initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await notificationsPlugin.initialize(initializationSettings);
}

void showNotification(String title, String body) {
  flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'geofence_channel',
        'Geofence Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  // initializeNotifications();

  // await Permission.location.request();
  // await Permission.activityRecognition.request();
  // await Permission.locationAlways.request();
  // startMyService();
  SyncService.startSyncLoop();
  runApp(MyApp());
  configLoading();
}

void startMyService() async {
  final geofenceService = GeofenceForegroundService();

  // Pastikan kamu sudah permission foreground location
  await geofenceService.startGeofencingService(
    callbackDispatcher: callbackDispatcher,
    contentTitle: 'Tracking Active',
    contentText: 'Your location is being monitored',
    notificationChannelId: 'geofence_channel',
    isInDebugMode: true,
    serviceId: 123,
  );

  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    log("Current location: lat=${position.latitude}, lon=${position.longitude}");

    final List<LatLng> _timesSquarePolygon = [
      LatLng.degree(position.latitude, position.longitude),
      LatLng.degree(position.latitude, position.longitude),
      LatLng.degree(position.latitude, position.longitude),
      LatLng.degree(position.latitude, position.longitude),
    ];

    await GeofenceForegroundService().addGeofenceZone(
      zone: Zone(
        id: 'zone#1_id',
        radius: 1000,
        coordinates: _timesSquarePolygon,
      ),
    );
    log('Geofence added successfully');
  } catch (e) {
    log('Failed to add geofence: $e');
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() async {
  GeofenceForegroundService().handleTrigger(
    backgroundTriggerHandler: (zoneID, triggerType) {
      log(zoneID, name: 'zoneID');
      print('Trigger fired: $triggerType in zone: $zoneID');

      if (triggerType == GeofenceEventType.enter) {
        log('enter', name: 'triggerType');
        showNotification('Geofence Trigger', 'Kamu memasuki area!');
      } else if (triggerType == GeofenceEventType.exit) {
        log('exit', name: 'triggerType');
        showNotification('Geofence Trigger', 'Kamu keluar area!');
      } else if (triggerType == GeofenceEventType.dwell) {
        log('dwell', name: 'triggerType');
        showNotification('Geofence Trigger', 'Kamu sedang berada di area!');
      } else {
        log('unknown', name: 'triggerType');
        showNotification('Geofence Trigger', 'Acara geofence tidak dikenal');
      }

      return Future.value(true);
    },
  );
}

class MyApp extends StatelessWidget {
  final authBloc = AuthBloc(AuthRepository());

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => authBloc,
        ),
        BlocProvider<GpsBloc>(
          create: (context) => GpsBloc()
            ..add(
              GpsGetEnable(
                distanceFilter: 2,
              ),
            ),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        home: BlocBuilder<AuthBloc, AuthState>(
          bloc: authBloc..add(AppStarted()),
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const HomeScreen();
            }
            if (state is AuthUnauthenticated) {
              return const LoginScreen();
            }
            if (state is AuthLoading) {
              return Center(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(color: Colors.grey[400]),
                ),
              );
            }
            return Container();
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/visit': (context) => BlocProvider.value(
                value: authBloc,
                child: const VisitScreen(),
              ),
          '/callsheet': (context) => BlocProvider.value(
                value: authBloc,
                child: const CallsheetScreen(),
              ),
          '/home': (context) => BlocProvider.value(
                value: authBloc,
                child: const HomeScreen(),
              ),
          '/dn': (context) => BlocProvider.value(
                value: authBloc,
                child: const DnScreen(),
              ),
          '/invoice': (context) => BlocProvider.value(
                value: authBloc,
                child: const InvoiceScreen(),
              ),
          '/so': (context) => BlocProvider.value(
                value: authBloc,
                child: const OrderScreen(),
              ),
          '/item': (context) => BlocProvider.value(
                value: authBloc,
                child: const ItemScreen(),
              ),
          '/customer': (context) => BlocProvider.value(
                value: authBloc,
                child: const CustomerScreen(),
              ),
          // '/schedule': (context) => BlocProvider.value(
          //       value: authBloc,
          //       child: const CustomerScreen(),
          //     ),
        },
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}
