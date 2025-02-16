import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/theme_container.dart';
import 'widget/date_filter_widget.dart';
import 'widget/transaction_card_widget.dart';
import 'widget/transaction_history_widget.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: MyBackButton(),
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
        actions: [
          DateFilterWidget(),
        ],
      ),
      body: ThemeContainer(
        child: Column(
          children: [
            TransactionCard(),
            Expanded(child: TransactionHistoryWidget())
          ],
        ),
      ),
    );
  }
}
