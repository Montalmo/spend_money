import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spend_money/widgets/adaptive_flat_button.dart';

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
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
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
    double mediaHightKeyboard = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: mediaHightKeyboard + 40,
          ),
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
                    AdaptiveFlatButton(
                      handler: _pressentDatePicker,
                      text: 'Choose Date',
                    ),
                    // Platform.isIOS
                    //     ? CupertinoButton(
                    //         onPressed: _pressentDatePicker,
                    //         child: Text(
                    //           'Choose Date',
                    //         ),
                    //       )
                    //     : TextButton(
                    //         onPressed: _pressentDatePicker,
                    //         child: Text(
                    //           'Choose Date',
                    //           style: TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //       ),
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
      ),
    );
  }
}
