// ignore_for_file: unnecessary_type_check

import 'package:hive_flutter/hive_flutter.dart';
import 'package:salesappnew/models/customer_model.dart' as customer;
import 'package:salesappnew/models/naming_series_model.dart' as naming_series;
import 'package:salesappnew/models/group_model.dart' as group;
import 'package:salesappnew/models/branch_model.dart' as branch;
import 'package:salesappnew/services/sync_service.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(naming_series.NamingSeriesModelAdapter());
    Hive.registerAdapter(naming_series.BranchModelAdapter());
    Hive.registerAdapter(naming_series.UserModelAdapter());
    Hive.registerAdapter(customer.CustomerModelAdapter());
    Hive.registerAdapter(customer.LocationAdapter());
    Hive.registerAdapter(customer.CustomerGroupAdapter());
    Hive.registerAdapter(customer.BranchAdapter());
    Hive.registerAdapter(customer.CreatedByAdapter());
    Hive.registerAdapter(group.GroupModelAdapter());
    Hive.registerAdapter(group.CreatedByAdapter());
    Hive.registerAdapter(group.ChildAdapter());
    Hive.registerAdapter(branch.BranchModelAdapter());
    Hive.registerAdapter(branch.CreatedByAdapter());

    await Hive.openBox<customer.CustomerModel>('customer');
    await Hive.openBox<naming_series.NamingSeriesModel>('naming_series');
    await Hive.openBox<group.GroupModel>('group');
    await Hive.openBox<branch.BranchModel>('branch');

    await SyncService.syncCustomers(mode: SyncMode.mergeUpdate);
    await SyncService.syncNaming(mode: SyncMode.mergeUpdate);
    await SyncService.syncGroup(mode: SyncMode.mergeUpdate);
    await SyncService.syncBranch(mode: SyncMode.mergeUpdate);
  }

  static Box<customer.CustomerModel> get customerBox =>
      Hive.box<customer.CustomerModel>('customer');

  static Box<naming_series.NamingSeriesModel> get namingBox =>
      Hive.box<naming_series.NamingSeriesModel>('naming_series');

  static Box<group.GroupModel> get groupBox =>
      Hive.box<group.GroupModel>('group');

  static Box<branch.BranchModel> get branchBox =>
      Hive.box<branch.BranchModel>('branch');

  static Future<void> addItems({
    required List items,
    required String Function(dynamic item) getId,
    required Box box,
  }) async {
    final Map<String, dynamic> entries = {
      for (var item in items)
        if (getId(item).isNotEmpty) getId(item): item,
    };
    await box.putAll(entries);
    // await HiveHelper.addItems(
    // items: customers,
    // getId: (c) => c.id ?? '',
    // box: HiveService.customerBox,
    //  );
  }

  static Future<void> addItem({
    required String id,
    required dynamic item,
    required Box box,
  }) async {
    await box.put(id, item);
    //   await HiveHelper.addItem(
    //   id: customer.id ?? '',
    //   item: customer,
    //   box: HiveService.customerBox,
    // );
  }

  static T? getById<T>(String id, Box<T> box) {
    return box.get(id);
    // final visit = HiveHelper.getById('VISIT001', HiveService.visitBox);
  }

  static Future<void> putById<T>(String id, T value, Box<T> box) async {
    await box.put(id, value);
  }

  static Future<void> deleteById<T>(String id, Box<T> box) async {
    await box.delete(id);
  }

  static List<T> getAll<T>(
    Box<T> box, {
    List<String>? fields,
    List<List<String>>? filters,
    Map<String, int>? orderBy,
    String? search,
    String? params,
    int page = 1,
    int limit = 0,
  }) {
    List<T> results = box.values.toList();

    // FILTERS
    if (filters != null) {
      for (var filter in filters) {
        if (filter.length < 3) continue;
        final key = filter[0]; // e.g., 'branch._id'
        final operator = filter[1]; // e.g., '='
        final value = filter[2]; // e.g., '64800fa2cc19aff39f62d64a'

        results = results.where((item) {
          final itemValue = _getFieldValue(item, key);

          switch (operator) {
            case '=':
              return itemValue?.toString() == value;
            case '!=':
              return itemValue?.toString() != value;
            case 'contains':
              return itemValue
                      ?.toString()
                      .toLowerCase()
                      .contains(value.toLowerCase()) ??
                  false;
            case '>':
              return itemValue is Comparable && value is Comparable
                  ? itemValue.compareTo(value) > 0
                  : false;
            case '<':
              return itemValue is Comparable && value is Comparable
                  ? itemValue.compareTo(value) < 0
                  : false;
            default:
              return true;
          }
        }).toList();
      }
    }

    // SEARCH
    if (search != null && search.trim().isNotEmpty) {
      results = results.where((item) {
        final searchable =
            item.toString().toLowerCase(); // Optional: ganti ambil field
        return searchable.contains(search.toLowerCase());
      }).toList();
    }

    // ORDER BY
    if (orderBy != null && orderBy.isNotEmpty) {
      final field = orderBy.keys.first;
      final direction = orderBy.values.first; // 1 = asc, -1 = desc

      results.sort((a, b) {
        final aValue = _getFieldValue(a, field);
        final bValue = _getFieldValue(b, field);

        if (aValue is Comparable && bValue is Comparable) {
          return direction == -1
              ? bValue.compareTo(aValue)
              : aValue.compareTo(bValue);
        }
        return 0;
      });
    }

    // PAGINATION
    if (limit > 0) {
      final start = (page - 1) * limit;
      final end = start + limit;
      if (start < results.length) {
        results =
            results.sublist(start, end > results.length ? results.length : end);
      } else {
        results = [];
      }
    }

    return results;
  }

  // Ambil field nested seperti 'branch._id'
  static dynamic _getFieldValue(Object? item, String fieldName) {
    try {
      // Ubah objek menjadi Map dengan toJson
      Map<String, dynamic> map;
      if (item is Map<String, dynamic>) {
        map = item;
      } else {
        map = item is dynamic ? item.toJson() : {};
      }

      dynamic current = map;
      for (final part in fieldName.split('.')) {
        if (current == null) return null;
        if (current is List) {
          // Ambil dari list pertama
          current = current.isNotEmpty ? current.first : null;
        }

        if (current is Map<String, dynamic>) {
          current = current[part];
        } else if (current is dynamic) {
          try {
            current = current.toJson()[part];
          } catch (_) {
            return null;
          }
        } else {
          return null;
        }
      }

      return current;
    } catch (e) {
      return null;
    }
  }

