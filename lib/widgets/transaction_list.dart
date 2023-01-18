import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(
      {required this.transactions, required this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              const Text('No transactions'),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 260,
                child: Image.asset(
                  'assets/images/batterfly_black_white_breloka.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                child: ListTile(
                  title: Text(transactions[index].title),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text('\$ ${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    onPressed: () => deleteTransaction(transactions[index].id),
                  ),
                ),
              );
              // return Card(
              //   child: Row(
              //     children: <Widget>[
              //       Container(
              //         margin: EdgeInsets.symmetric(
              //           vertical: 10,
              //           horizontal: 15,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //             width: 2,
              //           ),
              //         ),
              //         padding: EdgeInsets.all(10),
              //         child: Text(
              //           '\$ ${transactions[index].amount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             color: Theme.of(context).primaryColor,
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: <Widget>[
              //           Text(
              //             transactions[index].title,
              //             style: TextStyle(
              //               fontSize: 16,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //           Text(
              //             DateFormat.yMMMd().format(transactions[index].date),
              //             style: TextStyle(
              //               color: Colors.grey,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );
            },
          );
  }
}
