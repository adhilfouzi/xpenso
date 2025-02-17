import 'package:flutter/material.dart';

import '../../../../../providers/transaction_provider.dart';

class CardText extends StatelessWidget {
  final String text;
  final String type;
  final IconData icon;
  final TransactionProvider transactionProvider;

  const CardText(
      {super.key,
      required this.text,
      required this.type,
      required this.icon,
      required this.transactionProvider});

  @override
  Widget build(BuildContext context) {
    bool isSelected = transactionProvider.whichType(type);

    return Expanded(
      child: GestureDetector(
        onTap: () {
          transactionProvider.transactionsType = type;
          transactionProvider.setWhichType();
        },
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          tween: Tween(begin: 1.0, end: isSelected ? 1.1 : 1.0),
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.linear,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: isSelected
                      ? [const BoxShadow(color: Colors.black26, blurRadius: 5)]
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
                      opacity: isSelected ? 1.0 : 0.6,
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
