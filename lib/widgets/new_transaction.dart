import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String, double, DateTime) _addTransaction;

  const NewTransaction(this._addTransaction, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? transactionDate;
  String transactionDateDisplayed = 'No date chosen';

  void _submitData() {
    final title = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty || amount == null || amount <= 0 || transactionDate == null) {
      return;
    }

    widget._addTransaction(title, amount, transactionDate!);
    Navigator.of(context).pop();
  }

  void _pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        transactionDate = pickedDate;
        transactionDateDisplayed = DateFormat.yMMMd().format(pickedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text(transactionDateDisplayed)),
                TextButton.icon(
                  onPressed: () => _pickDate(context),
                  icon: const Icon(Icons.date_range_outlined),
                  label: const Text('Add date'),
                  style: TextButton.styleFrom(
                    foregroundColor: primaryColor,
                    textStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: _submitData,
              child: const Text('Add transaction'),
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
                textStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
