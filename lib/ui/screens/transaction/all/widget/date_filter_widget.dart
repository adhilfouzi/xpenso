import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/transaction_provider.dart';

class DateFilterWidget extends StatelessWidget {
  const DateFilterWidget({super.key});

  void _showDateRangePicker(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime? fromDate;
    DateTime? toDate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  Text(
                    "Select Date Range",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// FROM DATE PICKER
                  GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(2000),
                        lastDate: now,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: Theme.of(context).colorScheme.primary,
                                onPrimary: Colors.white,
                                onSurface:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (picked != null) {
                        setState(() => fromDate = picked);
                      }
                    },
                    child: _buildDateCard("From Date", fromDate, context),
                  ),
                  const SizedBox(height: 15),

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
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary:
                                          Theme.of(context).colorScheme.primary,
                                      onPrimary: Colors.white,
                                      onSurface: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (picked != null) {
                              setState(() => toDate = picked);
                            }
                          },
                    child: _buildDateCard("To Date", toDate, context,
                        isDisabled: fromDate == null),
                  ),
                  const SizedBox(height: 25),

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
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      disabledBackgroundColor: Theme.of(context).disabledColor,
                      textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    child: Text("Apply Filter",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )),
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
  Widget _buildDateCard(String label, DateTime? date, BuildContext context,
      {bool isDisabled = false}) {
    return Card(
      color: isDisabled ? Theme.of(context).cardColor : Colors.grey.shade200,
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
                color: isDisabled
                    ? Colors.grey
                    : Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            Icon(Icons.calendar_today,
                color: isDisabled
                    ? Theme.of(context).iconTheme.color
                    : Colors.black),
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
