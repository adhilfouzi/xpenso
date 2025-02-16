import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/transaction_provider.dart';
import 'card_text_widget.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.2 * 255).toInt()),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Consumer<TransactionProvider>(
          builder: (context, transactionProvider, child) {
            return Row(
              children: [
                CardText(
                    text: "All",
                    type: 'All',
                    icon: Icons.trending_up,
                    transactionProvider: transactionProvider),
                CardText(
                    text: "Income",
                    type: 'income',
                    icon: Icons.trending_up,
                    transactionProvider: transactionProvider),
                CardText(
                    text: "Expense",
                    type: 'expenses',
                    icon: Icons.trending_down,
                    transactionProvider: transactionProvider),
              ],
            );
          },
        ),
      ),
    );
  }
}
