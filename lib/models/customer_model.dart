import 'package:hive/hive.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 10)
class CustomerModel extends HiveObject {
  @HiveField(0)
  Location? location;

  @HiveField(1)
  String? id;

  @HiveField(2)
  String? img;

  @HiveField(3)
  String? name;

  @HiveField(4)
  String? address;

  @HiveField(5)
  String? type;

  @HiveField(6)
  CustomerGroup? customerGroup;

  @HiveField(7)
  Branch? branch;

  @HiveField(8)
  String? erpId;

  @HiveField(9)
  CreatedBy? createdBy;

  @HiveField(10)
  String? status;

  @HiveField(11)
  String? workflowState;

  @HiveField(12)
  DateTime? createdAt;

  @HiveField(13)
  DateTime? updatedAt;

  // sync fields for offline sync
  @HiveField(14)
  bool isSynced = false;

  @HiveField(15)
  bool isDeletedOffline = false;

  @HiveField(16)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(17)
  DateTime? lastModified;

  @HiveField(18)
  double? distance;

  CustomerModel(
      {this.location,
      this.img,
      this.id,
      this.name,
      this.address,
      this.type,
      this.customerGroup,
      this.branch,
      this.erpId,
      this.createdBy,
      this.status,
      this.workflowState,
      this.createdAt,
      this.updatedAt,
      this.isSynced = false,
      this.isDeletedOffline = false,
      this.pendingAction,
      this.lastModified,
      this.distance});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      id: json['_id'],
      name: json['name'],
      img: json['img'],
      address: json['address'],
      type: json['type'],
      customerGroup: json['customerGroup'] != null
          ? CustomerGroup.fromJson(json['customerGroup'])
          : null,
      branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
      distance: json['distance'] != null
          ? (json['distance'] as num).toDouble()
          : null,
      erpId: json['erpId'],
      // createdBy: json['createdBy'] != null
      //     ? CreatedBy.fromJson(json['createdBy'])
      //     : null,
      status: json['status'],
      workflowState: json['workflowState'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      // sync fields jika ada di json (optional)
      isSynced: json['isSynced'] ?? false,
      isDeletedOffline: json['isDeletedOffline'] ?? false,
      pendingAction: json['pendingAction'],
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'img': img,
      'name': name,
      'address': address,
      'type': type,
      'erpId': erpId,
      'status': status,
      'workflowState': workflowState,
      'isSynced': isSynced,
      'isDeletedOffline': isDeletedOffline,
      'pendingAction': pendingAction,
      'distance': distance,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'lastModified': lastModified?.toIso8601String(),

      // Nested objek harus dikonversi ke json juga
      'location': location?.toJson(),
      'customerGroup': customerGroup?.toJson(),
      'branch': branch?.toJson(),
      'createdBy': createdBy?.toJson(),
    };
  }

  static List<CustomerModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerModel.fromJson(json)).toList();
  }
}

@HiveType(typeId: 11)
class Location extends HiveObject {
  @HiveField(0)
  String? type;

  @HiveField(1)
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: json['coordinates'] != null
          ? List<double>.from(json['coordinates'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}

@HiveType(typeId: 12)
class CustomerGroup extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  CustomerGroup({
    this.id,
    this.name,
  });

  factory CustomerGroup.fromJson(Map<String, dynamic> json) {
    return CustomerGroup(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

@HiveType(typeId: 13)
class Branch extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  Branch({
    this.id,
    this.name,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

@HiveType(typeId: 14)
class CreatedBy extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  CreatedBy({
    this.id,
    this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['_id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}

extension CustomerModelMap on CustomerModel {
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'img': img,
      'name': name,
      'address': address,
      'type': type,
      'erpId': erpId,
      'status': status,
      'workflowState': workflowState,
      'isSynced': isSynced,
      'isDeletedOffline': isDeletedOffline,
      'pendingAction': pendingAction,
      'distance': distance?.toString(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'lastModified': lastModified?.toIso8601String(),

      // Untuk nested object, ambil properti yang umum digunakan
      'location': location?.toString(),
      'customerGroup': customerGroup?.name,
      'branch': branch?.name,
      'createdBy': createdBy?.name,
    };
  }
}

// extension CustomerModelJson on CustomerModel {

// }
