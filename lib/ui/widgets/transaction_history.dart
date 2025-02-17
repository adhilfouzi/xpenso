import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/transaction_provider.dart';
import '../screens/transaction/all/all_transaction_screen.dart';
import 'transaction_tile_widget.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TransactionProvider().init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Transactions History',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AllTransactionScreen())),
                          child: const Text('See All',
                              style: TextStyle(
                                  color: Color(0xFF238C98), fontSize: 16)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: provider.transactions.isEmpty
                          ? const Center(
                              child: Text("No transactions available"))
                          : ListView.builder(
                              itemCount: provider.transactions.length,
                              itemBuilder: (context, index) {
                                final transaction =
                                    provider.transactions[index];
                                return TransactionTileWidget(
                                    details: transaction);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
