import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/colors.dart';
import '../../../providers/transaction_provider.dart';
import '../../../data/model/transaction_model.dart';
import '../../../utils/formater.dart';
import '../../widgets/theme_container.dart';
import 'transaction_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: const HeaderWidget(),
      body: ThemeContainer(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: const BalanceCardWidget(),
          ),
          Expanded(child: TransactionHistory()),
        ],
      )),
    );
  }
}

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
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
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
                            onPressed: () {},
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
              ),
            );
          },
        );
      },
    );
  }
}

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.primary,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Good afternoon,',
              style: TextStyle(fontSize: 16, color: Colors.black54)),
          Text('Enjelin Morgeana',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class BalanceCardWidget extends StatelessWidget {
  const BalanceCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF238C98),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Total Balance',
              style: TextStyle(color: Colors.white70, fontSize: 18)),
          const SizedBox(height: 10),
          Text(Formatter.formatCurrency(transactionProvider.totalBalance),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _balanceItem('Income',
                  Formatter.formatCurrency(transactionProvider.income)),
              _balanceItem('Expenses',
                  Formatter.formatCurrency(transactionProvider.expenses)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _balanceItem(String title, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(color: Colors.white70, fontSize: 16)),
        Text(amount,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class TransactionTileWidget extends StatelessWidget {
  final TransactionModel details;

  const TransactionTileWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    bool isIncome = TransactionType.income == details.type;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TransactionDetailsScreen(
                transaction: details,
              ))),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          // leading: CircleAvatar(
          //   backgroundImage: AssetImage(assetPath),
          //   radius: 30,
          // ),
          title: Text(details.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          subtitle: Text(Formatter.dateTimetoString(details.date),
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          trailing: Text(
            '${isIncome ? '+ ' : '- '}₹${details.amount.toStringAsFixed(2)}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isIncome ? Colors.green : Colors.red),
          ),
        ),
      ),
    );
  }
}
