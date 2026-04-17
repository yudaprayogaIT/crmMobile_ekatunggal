// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'package:ekareach/models/schedulelist_model.dart';
import 'package:ekareach/utils/fetch_data.dart';

part 'schedulelist_event.dart';
part 'schedulelist_state.dart';

class SchedulelistBloc extends Bloc<SchedulelistEvent, SchedulelistState> {
  int? tabActive;
  int page = 1;
  String search = "";
  SchedulelistBloc() : super(SchedulelistInitial()) {
    on<GetAllScheduList>(_GetAllData);
    on<ShowScheduList>(_ShoData);
  }

  Future<void> _GetAllData(
    GetAllScheduList event,
    Emitter<SchedulelistState> emit,
  ) async {
    try {
      if (event.search != null) {
        search = event.search!;
      }
      if (state is ScheduleListIsLoaded && !event.refresh) {
        ScheduleListIsLoaded current = state as ScheduleListIsLoaded;

        page = current.page;
        current.IsloadingPage = true;
        emit(
          ScheduleListIsLoaded(
            data: current.data,
            IsloadingPage: true,
            hasMore: current.hasMore,
            page: current.page,
            total: current.total,
          ),
        );
      } else {
        if (event.refresh) {
          EasyLoading.show(status: 'loading...');
          emit(ScheduleListIsLoading());
        }
      }

      late Map<String, dynamic> result;

      result = await FetchData(data: Data.schedulelist).FINDALL(
        page: event.refresh ? 1 : page,
        filters: event.filters,
        search: event.search,
        limit: 20,
      );

      if (result['status'] != 200) {
        throw result['msg'];
      }

      // List<SchedulelistModel> scheduleList =
      //     SchedulelistModel.fromJsonList(result['data']);

      List newData = result['data'];

      List currentData = [];

      if (state is ScheduleListIsLoaded && !event.refresh) {
        ScheduleListIsLoaded current = state as ScheduleListIsLoaded;
        currentData = current.data;
        currentData.addAll(newData);
      } else {
        currentData = newData;
      }

      emit(
        ScheduleListIsLoaded(
          data: currentData,
          hasMore: result['hasMore'],
          total: result['total'],
          page: result['nextPage'],
          IsloadingPage: false,
        ),
      );
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      emit(
        ScheduleListIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _ShoData(
    ShowScheduList event,
    Emitter<SchedulelistState> emit,
  ) async {
    try {
      emit(ScheduleListIsLoading());
      final Map<String, dynamic> response =
          await FetchData(data: Data.schedulelist).FINDONE(id: event.id);

      if (response['status'] != 200) {
        throw response['msg'];
      }

      SchedulelistModel data = SchedulelistModel.fromJson(
        response['data'],
      );
      emit(ScheduleListShowLoaded(data: data));
    } catch (e) {
      emit(
        ScheduleListIsFailure(
          e.toString(),
        ),
      );
    }
  }
}
