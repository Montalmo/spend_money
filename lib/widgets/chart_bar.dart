import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.lable,
    required this.spendingAmount,
    required this.spendingPctOfTotal,
  });

  final String lable;
  final double spendingAmount;
  final double spendingPctOfTotal;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20.0,
        child: FittedBox(
          child: Text('\$ ${spendingAmount.toStringAsFixed(0)}'),
        ),
      ),
      const SizedBox(height: 4.0),
      SizedBox(
        height: 60.0,
        width: 10,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: const Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            FractionallySizedBox(
              heightFactor: spendingPctOfTotal,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 4.0),
      Text(lable),
    ]);
  }
}
