import 'package:flutter/material.dart';
import 'package:spend_money/widgets/transaction_item.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  const TransactionList(
      {super.key, required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const Text('No transactions'),
                  const SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * .6,
                    child: Image.asset(
                      'assets/images/batterfly_black_white_breloka.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return TransactionItem(
                  transaction: transactions[index],
                  deleteTransaction: deleteTransaction);
            },
          );
  }
}
