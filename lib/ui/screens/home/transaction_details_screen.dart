import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:xpenso/core/colors.dart';
import '../../../data/model/transaction_model.dart';
import '../../../providers/transaction_provider.dart';
import '../../../utils/formater.dart';
import '../../widgets/theme_container.dart';
import 'edit_transaction_screen.dart';

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
      ),
      body: ThemeContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            children: [
              TransactionAmountCard(transaction: transaction),
              const SizedBox(height: 40),
              TransactionDetails(transaction: transaction),
              Spacer(),
              ActionButtons(
                onDelete: () {
                  transactionProvider.deleteTransaction(transaction.id);
                  Navigator.pop(context);
                },
                onEdit: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          EditTransactionScreen(transaction: transaction)));
                },
              ),
              Spacer(),
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
                color: transaction.type == TransactionType.income
                    ? MyColors.primary
                    : Colors.red),
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

class ActionButtons extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ActionButtons(
      {super.key, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: _buildButton(
              onTap: onDelete,
              icon: Icons.delete_outline,
              text: "Delete",
              colors: [Colors.red.shade700, Colors.red.shade400],
            ),
          ),
          Expanded(
            child: _buildButton(
              onTap: onEdit,
              icon: Icons.edit,
              text: "Edit",
              colors: [Colors.blue.shade700, Colors.blue.shade400],
            ),
          ),
        ],
      ),
    );
  }

  // Gradient Button Widget
  Widget _buildButton({
    required VoidCallback onTap,
    required IconData icon,
    required String text,
    required List<Color> colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: colors.first.withAlpha((0.4 * 255).toInt()),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