//   static List<T> getAll<T>(
//     Box<T> box, {
//     List<String>? fields,
//     List<List<String>>? filters,
//     Map<String, int>? orderBy,
//     String? search,
//     String? params,
//     int page = 1,
//     int limit = 0,
//   }) {
//     List<T> results = box.values.toList();

//     // FILTERS
//     if (filters != null) {
//       for (var filter in filters) {
//         if (filter.length < 3) continue;
//         final key = filter[0];
//         final operator = filter[1];
//         final value = filter[2];

//         results = results.where((item) {
//           final itemValue = _getFieldValue(item, key);
//           switch (operator) {
//             case '=':
//               return itemValue?.toString() == value;
//             case '!=':
//               return itemValue?.toString() != value;
//             case 'contains':
//               return itemValue
//                       ?.toString()
//                       .toLowerCase()
//                       .contains(value.toLowerCase()) ??
//                   false;
//             case '>':
//               return itemValue is Comparable && value is Comparable
//                   ? itemValue.compareTo(value) > 0
//                   : false;
//             case '<':
//               return itemValue is Comparable && value is Comparable
//                   ? itemValue.compareTo(value) < 0
//                   : false;
//             default:
//               return true;
//           }
//         }).toList();
//       }
//     }

//     // SEARCH
//     if (search != null && search.trim().isNotEmpty) {
//       results = results.where((item) {
//         final searchable =
//             item.toString().toLowerCase(); // Atau bisa ambil field tertentu
//         return searchable.contains(search.toLowerCase());
//       }).toList();
//     }

//     if (orderBy != null && orderBy.isNotEmpty) {
//       final field = orderBy.keys.first;
//       final direction = orderBy.values.first; // 1 = asc, -1 = desc

//       results.sort((a, b) {
//         final aValue = _getFieldValue(a, field);
//         final bValue = _getFieldValue(b, field);

//         if (aValue is Comparable && bValue is Comparable) {
//           return direction == -1
//               ? bValue.compareTo(aValue)
//               : aValue.compareTo(bValue);
//         }
//         return 0;
//       });
//     }

//     // PAGINATION
//     if (limit > 0) {
//       int start = (page - 1) * limit;
//       int end = start + limit;
//       if (start < results.length) {
//         results =
//             results.sublist(start, end > results.length ? results.length : end);
//       } else {
//         results = [];
//       }
//     }

//     return results;

//     // final naming = HiveService.getAll(
//     //     HiveService.namingBox,
//     //     orderBy: {
//     //       'name': 1,
//     //     },
//     //     filters: [
//     //       ['doc', '=', "visit"],
//     //     ],
//     //   );
//   }

// // Helper untuk ambil field value dari object pakai refleksi sederhana
//   static dynamic _getFieldValue(Object? item, String fieldName) {
//     try {
//       final map = item as dynamic;
//       return map.toJson()[fieldName]; // pastikan model punya toJson()
//     } catch (e) {
//       return null;
//     }
//   }

  /// Hapus semua data dalam box
  static Future<void> clear<T>(Box<T> box) async {
    await box.clear();
  }

  static int count<T>(Box<T> box) {
    return box.length;
  }
}
