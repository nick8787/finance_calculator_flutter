import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime transactionDate;
  String transactionDateDisplayed = 'No date chosen';

  void _submitData() {
    String title = _titleController.text;
    double amount = double.tryParse(_amountController.text);
    if (title.isEmpty ||
        amount == null ||
        amount <= 0 ||
        transactionDate == null) {
      return;
    }
    widget._addTransaction(title, amount, transactionDate);

    Navigator.of(context).pop();
  }

  void _pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        transactionDate = pickedDate;
        transactionDateDisplayed = DateFormat.yMMMd().format(transactionDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
            ),
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            controller: _amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitData(),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(transactionDateDisplayed),
              ),
              TextButton.icon(
                onPressed: () => _pickDate(context),
                icon: Icon(Icons.date_range_outlined),
                label: Text('Add date'),
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                    (_) => Theme.of(context).textTheme.bodyText2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            child: Text('Add transaction'),
            onPressed: _submitData,
            style: ButtonStyle(
              textStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (_) => Theme.of(context).textTheme.bodyText2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
