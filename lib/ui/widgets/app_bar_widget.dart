import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? textColor;

  const AppBarWidget(
      {super.key, this.title, this.leading, this.actions, this.textColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      automaticallyImplyLeading: leading == null,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textColor ?? Colors.white,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
