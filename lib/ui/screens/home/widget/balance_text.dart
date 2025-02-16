import 'package:flutter/material.dart';

class BalanceText extends StatelessWidget {
  final String title;
  final String amount;
  const BalanceText({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(color: Colors.white70, fontSize: 16)),
        Text(amount,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}
