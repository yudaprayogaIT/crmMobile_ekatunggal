import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:salesappnew/helper/network_helper.dart';
import 'package:salesappnew/models/customer_model.dart';
import 'package:salesappnew/models/group_model.dart';
import 'package:salesappnew/models/branch_model.dart' as branch;
import 'package:salesappnew/models/naming_series_model.dart';
import 'package:salesappnew/utils/fetch_data.dart';
import 'package:salesappnew/utils/local_data.dart';
import 'hive_service.dart';

enum SyncMode {
  mergeUpdate, // Update data yang berubah saja
  fullReplace, // Hapus semua lokal, ambil ulang dari server
}

class SyncService {
  static Future<void> syncData<T>({
    required SyncMode mode,
    required Data dataType,
    required List<String> fields,
    required T Function(Map<String, dynamic> json) fromJson,
    required Box<T> box,
    List<List<String>>? filters,
    required String Function(T model) getId,
    required DateTime? Function(T model) getUpdatedAt,
    void Function(T model)? onBeforeSave,
  }) async {
    String? token = await LocalData().getToken();
    if (token == null) return;

    bool connected = await NetworkHelper.canReachServer();
    if (!connected) return;

    final result = await FetchData(data: dataType).FINDALL(
      page: 1,
      fields: fields,
      filters: filters,
      limit: 0,
    );

    if (result['status'] != 200) throw result['msg'];

    final List fetchedData = result['data'];
    final List<T> apiItems = fetchedData.map((e) => fromJson(e)).toList();

    if (mode == SyncMode.fullReplace) {
      await box.clear();
      for (var item in apiItems) {
        onBeforeSave?.call(item);
        await box.put(getId(item), item);
      }
      return;
    }

    // --- MERGE UPDATE MODE ---
    final List<T> localItems = box.values.toList();
    final Map<String, T> localMap = {
      for (var item in localItems) getId(item): item,
    };

    for (var apiItem in apiItems) {
      onBeforeSave?.call(apiItem);
      final localItem = localMap[getId(apiItem)];

      final bool shouldUpdate = localItem == null ||
          getUpdatedAt(localItem) == null ||
          (getUpdatedAt(apiItem) != null &&
              getUpdatedAt(apiItem)!.isAfter(getUpdatedAt(localItem)!));

      if (shouldUpdate) {
        await box.put(getId(apiItem), apiItem);
      }
    }

    // Hapus data lokal yang tidak ada di API
    final Set<String> apiIds = apiItems.map((e) => getId(e)).toSet();
    for (var local in localItems) {
      if (!apiIds.contains(getId(local))) {
        await box.delete(getId(local));
      }
    }
  }

  static Future<void> syncCustomers({required SyncMode mode}) async {
    await syncData<CustomerModel>(
      mode: mode,
      dataType: Data.customer,
      fields: [
        'id',
        'name',
        'address',
        'img',
        'type',
        'erpId',
        'createdBy',
        'branch',
        'customerGroup',
        'location',
        'status',
        'workflowState',
        'createdAt',
        'updatedAt',
      ],
      fromJson: CustomerModel.fromJson,
      box: HiveService.customerBox,
      filters: [],
      getId: (model) => model.id!,
      getUpdatedAt: (model) => model.updatedAt,
      onBeforeSave: (model) {
        model.isSynced = true;
      },
    );
  }

  static Future<void> syncNaming({required SyncMode mode}) async {
    await syncData<NamingSeriesModel>(
      mode: mode,
      dataType: Data.namingSeries,
      fields: [
        'id',
        'name',
        'branch',
        'doc',
        'status',
        'workflowState',
        'createdAt',
        'updatedAt',
      ],
      fromJson: NamingSeriesModel.fromJson,
      box: HiveService.namingBox,
      filters: [],
      getId: (model) => model.id!,
      getUpdatedAt: (model) => model.updatedAt,
      onBeforeSave: (model) {
        model.isSynced = true;
      },
    );
  }

  static Future<void> syncGroup({required SyncMode mode}) async {
    await syncData<GroupModel>(
      mode: mode,
      dataType: Data.customergroup,
      fields: [
        'id',
        'name',
        'parent',
        'branch',
        'createdBy',
        'status',
        'workflowState',
        'createdAt',
        'updatedAt',
      ],
      fromJson: GroupModel.fromJson,
      box: HiveService.groupBox,
      filters: [],
      getId: (model) => model.id!,
      getUpdatedAt: (model) => model.updatedAt,
      onBeforeSave: (model) {
        model.isSynced = true;
      },
    );
  }

  static Future<void> syncBranch({required SyncMode mode}) async {
    await syncData<branch.BranchModel>(
      mode: mode,
      dataType: Data.branch,
      fields: [
        'id',
        'name',
        'createdBy',
        'status',
        'workflowState',
        'updatedAt',
      ],
      fromJson: branch.BranchModel.fromJson,
      box: HiveService.branchBox,
      filters: [],
      getId: (model) => model.id!,
      getUpdatedAt: (model) => model.updatedAt,
      onBeforeSave: (model) {
        model.isSynced = true;
      },
    );
  }

  static Timer? _syncTimer;

  static void startSyncLoop() {
    if (_syncTimer != null && _syncTimer!.isActive) return;
    _syncTimer = Timer.periodic(const Duration(minutes: 10), (_) async {
      await syncCustomers(mode: SyncMode.mergeUpdate);
      await syncNaming(mode: SyncMode.mergeUpdate);
      await syncGroup(mode: SyncMode.mergeUpdate);
      await syncBranch(mode: SyncMode.mergeUpdate);
    });
  }

  static void stopSync() {
    _syncTimer?.cancel();
  }
}
