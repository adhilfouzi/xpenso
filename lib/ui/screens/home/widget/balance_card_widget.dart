import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/transaction_provider.dart';
import '../../../../utils/formater.dart';
import 'balance_text.dart';

class BalanceCardWidget extends StatelessWidget {
  const BalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF238C98),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Balance',
              style: TextStyle(color: Colors.white70, fontSize: 18)),
          const SizedBox(height: 10),
          Text(Formatter.formatCurrency(transactionProvider.totalBalance),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BalanceText(
                title: 'Income',
                amount: Formatter.formatCurrency(transactionProvider.income),
              ),
              BalanceText(
                title: 'Expenses',
                amount: Formatter.formatCurrency(transactionProvider.expenses),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
