import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 8,
      ),
      child: ListTile(
        title: Text(transaction.title),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text('\$ ${transaction.amount}'),
            ),
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? ElevatedButton.icon(
                icon:const Icon(Icons.delete),
                label: const Text('Delete'),
                onPressed: () => deleteTransaction(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => deleteTransaction(transaction.id),
              ),
      ),
    );
  }
}
