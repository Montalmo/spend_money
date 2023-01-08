import 'package:flutter/material.dart';
import 'package:spend_money/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransactions});

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum;

      for (var i = 0; i < recentTransactions.length; i++) {
         
      };

      return {'day': DateFormat.E(weekDay), 'amount': 9.99};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20.0),
      child: Row(
        children: [],
      ),
    );
  }
}
