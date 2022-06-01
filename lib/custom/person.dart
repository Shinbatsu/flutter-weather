import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 10)
class Person {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final num age;
  Person({required this.name, required this.age});
}
