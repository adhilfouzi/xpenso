import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import '../data/model/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  static const String _transactionsBoxName = "transactionsBox";
  static const String _balanceBoxName = "balanceBox";

  late Box<TransactionModel> _transactionBox;
  late Box<double> _balanceBox;

  List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;
  List<TransactionModel> _allTransactions = [];
  List<TransactionModel> get allTransactionsList => _allTransactions;

  double _totalIncome = 0.0;
  double _totalExpenses = 0.0;
  bool isExpense = true;
  String transactionsType = 'All';

  double get totalIncome => _totalIncome;
  double get totalExpenses => _totalExpenses;
  double get balance => _totalIncome - _totalExpenses;

  double _income = 0.00;
  double _expenses = 0.00;
  double get income => _income;
  double get expenses => _expenses;
  double get totalBalance => _income - _expenses;

  List<TransactionModel> _filteredTransactions = [];
  List<TransactionModel> get filteredTransactions => _filteredTransactions;

  TransactionProvider() {
    init();
  }
  bool whichType(String value) {
    return transactionsType == value;
  }

  /// Initialize Hive and Load Data
  Future<void> init() async {
    if (Hive.isBoxOpen(_transactionsBoxName)) {
      _transactionBox = Hive.box<TransactionModel>(_transactionsBoxName);
    } else {
      _transactionBox =
          await Hive.openBox<TransactionModel>(_transactionsBoxName);
    }

    if (Hive.isBoxOpen(_balanceBoxName)) {
      _balanceBox = Hive.box<double>(_balanceBoxName);
    } else {
      _balanceBox = await Hive.openBox<double>(_balanceBoxName);
    }

    _income = _balanceBox.get("income", defaultValue: 0.00)!;
    _expenses = _balanceBox.get("expenses", defaultValue: 0.00)!;
    _transactions = _transactionBox.values.toList();
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    _filteredTransactions = List.from(_transactions);

    _calculateTotals();
    setWhichType();
    notifyListeners();
  }

  void _updateBalanceBox(String key, double value) {
    if (_balanceBox.isOpen) {
      _balanceBox.put(key, value);
    }
    setWhichType();
  }

  void updateIncome(double amount) {
    _income += amount;
    _updateBalanceBox("income", _income);
    notifyListeners();
  }

  void updateExpenses(double amount) {
    _expenses += amount;
    _updateBalanceBox("expenses", _expenses);
    notifyListeners();
  }

  Future<void> resetBalance() async {
    _income = 0.00;
    _expenses = 0.00;
    await _balanceBox.putAll({"income": _income, "expenses": _expenses});
    notifyListeners();
  }

  void updateFromTransactions(double newIncome, double newExpenses) {
    _income = newIncome;
    _expenses = newExpenses;
    _updateBalanceBox("income", _income);
    _updateBalanceBox("expenses", _expenses);
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    _allTransactions = List.from(_transactions);
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _transactionBox.put(transaction.id, transaction);
    _transactions.add(transaction);
    _updateTotals(transaction, isAdding: true);
    notifyListeners();
  }

  Future<void> editTransaction(TransactionModel updatedTransaction) async {
    int index = _transactions.indexWhere((t) => t.id == updatedTransaction.id);
    if (index != -1) {
      TransactionModel oldTransaction = _transactions[index];
      _transactions[index] = updatedTransaction;

      await _transactionBox.put(updatedTransaction.id, updatedTransaction);
      _updateTotals(oldTransaction, isAdding: false);
      _updateTotals(updatedTransaction, isAdding: true);
      updateFromTransactions(_totalIncome, _totalExpenses);
      log('Transaction edited: ${updatedTransaction.id}');
      notifyListeners();
    } else {
      log('Transaction not found: ${updatedTransaction.id}');
    }
  }

  Future<void> deleteTransaction(String id) async {
    TransactionModel? transaction = _transactionBox.get(id);
    if (transaction != null) {
      await _transactionBox.delete(id);
      _transactions.removeWhere((t) => t.id == id);
      _totalIncome -=
          transaction.type == TransactionType.income ? transaction.amount : 0;
      _totalExpenses -=
          transaction.type == TransactionType.expense ? transaction.amount : 0;
      updateFromTransactions(_totalIncome, _totalExpenses);
      notifyListeners();
    }
  }

  List<TransactionModel> get expenseTransactions =>
      _transactions.where((t) => t.type == TransactionType.expense).toList();

  List<TransactionModel> get incomeTransactions =>
      _transactions.where((t) => t.type == TransactionType.income).toList();

  void _calculateTotals() {
    _totalIncome = _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
    _totalExpenses = _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);

    updateFromTransactions(_totalIncome, _totalExpenses);
  }

  void _updateTotals(TransactionModel transaction, {required bool isAdding}) {
    double amount = isAdding ? transaction.amount : -transaction.amount;
    if (transaction.type == TransactionType.income) {
      _totalIncome += amount;
    } else {
      _totalExpenses += amount;
    }
    updateFromTransactions(_totalIncome, _totalExpenses);
  }

  void setIsExpense(bool value) {
    isExpense = value;
    notifyListeners();
  }

  void setWhichType() {
    String value = transactionsType;
    if (value == 'expenses') {
      _allTransactions = _filteredTransactions
          .where((t) => t.type == TransactionType.expense)
          .toList();
    } else if (value == 'income') {
      _allTransactions = _filteredTransactions
          .where((t) => t.type == TransactionType.income)
          .toList();
    } else {
      _allTransactions = List.from(_filteredTransactions);
    }

    notifyListeners();
  }

  void filterTransactionsByDateRange(DateTime fromDate, DateTime toDate) {
    _filteredTransactions = _transactions.where((t) {
      return t.date.isAfter(fromDate.subtract(Duration(days: 1))) &&
          t.date.isBefore(toDate.add(Duration(days: 1)));
    }).toList();
    setWhichType();
    notifyListeners();
  }
}
