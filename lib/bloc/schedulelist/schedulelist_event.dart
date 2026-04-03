// ignore_for_file: must_be_immutable

part of 'schedulelist_bloc.dart';

@immutable
sealed class SchedulelistEvent {}

class ShowScheduList extends SchedulelistEvent {
  final String id;
  ShowScheduList(this.id);
}

class GetAllScheduList extends SchedulelistEvent {
  bool refresh;
  List<List<String>>? filters;
  String? search;
  GetAllScheduList({
    this.refresh = true,
    this.filters,
    this.search,
  });
}

class ScheduListChangeSearch extends SchedulelistEvent {
  String search = "";
  ScheduListChangeSearch(this.search);
}
