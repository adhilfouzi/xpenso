import 'package:flutter/material.dart';

class MyColors {
  // Primary Colors
  static const Color primary = Color(0xFF2F7E79);
  static const Color secondary = Color(0xFF1E294D);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF4F4F4);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightPrimaryText = Color(0xFF0D0D0E);
  static const Color lightSecondaryText = Color(0xFF202225);
  static const Color lightBodyText = Color(0xFF313336);
  static const Color lightCaptionText = Color(0xFF585858);
  static const Color lightDisabledText = Color(0xFF787F84);
  static const Color lightBorder = Color(0xFFEEEEEE);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkPrimaryText = Color(0xFFFFFFFF);
  static const Color darkSecondaryText = Color(0xFFE0E0E0);
  static const Color darkBodyText = Color(0xFFB0B0B0);
  static const Color darkCaptionText = Color(0xFF8A8A8A);
  static const Color darkDisabledText = Color(0xFF646464);
  static const Color darkBorder = Color(0xFF333333);

  // Additional Common Colors
  static const Color chatSend = Color(0xFF468CF7);
  static const Color chatReceive = Color(0xFFE9E9EB);
  static const Color blue = Color(0xFF1C274C);
  static const Color lightGrey = Color(0xFF8D93A5);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Theme-based color selection
  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBackground
          : lightBackground;

  static Color surface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkSurface
          : lightSurface;

  static Color primaryText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkPrimaryText
          : lightPrimaryText;

  static Color secondaryText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkSecondaryText
          : lightSecondaryText;

  static Color bodyText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBodyText
          : lightBodyText;

  static Color captionText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkCaptionText
          : lightCaptionText;

  static Color disabledText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkDisabledText
          : lightDisabledText;

  static Color border(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? darkBorder
          : lightBorder;
}
