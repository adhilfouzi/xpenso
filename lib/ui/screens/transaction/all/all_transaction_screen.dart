import 'package:flutter/material.dart';

import '../../../widgets/app_bar_widget.dart';
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
      appBar: AppBarWidget(
        leading: MyBackButton(),
        title: 'Transaction',
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
