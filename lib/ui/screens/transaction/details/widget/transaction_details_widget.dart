import 'package:flutter/material.dart';

import '../../../../../data/model/transaction_model.dart';
import '../../../../../utils/formater.dart';
import 'text_row_widget.dart';

class TransactionDetails extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionDetails({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextRowWidget(
            icon: Icons.title, label: "Title", value: transaction.title),
        TextRowWidget(
            icon: Icons.calendar_today,
            label: "Date",
            value: Formatter.dateTimetoString(transaction.date)),
        TextRowWidget(
            icon: Icons.access_time,
            label: "Time",
            value: Formatter.timetoString(transaction.date)),
        TextRowWidget(
            icon: Icons.description,
            label: "Description",
            value: transaction.description.isNotEmpty
                ? transaction.description
                : "No description"),
        TextRowWidget(
            icon: Icons.category,
            label: "Type",
            value: transaction.type == TransactionType.income
                ? "Income"
                : "Expense"),
      ],
    );
  }
}
