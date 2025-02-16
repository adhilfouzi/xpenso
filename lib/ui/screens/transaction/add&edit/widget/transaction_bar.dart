import 'package:flutter/material.dart';

import '../../../../../providers/transaction_provider.dart';

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
