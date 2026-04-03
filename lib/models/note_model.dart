import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? task;

  @HiveField(2)
  Doc? doc;

  @HiveField(3)
  Branch? customer;

  @HiveField(4)
  Branch? topic;

  @HiveField(5)
  List<Branch>? tags;

  @HiveField(6)
  String? result;

  @HiveField(7)
  String? response;

  @HiveField(8)
  Branch? createdBy;

  @HiveField(9)
  DateTime? createdAt;

  @HiveField(10)
  DateTime? updatedAt;

  @HiveField(11)
  Branch? customerGroup;

  @HiveField(12)
  Branch? branch;

  // === Tambahan field sync ===
  @HiveField(13)
  bool isSynced;

  @HiveField(14)
  bool isDeletedOffline;

  @HiveField(15)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(16)
  DateTime? lastModified;

  NoteModel({
    this.id,
    this.task,
    this.doc,
    this.customer,
    this.topic,
    this.tags,
    this.result,
    this.response,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.customerGroup,
    this.branch,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
        id: json["_id"],
        task: json["task"],
        response: json["response"],
        doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
        customer:
            json["customer"] == null ? null : Branch.fromJson(json["customer"]),
        topic: json["topic"] == null ? null : Branch.fromJson(json["topic"]),
        tags: json["tags"] == null
            ? []
            : List<Branch>.from(json["tags"]!.map((x) => Branch.fromJson(x))),
        result: json["result"],
        createdBy: json["createdBy"] == null
            ? null
            : Branch.fromJson(json["createdBy"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        customerGroup: json["customerGroup"] == null
            ? null
            : Branch.fromJson(json["customerGroup"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        isSynced: json["isSynced"] ?? false,
        isDeletedOffline: json["isDeletedOffline"] ?? false,
        pendingAction: json["pendingAction"],
        lastModified: json["lastModified"] == null
            ? null
            : DateTime.parse(json["lastModified"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "task": task,
        "response": response,
        "doc": doc?.toJson(),
        "customer": customer?.toJson(),
        "topic": topic?.toJson(),
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "result": result,
        "createdBy": createdBy?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "customerGroup": customerGroup?.toJson(),
        "branch": branch?.toJson(),
        "isSynced": isSynced,
        "isDeletedOffline": isDeletedOffline,
        "pendingAction": pendingAction,
        "lastModified": lastModified?.toIso8601String(),
      };

  static List<NoteModel> fromJsonList(List<dynamic> jsonList) =>
      jsonList.map((json) => NoteModel.fromJson(json)).toList();
}

@HiveType(typeId: 1)
class Branch {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  Branch({this.id, this.name});

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

@HiveType(typeId: 2)
class Doc {
  @HiveField(0)
  String? type;

  @HiveField(1)
  String? id;

  @HiveField(2)
  String? name;

  Doc({this.type, this.id, this.name});

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        type: json["type"],
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "_id": id,
        "name": name,
      };
}
