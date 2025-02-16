import 'package:flutter/material.dart';
import 'package:xpenso/core/colors.dart';

class ThemeContainer extends StatelessWidget {
  final Widget child;
  const ThemeContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [MyColors.primary, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.center,
        ),
      ),
      child: child,
    );
  }
}
