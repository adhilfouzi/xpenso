import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../core/snackbar.dart';
import '../../../data/model/transaction_model.dart';
import '../../../providers/transaction_provider.dart';
import '../../../utils/formater.dart';
import '../../widgets/theme_container.dart';
import 'add_transaction_screen.dart';

class EditTransactionScreen extends StatelessWidget {
  final TransactionModel transaction;
  const EditTransactionScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final nameController = TextEditingController(text: transaction.title);
    final amountController =
        TextEditingController(text: transaction.amount.toString());
    final descriptionController =
        TextEditingController(text: transaction.description);
    final dateController =
        TextEditingController(text: Formatter.datetoString(transaction.date));
    final screen = MediaQuery.of(context).size;
    log('Transaction edited: ${transaction.id}');

    return KeyboardDismissOnTap(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Edit Transaction",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: ThemeContainer(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screen.width * 0.055,
                  vertical: screen.height * 0.25),
              child: Column(
                children: [
                  CustomTextField(
                      controller: nameController,
                      label: "Name",
                      icon: Icons.person),
                  CustomTextField(
                      controller: amountController,
                      label: "Amount",
                      icon: Icons.attach_money,
                      isNumber: true),
                  CustomTextField(
                      controller: descriptionController,
                      label: "Description",
                      icon: Icons.description),
                  CustomTextField(
                      controller: dateController,
                      label: "Date",
                      icon: Icons.calendar_today,
                      isDate: true),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (nameController.text.isEmpty ||
                                amountController.text.isEmpty ||
                                dateController.text.isEmpty) {
                              MySnackbar.showError(
                                  context, 'Please fill in all fields');
                              return;
                            }
                            transactionProvider.editTransaction(
                              TransactionModel(
                                id: transaction.id,
                                title: nameController.text,
                                amount:
                                    double.tryParse(amountController.text) ??
                                        0.0,
                                description: descriptionController.text,
                                date: Formatter.stringToDateTime(
                                    dateController.text),
                                type:
                                    transaction.type == TransactionType.expense
                                        ? TransactionType.expense
                                        : TransactionType.income,
                              ),
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            backgroundColor:
                                transaction.type == TransactionType.expense
                                    ? Colors.redAccent
                                    : Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text(
                            transaction.type == TransactionType.expense
                                ? "Save Expense"
                                : "Save Income",
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
