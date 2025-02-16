import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/snackbar.dart';
import '../../../../../data/model/transaction_model.dart';
import '../../../../../providers/transaction_provider.dart';
import '../../../../../utils/formater.dart';
import '../../../../widgets/text_field.dart';

class TransactionForm extends StatelessWidget {
  final TransactionModel? transaction; // Null for Add, populated for Edit
  const TransactionForm({super.key, this.transaction});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final isEditing = transaction != null;

    final nameController =
        TextEditingController(text: transaction?.title ?? '');
    final amountController =
        TextEditingController(text: transaction?.amount.toString() ?? '');
    final descriptionController =
        TextEditingController(text: transaction?.description ?? '');
    final dateController = TextEditingController(
        text: transaction != null
            ? Formatter.datetoString(transaction!.date)
            : '');

    void saveTransaction() {
      if (nameController.text.isEmpty ||
          amountController.text.isEmpty ||
          dateController.text.isEmpty) {
        MySnackbar.showError(context, 'Please fill in all fields');
        return;
      }

      final newTransaction = TransactionModel(
        id: transaction?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: nameController.text,
        amount: double.tryParse(amountController.text) ?? 0.0,
        description: descriptionController.text,
        date: Formatter.stringToDateTime(dateController.text),
        type: transaction?.type ??
            (transactionProvider.isExpense
                ? TransactionType.expense
                : TransactionType.income),
      );

      if (isEditing) {
        transactionProvider.editTransaction(newTransaction);
      } else {
        transactionProvider.addTransaction(newTransaction);
      }

      Navigator.pop(context);
    }

    return Column(
      children: [
        MyTextField(
            controller: nameController, label: "Name", icon: Icons.person),
        MyTextField(
            controller: amountController,
            label: "Amount",
            icon: Icons.attach_money,
            isNumber: true),
        MyTextField(
            controller: descriptionController,
            label: "Description",
            icon: Icons.description),
        MyTextField(
            controller: dateController,
            label: "Date",
            icon: Icons.calendar_today,
            isDate: true),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: saveTransaction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor:
                      (transaction?.type ?? transactionProvider.isExpense) ==
                              TransactionType.expense
                          ? Colors.redAccent
                          : Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                  isEditing
                      ? (transaction!.type == TransactionType.expense
                          ? "Save Expense"
                          : "Save Income")
                      : "Add Transaction",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
