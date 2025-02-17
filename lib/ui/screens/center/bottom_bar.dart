import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../account/account_screen.dart';
import '../home/home_screen.dart';
import '../wallet/wallet_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    WalletScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _widgetOptions.length,
      child: Scaffold(
        body: TabBarView(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: _widgetOptions,
        ),
        bottomNavigationBar: Container(
          height: screen.height * 0.085,
          color: Theme.of(context).colorScheme.surface,
          child: TabBar(
            tabs: const <Tab>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.account_balance_wallet)),
              Tab(icon: Icon(Icons.person)),
            ],
            labelColor: MyColors.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
            indicatorColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
