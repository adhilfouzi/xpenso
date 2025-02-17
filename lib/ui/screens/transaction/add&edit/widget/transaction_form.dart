import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/snackbar.dart';
import '../../../../../data/models/transaction_model.dart';
import '../../../../../providers/transaction_provider.dart';
import '../../../../../utils/formater.dart';
import '../../../../../utils/validator.dart';
import '../../../../widgets/text_field.dart';

class TransactionForm extends StatefulWidget {
  final TransactionModel? transaction;
  const TransactionForm({super.key, this.transaction});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  late TextEditingController nameController;
  late TextEditingController amountController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  bool get isExpense =>
      Provider.of<TransactionProvider>(context, listen: false).isExpense;

  @override
  void initState() {
    super.initState();
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    // Initialize text controllers with values
    nameController =
        TextEditingController(text: widget.transaction?.title ?? '');
    amountController = TextEditingController(
        text: widget.transaction?.amount.toString() ?? '');
    descriptionController =
        TextEditingController(text: widget.transaction?.description ?? '');
    dateController = TextEditingController(
        text: widget.transaction != null
            ? Formatter.datetoString(widget.transaction!.date)
            : '');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.transaction != null) {
        transactionProvider
            .setIsExpense(widget.transaction!.type == TransactionType.expense);
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void saveTransaction() {
    final transactionProvider =
        Provider.of<TransactionProvider>(context, listen: false);

    if (nameController.text.isEmpty ||
        amountController.text.isEmpty ||
        dateController.text.isEmpty) {
      MySnackbar.showError(context, 'Please fill in all fields');
      return;
    }

    final newTransaction = TransactionModel(
      id: widget.transaction?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: nameController.text,
      amount: double.tryParse(amountController.text) ?? 0.0,
      description: descriptionController.text,
      date: Formatter.stringToDateTime(dateController.text),
      type: isExpense ? TransactionType.expense : TransactionType.income,
    );

    if (widget.transaction != null) {
      transactionProvider.editTransaction(newTransaction);
    } else {
      transactionProvider.addTransaction(newTransaction);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SignTextField(
          controller: nameController,
          isDate: false,
          hintText: "Name",
          keyboardType: TextInputType.name,
          validator: (p0) => InputValidators.validateEmpty("Name", p0),
          key: const Key('name'),
          textInputAction: TextInputAction.next,
        ),
        SignTextField(
            key: const Key('amount'),
            controller: amountController,
            hintText: "Amount",
            isDate: false,
            keyboardType: TextInputType.number,
            validator: (p0) => InputValidators.validateNumber(p0),
            textInputAction: TextInputAction.next),
        SignTextField(
          keyboardType: TextInputType.text,
          validator: (p0) => InputValidators.validateEmpty("Description", p0),
          textInputAction: TextInputAction.next,
          key: const Key('description'),
          isDate: false,
          controller: descriptionController,
          hintText: "Description",
        ),
        SignTextField(
          controller: dateController,
          hintText: "Date",
          isDate: true,
          keyboardType: TextInputType.datetime,
          validator: (p0) => InputValidators.validateEmpty("Date", p0),
          textInputAction: TextInputAction.done,
          key: const Key('date'),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: saveTransaction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: isExpense ? Colors.redAccent : Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                  widget.transaction != null
                      ? (isExpense ? "Save Expense" : "Save Income")
                      : "Add Transaction",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
