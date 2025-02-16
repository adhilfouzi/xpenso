import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../../data/model/transaction_model.dart';
import '../../../widgets/back_button.dart';
import '../../../widgets/theme_container.dart';
import 'widget/transaction_form.dart';

class EditTransactionScreen extends StatelessWidget {
  final TransactionModel transaction;
  const EditTransactionScreen({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return KeyboardDismissOnTap(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Edit Transaction",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: MyBackButton(),
        ),
        body: ThemeContainer(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screen.width * 0.055,
                    vertical: screen.height * 0.25),
                child: TransactionForm(transaction: transaction)),
          ),
        ),
      ),
    );
  }
}
