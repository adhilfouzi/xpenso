import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xpenso/core/colors.dart';
import '../../../../data/model/transaction_model.dart';
import '../../../../providers/transaction_provider.dart';
import '../../../widgets/theme_container.dart';
import '../add&edit/edit_transaction_screen.dart';
import 'widget/action_button.dart';
import 'widget/transaction_amount_widget.dart';
import 'widget/transaction_details_widget.dart';

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
