// Generated by Hive CE
// Do not modify
// Check in to version control

import 'package:hive_ce/hive.dart';
import 'package:xpenso/data/model/transaction_model.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(TransactionModelAdapter());
    registerAdapter(TransactionTypeAdapter());
  }
}
