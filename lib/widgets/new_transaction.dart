import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({super.key, required this.addTx});

  final Function addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final _enteredTitle = _titleController.text;
    final _enteredAmount = double.parse(_amountController.text);

    if (_enteredTitle.isEmpty || _enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      _enteredTitle,
      _enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _pressentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((picketDate) {
      if (picketDate == null) {
        return;
      }

      setState(() {
        _selectedDate = picketDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            SizedBox(
              height: 56.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date chosen!'
                        : DateFormat.yMd().format(_selectedDate!),
                  ),
                  TextButton(
                    onPressed: _pressentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text(
                'Add Transaction',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
