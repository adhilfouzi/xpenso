import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/images.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/user_provider.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/theme_container.dart';
import '../app_theme/app_theme_screen.dart';
import 'widget/version_screen.dart';
import '../profile/profile_screen.dart';
import 'widget/settings_options.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBarWidget(),
      extendBodyBehindAppBar: false,
      body: ThemeContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.profile.isEmpty
                      ? AssetImage(Images.avatar)
                      : AssetImage(user.profile),
                ),
                const SizedBox(height: 10),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                SettingsOption(
                  title: "Profile",
                  icon: Icons.person,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
                SettingsOption(
                  title: "App Theme",
                  icon: Icons.dark_mode,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AppThemeScreen()),
                    );
                  },
                  trailing: Switch(
                    activeColor: Colors.amberAccent,
                    value: isDarkMode,
                    onChanged: (value) => themeProvider.toggleTheme(),
                  ),
                ),
                Expanded(child: VersionScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
