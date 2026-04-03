// ignore_for_file: must_be_immutable, non_constant_identifier_names

part of 'schedulelist_bloc.dart';

@immutable
sealed class SchedulelistState {}

final class SchedulelistInitial extends SchedulelistState {}

class ScheduleListIsLoading extends SchedulelistState {}

class ScheduleListIsFailure extends SchedulelistState {
  String error;
  ScheduleListIsFailure(this.error);
}

class ScheduleListIsLoaded extends SchedulelistState {
  List data;
  bool hasMore;
  bool pageLoading;
  int page;
  int total;
  bool IsloadingPage;

  ScheduleListIsLoaded({
    required this.data,
    this.hasMore = false,
    this.pageLoading = false,
    this.page = 1,
    this.total = 1,
    this.IsloadingPage = false,
  });
}

class ScheduleListShowLoaded extends SchedulelistState {
  SchedulelistModel data;
  ScheduleListShowLoaded({
    required this.data,
  });
}
