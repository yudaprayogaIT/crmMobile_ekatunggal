import 'package:hive/hive.dart';

part 'history_model.g.dart'; // Jangan lupa generate

@HiveType(typeId: 0)
class HistoryModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  UserModel user;

  @HiveField(2)
  String message;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime updatedAt;

  HistoryModel({
    required this.id,
    required this.user,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['_id'],
      user: UserModel.fromJson(json['user']),
      message: json['message'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'user': user.toJson(),
        'message': message,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  static List<HistoryModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HistoryModel.fromJson(json)).toList();
  }
}

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  UserModel({
    required this.id,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['_id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
      };
}
