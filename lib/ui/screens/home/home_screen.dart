import 'package:flutter/material.dart';

import '../../../core/images.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),
      appBar: const HeaderWidget(),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            const BalanceCardWidget(),
            const Expanded(child: TransactionHistoryWidget()),
          ],
        ),
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
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
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color(0xFF238C98),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
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
          Text('Total Balance',
              style: TextStyle(color: Colors.white70, fontSize: 18)),
          SizedBox(height: 10),
          Text('\$2,548.00',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _balanceItem('Income', '\$1,840.00'),
              _balanceItem('Expenses', '\$284.00'),
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
        Text(title, style: TextStyle(color: Colors.white70, fontSize: 16)),
        Text(amount,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Transactions History',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: Text('See All',
                    style: TextStyle(color: Color(0xFF238C98), fontSize: 16)),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return TransactionTileWidget(
                    title: 'Upwork',
                    subtitle: 'Today',
                    amount: 850.00,
                    isIncome: true,
                    assetPath: Images.profile[index % 10]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final double amount;
  final bool isIncome;
  final String assetPath;

  const TransactionTileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isIncome,
    required this.assetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundImage: AssetImage(assetPath),
          radius: 30,
        ),
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle:
            Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 14)),
        trailing: Text(
          '${isIncome ? '+ ' : '- '}\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isIncome ? Colors.green : Colors.red),
        ),
      ),
    );
  }
}
