import 'package:flutter/material.dart';

import '../../data/models/transaction_model.dart';
import '../../utils/formater.dart';
import '../screens/transaction/details/transaction_details_screen.dart';

class TransactionTileWidget extends StatelessWidget {
  final TransactionModel details;

  const TransactionTileWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    bool isIncome = TransactionType.income == details.type;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TransactionDetailsScreen(
                transaction: details,
              ))),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          // leading: CircleAvatar(
          //   backgroundImage: AssetImage(assetPath),
          //   radius: 30,
          // ),
          title: Text(details.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          subtitle: Text(Formatter.dateTimetoString(details.date),
              style: TextStyle(color: Colors.grey, fontSize: 14)),
          trailing: Text(
            '${isIncome ? '+ ' : '- '}₹${details.amount.toStringAsFixed(2)}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isIncome ? Colors.green : Colors.red),
          ),
        ),
      ),
    );
  }
}
