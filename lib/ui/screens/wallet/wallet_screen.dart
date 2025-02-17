import 'package:flutter/material.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/theme_container.dart';
import '../../widgets/transaction_history.dart';
import 'widget/wallet_header.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBarWidget(title: 'Wallet'),
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
