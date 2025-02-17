import 'package:flutter/material.dart';

import '../../../../../core/colors.dart';
import '../../../../../data/models/transaction_model.dart';
import '../../../../../utils/formater.dart';

class TransactionAmountCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionAmountCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          Formatter.formatRuppe(transaction.amount),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 1),
            ],
          ),
          child: Text(
            transaction.type == TransactionType.income ? "Income" : "Expense",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: transaction.type == TransactionType.income
                      ? MyColors.primary
                      : Colors.red,
                ),
          ),
        ),
      ],
    );
  }
}
