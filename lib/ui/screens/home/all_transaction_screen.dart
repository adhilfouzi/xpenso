import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/colors.dart';

import '../../../providers/transaction_provider.dart';
import '../../widgets/back_button.dart';
import '../../widgets/theme_container.dart';
import 'home_screen.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: MyBackButton(),
        backgroundColor: MyColors.primary,
        title: const Text(
          'Transaction',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          DateFilterWidget(),
        ],
      ),
      body: ThemeContainer(
        child: Column(
          children: [
            TransactionAllBar(),
            Expanded(child: TransactionAllHistory())
          ],
        ),
      ),
    );
  }
}

class TransactionAllBar extends StatelessWidget {
  const TransactionAllBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha((0.2 * 255).toInt()),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Consumer<TransactionProvider>(
          builder: (context, transactionProvider, child) {
            return Row(
              children: [
                _buildTab("All", 'All', Icons.trending_up, transactionProvider),
                _buildTab(
                    "Income", 'income', Icons.trending_up, transactionProvider),
                _buildTab("Expense", 'expenses', Icons.trending_down,
                    transactionProvider),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTab(String text, String type, IconData icon,
      TransactionProvider transactionProvider) {
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

class TransactionAllHistory extends StatelessWidget {
  const TransactionAllHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TransactionProvider().init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Expanded(
                    child: provider.allTransactionsList.isEmpty
                        ? const Center(child: Text("No transactions available"))
                        : ListView.builder(
                            itemCount: provider.allTransactionsList.length,
                            itemBuilder: (context, index) {
                              final transaction =
                                  provider.allTransactionsList[index];
                              return TransactionTileWidget(
                                  details: transaction);
                            },
                          ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class DateFilterWidget extends StatelessWidget {
  const DateFilterWidget({super.key});

  void _showDateRangePicker(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime? fromDate;
    DateTime? toDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Select Date Range",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  /// FROM DATE PICKER
                  GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(2000),
                        lastDate: now,
                      );

                      if (picked != null) {
                        setState(() => fromDate = picked);
                      }
                    },
                    child: _buildDateCard("From Date", fromDate),
                  ),
                  const SizedBox(height: 10),

                  /// TO DATE PICKER (Enabled only if FROM DATE is selected)
                  GestureDetector(
                    onTap: fromDate == null
                        ? null
                        : () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: fromDate!,
                              firstDate: fromDate!,
                              lastDate: now,
                            );

                            if (picked != null) {
                              setState(() => toDate = picked);
                            }
                          },
                    child: _buildDateCard("To Date", toDate,
                        isDisabled: fromDate == null),
                  ),
                  const SizedBox(height: 20),

                  /// APPLY FILTER BUTTON
                  ElevatedButton(
                    onPressed: (fromDate != null && toDate != null)
                        ? () {
                            Provider.of<TransactionProvider>(context,
                                    listen: false)
                                .filterTransactionsByDateRange(
                                    fromDate!, toDate!);
                            Navigator.pop(context); // Close bottom sheet
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.blue,
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: const Text("Apply Filter",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// BUILD DATE CARD UI
  Widget _buildDateCard(String label, DateTime? date,
      {bool isDisabled = false}) {
    return Card(
      color: isDisabled ? Colors.grey.shade200 : Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date == null ? label : DateFormat.yMMMd().format(date),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDisabled ? Colors.grey : Colors.black,
              ),
            ),
            Icon(Icons.calendar_today,
                color: isDisabled ? Colors.grey : Colors.blue),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.filter_list, color: Colors.white),
      onPressed: () => _showDateRangePicker(context),
    );
  }
}
