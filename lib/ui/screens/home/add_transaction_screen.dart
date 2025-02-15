import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import '../../../core/colors.dart';
import '../../../data/model/transaction_model.dart';
import '../../../providers/transaction_provider.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return KeyboardDismissOnTap(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            "Add Transaction",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [MyColors.primary, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.center,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 100),

              // Smooth Transaction Tab Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:
                    TransactionTabBar(transactionProvider: transactionProvider),
              ),

              // const SizedBox(height: 10),

              // Glassmorphic Transaction Form
              Expanded(
                child: Container(
                    margin: const EdgeInsets.all(16),
                    child: TransactionForm(
                        transactionProvider: transactionProvider)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TransactionTabBar extends StatelessWidget {
  final TransactionProvider transactionProvider;

  const TransactionTabBar({super.key, required this.transactionProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.2 * 255).toInt()),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            _buildTab("Income", false, Icons.trending_up),
            _buildTab("Expense", true, Icons.trending_down),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, bool isExpense, IconData icon) {
    bool isSelected = transactionProvider.isExpense == isExpense;

    return Expanded(
      child: GestureDetector(
        onTap: () => transactionProvider.setIsExpense(isExpense),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 200), // Faster response time
          curve: Curves.easeOut,
          tween:
              Tween(begin: 1.0, end: isSelected ? 1.1 : 1.0), // Bounce effect
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: AnimatedContainer(
                duration:
                    const Duration(milliseconds: 150), // Instant color change
                curve: Curves.linear,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: isSelected
                      ? [BoxShadow(color: Colors.black26, blurRadius: 5)]
                      : [],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon,
                        color: isSelected ? Colors.black : Colors.white,
                        size: 18),
                    const SizedBox(width: 6),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      opacity:
                          isSelected ? 1.0 : 0.6, // Softer color transition
                      child: Text(
                        text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: isSelected ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final TransactionProvider transactionProvider;

  const TransactionForm({super.key, required this.transactionProvider});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final amountController = TextEditingController();
    final descriptionController = TextEditingController();
    final dateController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(24),
      child: ListView(
        children: [
          CustomTextField(
              controller: nameController, label: "Name", icon: Icons.person),
          CustomTextField(
              controller: amountController,
              label: "Amount",
              icon: Icons.attach_money,
              isNumber: true),
          CustomTextField(
              controller: descriptionController,
              label: "Description",
              icon: Icons.description),
          CustomTextField(
              controller: dateController,
              label: "Date",
              icon: Icons.calendar_today,
              isDate: true),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              transactionProvider.addTransaction(
                TransactionModel(
                  id: DateTime.now().toString(),
                  title: nameController.text,
                  amount: double.tryParse(amountController.text) ?? 0.0,
                  description: descriptionController.text,
                  date: DateTime.now(),
                  type: transactionProvider.isExpense
                      ? TransactionType.expense
                      : TransactionType.income,
                ),
              );
              // Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              backgroundColor: transactionProvider.isExpense
                  ? Colors.redAccent
                  : Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            child: Text(
              transactionProvider.isExpense ? "Save Expense" : "Save Income",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final bool isNumber;
  final bool isDate;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.isNumber = false,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        readOnly: isDate,
        onTap: isDate
            ? () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controller.text = "${pickedDate.toLocal()}".split(' ')[0];
                }
              }
            : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
