import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'post_model.g.dart'; // Generated file

@HiveType(typeId: 0)
class Post extends HiveObject {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final int id;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });
}