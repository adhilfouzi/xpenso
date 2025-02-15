import 'package:hive_ce/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
enum TransactionType {
  @HiveField(0)
  income,

  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class TransactionModel {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String description;

  @HiveField(5)
  TransactionType type;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.description,
    required this.type,
  });
}
