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
