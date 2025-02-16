import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../widgets/theme_container.dart';
import '../../widgets/transaction_history.dart';
import 'widget/wallet_header.dart';

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
        elevation: 0,
      ),
      body: ThemeContainer(
        child: Column(
          children: [
            WalletHeader(),
            const Expanded(child: TransactionHistory()),
          ],
        ),
      ),
    );
  }
}
