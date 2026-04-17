// ignore_for_file: unused_local_variable, depend_on_referenced_packages, non_constant_identifier_names, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:ekareach/bloc/visit/visit_bloc.dart';
import 'package:ekareach/helper/calculate_distance.dart';
import 'package:ekareach/helper/network_helper.dart';
// import 'package:ekareach/config/Config.dart';
import 'package:ekareach/models/customer_model.dart';
import 'package:ekareach/models/key_value_model.dart';
import 'package:ekareach/services/hive_service.dart';
import 'package:ekareach/utils/fetch_data.dart';
import 'package:path/path.dart';
import 'package:ekareach/utils/local_data.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  KeyValue? branch;
  KeyValue? group;
  KeyValue? name;
  int? tabActive;
  int page = 1;
  String search = "";
  String url = "";

  String _formatCustomerError(dynamic error) {
    final rawError = error.toString();

    if (rawError.contains('11000')) {
      final duplicateNameMatch = RegExp(
        r'keyValue:\s*\{name:\s*(.+?)\}',
      ).firstMatch(rawError);
      final duplicateName = duplicateNameMatch?.group(1)?.trim();

      if (duplicateName != null && duplicateName.isNotEmpty) {
        return 'Customer dengan nama "$duplicateName" sudah ada.';
      }

      return 'Customer dengan nama yang sama sudah ada.';
    }

    return rawError;
  }

  CustomerBloc() : super(CustomerInitial()) {
    on<ShowCustomer>(_ShowCustomer);
    on<CustomerInsert>(_InsertData);
    on<GetAllCustomer>(_GetAllData);
    on<UpdateCustomer>(_UpdateData);
    on<ChangeImageCustomer>(_ChangeImage);
    on<CustomerChangeSearch>((event, emit) async {
      search = event.search;
    });
    on<CustomerSetForm>((event, emit) {
      if (event.name != null) {
        name = event.name;
      }
      if (event.group != null) {
        group = event.group;
      }
      if (event.branch != null) {
        branch = event.branch;
      }
      emit(CustomerIsLoading());
      emit(CustomerInitial());
    });
    on<CustomerResetForm>((event, emit) {
      if (event.branch) {
        branch = null;
      }
      if (event.name) {
        name = null;
      }

      if (event.group) {
        group = null;
      }
      if (state is CustomerIsLoaded) {
        IsLoaded current = state as IsLoaded;
        emit(CustomerIsLoading());
        emit(
          CustomerIsLoaded(
            hasMore: current.hasMore,
            data: current.data,
            total: current.total,
          ),
        );
      } else {
        emit(CustomerIsLoading());
        emit(CustomerInitial());
      }
    });
  }

  // Future<void> _InsertData(
  //   CustomerInsert event,
  //   Emitter<CustomerState> emit,
  // ) async {
  //   try {
  //     EasyLoading.show(status: 'loading...');
  //     Map<String, dynamic> result =
  //         await FetchData(data: Data.customer).ADD(event.data);

  //     if (result['status'] != 200) {
  //       throw result['msg'];
  //     }

  //     if (!event.callBackValue) {
  //       Get.back();
  //     } else {
  //       emit(CustomerSavedSuccess(data: result['data']));
  //     }
  //     EasyLoading.dismiss();
  //   } catch (e) {
  //     Get.defaultDialog(
  //       // title: "Ups, someting wrong",

  //       content: Text(
  //         e.toString(),
  //       ),
  //       contentPadding: const EdgeInsets.symmetric(
  //         vertical: 10,
  //         horizontal: 20,
  //       ),
  //     );
  //     EasyLoading.dismiss();
  //     emit(CustomerIsFailure(e.toString()));
  //   }
  // }

  Future<void> _InsertData(
    CustomerInsert event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      // Map<String, dynamic> coba = {
      //   '_id': '6892fb8edecc62ad498c158f',
      //   'name': 'kk',
      //   'type': 'Company',
      //   'customerGroup': {'_id': '68197a6fc21da4b9880d97bb', 'name': 'TES'},
      //   'branch': {
      //     '_id': '64800fa2cc19aff39f62d64a',
      //     'name': 'PT. Ekatunggal Tunas Mandiri'
      //   },
      //   'erpId': 'kk',
      //   'createdBy': '64800e61cc19aff39f62d4ea',
      //   'status': 1,
      //   'workflowState': 'Prospek',
      //   'createdAt': '2025-08-06T06:51:58.300Z',
      //   'updatedAt': '2025-08-06T06:51:58.300Z',
      //   '__v': 0
      // };
      // final customer = CustomerModel.fromJson(coba);
      EasyLoading.show(status: 'loading...');

      url = await LocalData().getData("url");
      bool connected = await NetworkHelper.canReachServer();

      if (connected) {
        // ✅ Online → Kirim langsung ke server
        Map<String, dynamic> result =
            await FetchData(data: Data.customer).ADD(event.data);

        if (result['status'] != 200) {
          throw result['msg'];
        }

        // Bisa simpan juga ke Hive kalau mau cache
        final customer = CustomerModel.fromJson(result['data']);

        customer.isSynced = true;

        await HiveService.addItem(
          id: customer.id ?? '',
          item: customer,
          box: HiveService.customerBox,
        );
        print(customer.id);
        print(customer.name);
        var localcustomer = HiveService.getById(
          customer.id!,
          HiveService.customerBox,
        );

        print("ds");
        print(localcustomer?.name);

        if (!event.callBackValue) {
          Get.back();
        } else {
          emit(CustomerSavedSuccess(data: result['data']));
        }
      } else {
        // ❌ Offline → Simpan ke Hive dulu
        final customerBox = HiveService.customerBox;

        final offlineId = DateTime.now().millisecondsSinceEpoch.toString();
        print(event.data);
        final offlineCustomer = CustomerModel.fromJson(event.data);
        offlineCustomer.id = offlineId;
        offlineCustomer.isSynced = false;

        // await HiveService.addCustomer(offlineCustomer);

        // var localcustomer = await HiveService.getCustomerById(offlineId);
        // print(localcustomer);

        if (!event.callBackValue) {
          Get.back();
        } else {
          emit(CustomerSavedSuccess(data: offlineCustomer.toJson()));
        }
      }

      EasyLoading.dismiss();
    } catch (e) {
      final errorMessage = _formatCustomerError(e);
      Get.defaultDialog(
        content: Text(errorMessage),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
      );
      EasyLoading.dismiss();
      emit(CustomerIsFailure(errorMessage));
    }
  }

  // Future<void> _GetAllData(
  //   GetAllCustomer event,
  //   Emitter<CustomerState> emit,
  // ) async {
  //   try {
  //     bool connected = await NetworkHelper.canReachServer(
  //       'https://apicrm.ekatunggal.com/',
  //     );

  //     // List<CustomerModel> allCustomers =
  //     //     HiveService.customerBox.values.toList();
  //     // print(allCustomers.length);
  //     // print(allCustomers[0].name);
  //     if (event.search != null) {
  //       search = event.search!;
  //     }
  //     if (state is CustomerIsLoaded && !event.refresh) {
  //       CustomerIsLoaded current = state as CustomerIsLoaded;

  //       page = current.page;
  //       current.IsloadingPage = true;
  //       emit(
  //         CustomerIsLoaded(
  //           data: current.data,
  //           IsloadingPage: true,
  //           hasMore: current.hasMore,
  //           page: current.page,
  //           total: current.total,
  //         ),
  //       );
  //     } else {
  //       if (event.refresh && event.isLoading) {
  //         EasyLoading.show(status: 'loading...');
  //         emit(CustomerIsLoading());
  //       }
  //     }

  //     late Map<String, dynamic> result;

  //     if (event.nearby != null) {
  //       result = await FetchData(data: Data.customer).FINDALL(
  //           page: event.refresh ? 1 : page,
  //           nearby: "&nearby=[${event.nearby!.lat},${event.nearby!.lng},0]",
  //           filters: event.filters,
  //           search: event.search,
  //           limit: 20);
  //     } else {
  //       result = await FetchData(data: Data.customer).FINDALL(
  //         page: event.refresh ? 1 : page,
  //         filters: event.filters,
  //         search: event.search,
  //         limit: 20,
  //       );
  //     }

  //     if (result['status'] != 200) {
  //       throw result['msg'];
  //     }

  //     List newData = result['data'];

  //     List currentData = [];

  //     if (state is CustomerIsLoaded && !event.refresh) {
  //       CustomerIsLoaded current = state as CustomerIsLoaded;
  //       currentData = current.data;
  //       currentData.addAll(newData);
  //     } else {
  //       currentData = newData;
  //     }

  //     emit(
  //       CustomerIsLoaded(
  //         data: currentData,
  //         hasMore: result['hasMore'],
  //         total: result['total'],
  //         page: result['nextPage'],
  //         IsloadingPage: false,
  //       ),
  //     );
  //     EasyLoading.dismiss();
  //   } catch (e) {
  //     EasyLoading.dismiss();
  //     emit(
  //       CustomerIsFailure(
  //         e.toString(),
  //       ),
  //     );
  //   }
  // }

  Future<void> _GetAllData(
    GetAllCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      url = await LocalData().getData("url");
      bool connected = await NetworkHelper.canReachServer();

      if (event.search != null) {
        search = event.search!;
      }

      if (state is CustomerIsLoaded && !event.refresh) {
        CustomerIsLoaded current = state as CustomerIsLoaded;
        page = current.page;
        emit(current.copyWith(IsloadingPage: true));
      } else if (event.refresh && event.isLoading) {
        EasyLoading.show(status: 'loading...');
        emit(CustomerIsLoading());
      }

      List<CustomerModel> currentData = [];

      if (connected) {
        // ✅ ONLINE mode
        final result = await FetchData(data: Data.customer).FINDALL(
          page: event.refresh ? 1 : page,
          filters: event.filters,
          search: event.search,
          limit: 20,
          nearby: event.nearby != null
              ? "&nearby=[${event.nearby!.lat},${event.nearby!.lng},0]"
              : null,
        );

        if (result['status'] != 200) throw result['msg'];

        final newData = (result['data'] as List).map((item) {
          final customer = CustomerModel.fromJson(item);
          customer.isSynced = true;
          return customer;
        }).toList();

        if (state is CustomerIsLoaded && !event.refresh) {
          currentData = List<CustomerModel>.from(
            (state as CustomerIsLoaded).data,
          )..addAll(newData);
        } else {
          currentData = newData;
        }

        // await SyncService.syncCustomers(mode: SyncMode.mergeUpdate);

        emit(CustomerIsLoaded(
          data: currentData,
          hasMore: result['hasMore'],
          total: result['total'],
          page: result['nextPage'],
          IsloadingPage: false,
        ));
      } else {
        // 🚫 OFFLINE mode
        List<CustomerModel> offlineData =
            HiveService.customerBox.values.toList();

        // 1. Nearby Filter
        if (event.nearby != null) {
          final lat = event.nearby!.lat;
          final lng = event.nearby!.lng;

          offlineData = offlineData.where((customer) {
            if (customer.location?.coordinates?.length != 2) return false;

            final distance = calculateDistance(
              lat,
              lng,
              customer.location!.coordinates![1],
              customer.location!.coordinates![0],
            );

            customer.distance = distance;
            return distance <= 0.15; // ≤ 150 meter
          }).toList();
        }

        // 2. Search Filter
        if (event.search != null && event.search!.isNotEmpty) {
          final q = event.search!.toLowerCase();
          offlineData = offlineData.where((c) {
            return (c.name?.toLowerCase().contains(q) ?? false);
          }).toList();
        }

// Nearby filter
        if (event.nearby != null) {
          final lat = event.nearby!.lat;
          final lng = event.nearby!.lng;

          offlineData = offlineData.where((customer) {
            if (customer.location?.coordinates?.length != 2) return false;

            final distance = calculateDistance(
              lat,
              lng,
              customer.location!.coordinates![1],
              customer.location!.coordinates![0],
            );

            customer.distance = distance;
            return distance <= 0.15;
          }).toList();
        }

// Search filter
        if (event.search != null && event.search!.isNotEmpty) {
          final q = event.search!.toLowerCase();
          offlineData = offlineData.where((c) {
            return (c.name?.toLowerCase().contains(q) ?? false);
          }).toList();
        }

// // Advanced filters
//         if (event.filters != null && event.filters!.isNotEmpty) {
//           for (var filter in event.filters!) {
//             final key = filter[0];
//             final operator = filter[1];
//             final value = filter[2].toString().toLowerCase();

//             offlineData = offlineData.where((customer) {
//               final fieldValue =
//                   customer.toMap()[key]?.toString().toLowerCase();

//               if (fieldValue == null) return false;

//               switch (operator) {
//                 case '=':
//                   return fieldValue == value;
//                 case '!=':
//                   return fieldValue != value;
//                 case 'contains':
//                   return fieldValue.contains(value);
//                 default:
//                   return true; // unknown operator, skip
//               }
//             }).toList();
//           }
//         }

        // // 4. Pagination
        final int pageSize = 20;
        final int currentPage = event.refresh ? 1 : page;
        final int start = (currentPage - 1) * pageSize;
        final int end = (start + pageSize) > offlineData.length
            ? offlineData.length
            : (start + pageSize);

        final paginatedData = offlineData.sublist(start, end);
        final bool hasMore = end < offlineData.length;

        emit(CustomerIsLoaded(
          data: paginatedData,
          hasMore: hasMore,
          total: offlineData.length,
          page: currentPage + 1,
          IsloadingPage: false,
        ));
      }

      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      emit(CustomerIsFailure(e.toString()));
    }
  }

  // Future<void> _ShowCustomer(
  //   ShowCustomer event,
  //   Emitter<CustomerState> emit,
  // ) async {
  //   try {
  //     emit(CustomerIsLoading());
  //     final Map<String, dynamic> response =
  //         await FetchData(data: Data.customer).FINDONE(id: event.customerId);

  //     if (response['status'] != 200) {
  //       throw response['msg'];
  //     }

  //     CustomerModel data = CustomerModel.fromJson(
  //       response['data'],
  //     );
  //     emit(CustomerShowLoaded(data: data));
  //   } catch (e) {
  //     emit(
  //       CustomerIsFailure(
  //         e.toString(),
  //       ),
  //     );
  //   }
  // }

  Future<void> _ShowCustomer(
    ShowCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      emit(CustomerIsLoading());
      url = await LocalData().getData("url");
      bool connected = await NetworkHelper.canReachServer();
      if (connected) {
        // === ONLINE MODE ===
        final Map<String, dynamic> response =
            await FetchData(data: Data.customer).FINDONE(id: event.customerId);

        if (response['status'] != 200) throw response['msg'];

        CustomerModel data = CustomerModel.fromJson(response['data']);

        emit(CustomerShowLoaded(data: data));
      } else {
        // === OFFLINE MODE ===
        final box = HiveService.customerBox;
        final data = box.get(event.customerId);

        if (data == null) {
          emit(CustomerIsFailure(
              'Data customer tidak ditemukan di penyimpanan offline.'));
          return;
        }

        emit(CustomerShowLoaded(data: data));
      }
    } catch (e) {
      emit(CustomerIsFailure(e.toString()));
    }
  }

  Future<void> _UpdateData(
    UpdateCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    try {
      emit(CustomerIsLoading());
      final Map<String, dynamic> response =
          await FetchData(data: Data.customer).UPDATEONE(event.id, event.data);

      if (response['status'] != 200) {
        throw response['msg'];
      }
      add(ShowCustomer(event.id));
    } catch (e) {
      emit(
        CustomerIsFailure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> _ChangeImage(
    ChangeImageCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        var stream = http.ByteStream(pickedFile.openRead())..cast();
        String baseUri = await LocalData().getData("url");
        var request = http.MultipartRequest(
          'PUT',
          Uri.parse("${baseUri}customer/${event.id}"),
        );
        // var request = http.MultipartRequest(
        //   'PUT',
        //   Uri.parse("${Config().baseUri}customer/${event.id}"),
        // );

        var length = await pickedFile.length();
        var multipartFile = http.MultipartFile(
          'img',
          stream,
          length,
          filename: basename(pickedFile.path),
        );

        request.files.add(multipartFile);
        request.headers['authorization'] =
            'Bearer ${await LocalData().getToken()}';
        http.Response response = await http.Response.fromStream(
          await request.send(),
        );

        if (response.statusCode != 200) {
          throw response.body;
        }
        add(ShowCustomer(event.id));
      }
    } catch (e) {
      rethrow;
    }
  }
}
