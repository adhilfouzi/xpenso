import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xpenso/core/colors.dart';
import '../../../data/model/transaction_model.dart';
import '../../../providers/transaction_provider.dart';
import '../../../utils/formater.dart';
import '../../widgets/theme_container.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text(
          "Transaction Details",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: MyColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.white),
            onPressed: () {
              transactionProvider.deleteTransaction(transaction.id);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ThemeContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            children: [
              TransactionAmountCard(transaction: transaction),
              const SizedBox(height: 40),
              TransactionDetails(transaction: transaction),
            ],
          ),
        ),
      ),
    );
  }
}

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
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: MyColors.primary),
          ),
        ),
      ],
    );
  }
}

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
            value: DateFormat('MMM dd, yyyy').format(transaction.date)),
        TextRowWidget(
            icon: Icons.access_time,
            label: "Time",
            value: DateFormat('hh:mm a').format(transaction.date)),
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

class TextRowWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const TextRowWidget(
      {super.key,
      required this.icon,
      required this.label,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: MyColors.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Spacer(),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.clip,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
