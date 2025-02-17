import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/transaction_provider.dart';
import '../../../../widgets/transaction_tile_widget.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({super.key});

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
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: provider.allTransactionsList.isEmpty
                    ? const Center(child: Text("No transactions available"))
                    : ListView.builder(
                        itemCount: provider.allTransactionsList.length,
                        itemBuilder: (context, index) {
                          final transaction =
                              provider.allTransactionsList[index];
                          return TransactionTileWidget(details: transaction);
                        },
                      ),
              ),
            );
          },
        );
      },
    );
  }
}
