import 'package:hive/hive.dart';

part 'callsheetnote_model.g.dart';

@HiveType(typeId: 1)
class CallsheetNoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String callsheet;

  @HiveField(3)
  List<Map<dynamic, dynamic>> tags;

  @HiveField(4)
  String notes;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  @HiveField(7)
  bool isSynced;

  @HiveField(8)
  bool isDeletedOffline;

  @HiveField(9)
  String? pendingAction; // 'create', 'update', 'delete'

  @HiveField(10)
  DateTime? lastModified;

  CallsheetNoteModel({
    required this.id,
    required this.title,
    required this.callsheet,
    required this.tags,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = true,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory CallsheetNoteModel.fromJson(Map<String, dynamic> json) {
    return CallsheetNoteModel(
      id: json['_id'],
      title: json['title'],
      callsheet: json['callsheet'],
      tags: List<Map>.from(json['tags']),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isSynced: json['isSynced'] ?? true,
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
      'title': title,
      'callsheet': callsheet,
      'tags': tags,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isSynced': isSynced,
      'isDeletedOffline': isDeletedOffline,
      'pendingAction': pendingAction,
      'lastModified': lastModified?.toIso8601String(),
    };
  }

  static List<CallsheetNoteModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CallsheetNoteModel.fromJson(json)).toList();
  }
}
