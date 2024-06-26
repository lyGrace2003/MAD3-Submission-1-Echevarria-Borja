import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Session {
  @HiveField(0)
  final String token;

  Session({required this.token});
}
