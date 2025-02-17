import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(
        Theme.of(context).platform == TargetPlatform.iOS
            ? Icons.arrow_back_ios_new
            : Icons.arrow_back,
        color: Colors.white,
      ),
      tooltip: 'Back',
      splashColor: Colors.white24,
      highlightColor: Colors.white10,
    );
  }
}
