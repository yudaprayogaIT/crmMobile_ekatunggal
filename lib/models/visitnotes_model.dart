import 'package:hive/hive.dart';

part 'visitnotes_model.g.dart';

@HiveType(typeId: 60)
class VisitNoteModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String visit;

  @HiveField(3)
  List<Map> tags;

  @HiveField(4)
  String notes;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  // Sync fields
  @HiveField(7)
  bool isSynced;

  @HiveField(8)
  bool isDeletedOffline;

  @HiveField(9)
  String? pendingAction; // create, update, delete

  @HiveField(10)
  DateTime? lastModified;

  VisitNoteModel({
    required this.id,
    required this.title,
    required this.visit,
    required this.tags,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isSynced = false,
    this.isDeletedOffline = false,
    this.pendingAction,
    this.lastModified,
  });

  factory VisitNoteModel.fromJson(Map<String, dynamic> json) {
    return VisitNoteModel(
      id: json['_id'],
      title: json['title'],
      visit: json['visit'],
      tags: List<Map>.from(json['tags']),
      notes: json['notes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      isSynced: json['isSynced'] ?? false,
      isDeletedOffline: json['isDeletedOffline'] ?? false,
      pendingAction: json['pendingAction'],
      lastModified: json['lastModified'] != null
          ? DateTime.parse(json['lastModified'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'visit': visit,
        'tags': tags,
        'notes': notes,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'isSynced': isSynced,
        'isDeletedOffline': isDeletedOffline,
        'pendingAction': pendingAction,
        'lastModified': lastModified?.toIso8601String(),
      };

  static List<VisitNoteModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => VisitNoteModel.fromJson(json)).toList();
  }
}
