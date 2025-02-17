import 'package:flutter/material.dart';

class Button {
  Widget mainButton(
    String text,
    BuildContext context,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.5 * 255).toInt()),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFF238C98),
          minimumSize: Size(
            MediaQuery.of(context).size.width * 0.7,
            MediaQuery.of(context).size.height * 0.06,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget googleSignInButton(
      BuildContext context, bool isBlack, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isBlack ? Colors.white : Colors.black,
        backgroundColor: isBlack ? Colors.black : Colors.white,
        minimumSize: Size(
          MediaQuery.of(context).size.width * 0.83,
          MediaQuery.of(context).size.height * 0.06,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
          side: BorderSide(
              color: isBlack ? Colors.white : Colors.black,
              width: 1), // Stroke color and width
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // SvgPicture.asset(
          //   'assets/image/google_logo.svg', // Replace with your Google logo asset
          //   height: 40,
          //   width: 40,
          // ),
          const SizedBox(width: 10),
          Text(
            'Login with Google',
            style: TextStyle(
              color: isBlack ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
