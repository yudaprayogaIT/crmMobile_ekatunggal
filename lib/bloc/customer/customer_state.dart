// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, must_be_immutable
part of 'customer_bloc.dart';

@immutable
abstract class CustomerState {}

class CustomerInitial extends CustomerState {}

class CustomerIsLoading extends CustomerState {}

class CustomerIsFailure extends CustomerState {
  String error;
  CustomerIsFailure(this.error);
}

class CustomerIsLoaded extends CustomerState {
  List data;
  bool hasMore;
  bool pageLoading;
  int page;
  int total;
  bool IsloadingPage;

  CustomerIsLoaded({
    required this.data,
    this.hasMore = false,
    this.pageLoading = false,
    this.page = 1,
    this.total = 1,
    this.IsloadingPage = false,
  });

  CustomerIsLoaded copyWith({
    List? data,
    bool? hasMore,
    bool? pageLoading,
    int? page,
    int? total,
    bool? IsloadingPage,
  }) {
    return CustomerIsLoaded(
      data: data ?? this.data,
      hasMore: hasMore ?? this.hasMore,
      pageLoading: pageLoading ?? this.pageLoading,
      page: page ?? this.page,
      total: total ?? this.total,
      IsloadingPage: IsloadingPage ?? this.IsloadingPage,
    );
  }
}

class CustomerShowLoaded extends CustomerState {
  CustomerModel data;
  CustomerShowLoaded({
    required this.data,
  });
}

class CustomerSavedSuccess extends CustomerState {
  Map<String, dynamic> data;
  CustomerSavedSuccess({
    required this.data,
  });
}
