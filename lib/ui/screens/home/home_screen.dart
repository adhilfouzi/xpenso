import 'package:flutter/material.dart';
import '../../widgets/theme_container.dart';
import '../../widgets/transaction_history.dart';
import 'widget/balance_card_widget.dart';
import 'widget/header_widget.dart';

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
