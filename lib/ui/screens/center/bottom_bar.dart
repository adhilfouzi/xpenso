import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../transaction/all/all_transaction_screen.dart';
import '../home/home_screen.dart';
import '../wallet/wallet_screen.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    WalletScreen(),
    AllTransactionScreen(),
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
          color: Color(0xFFF4F4F4),
          child: TabBar(
            tabs: const <Tab>[
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.account_balance_wallet)),
              Tab(icon: Icon(Icons.person)),
            ],
            labelColor: MyColors.primary,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
