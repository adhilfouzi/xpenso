import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/colors.dart';
import '../../../providers/transaction_provider.dart';
import '../../../utils/formater.dart';
import '../../widgets/theme_container.dart';
import 'add_transaction_screen.dart';
import 'home_screen.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: MyColors.primary,
        title: const Text(
          'Wallet',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: ThemeContainer(
        child: Column(
          children: [
            _buildHeader(context),
            const Expanded(child: TransactionHistory()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        return Container(
          decoration: const BoxDecoration(
            // color: Colors.teal,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('Total Balance',
                  style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 5),
              Text(
                Formatter.formatRuppe(provider.totalBalance),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddTransactionScreen()),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.add, color: Colors.teal, size: 28),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("Add", style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
