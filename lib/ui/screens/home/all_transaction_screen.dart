import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/colors.dart';
import '../../../core/images.dart';
import '../../../data/model/transaction_model.dart';
import '../../../providers/transaction_provider.dart';
import '../../../utils/formater.dart';
import 'home_screen.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: const Text(
          'Transaction',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [MyColors.primary, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: Column(
          children: [
            TransactionAllBar(),
            Expanded(child: TransactionAllHistory())
          ],
        ),
      ),
    );
  }
}

class TransactionAllBar extends StatelessWidget {
  const TransactionAllBar({super.key});

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
                _buildTab("All", 'All', Icons.trending_up, transactionProvider),
                _buildTab(
                    "Income", 'income', Icons.trending_up, transactionProvider),
                _buildTab("Expense", 'expenses', Icons.trending_down,
                    transactionProvider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTab(String text, String type, IconData icon,
      TransactionProvider transactionProvider) {
    bool isSelected = transactionProvider.whichType(type);

    return Expanded(
      child: GestureDetector(
        onTap: () => transactionProvider.setWhichType(type),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          tween: Tween(begin: 1.0, end: isSelected ? 1.1 : 1.0),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.linear,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: isSelected
                      ? [const BoxShadow(color: Colors.black26, blurRadius: 5)]
                      : [],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon,
                        color: isSelected ? Colors.black : Colors.white,
                        size: 18),
                    const SizedBox(width: 6),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      opacity: isSelected ? 1.0 : 0.6,
                      child: Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TransactionAllHistory extends StatelessWidget {
  const TransactionAllHistory({super.key});

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
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Expanded(
                    child: provider.allTransactionsList.isEmpty
                        ? const Center(child: Text("No transactions available"))
                        : ListView.builder(
                            itemCount: provider.allTransactionsList.length,
                            itemBuilder: (context, index) {
                              final transaction =
                                  provider.allTransactionsList[index];
                              return TransactionTileWidget(
                                title: transaction.title,
                                subtitle: Formatter.dateTimetoString(
                                    transaction.date),
                                amount: transaction.amount,
                                isIncome:
                                    transaction.type == TransactionType.income,
                                assetPath: Images.profile[index % 10],
                              );
                            },
                          ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
