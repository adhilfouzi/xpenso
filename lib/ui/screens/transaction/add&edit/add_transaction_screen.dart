import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';

import '../../../../providers/transaction_provider.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/theme_container.dart';
import 'widget/transaction_bar.dart';
import 'widget/transaction_form.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return KeyboardDismissOnTap(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(title: "Add Transaction", leading: MyBackButton()),
        body: ThemeContainer(
          child: Column(
            children: [
              const SizedBox(height: 100),

              // Smooth Transaction Tab Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:
                    TransactionTabBar(transactionProvider: transactionProvider),
              ),

              // Glassmorphic Transaction Form
              Expanded(
                child: Container(
                    margin: const EdgeInsets.all(16), child: TransactionForm()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
