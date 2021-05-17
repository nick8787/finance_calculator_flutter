import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final String id;
  final double amount;
  final String title;
  final DateTime date;
  final Function deleteFunc;

  TransactionCard({
    this.id,
    this.amount,
    this.title,
    this.date,
    this.deleteFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      child: ListTile(
        leading: Container(
          height: 60,
          width: 60,
          child: CircleAvatar(
            radius: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('\$${amount.toStringAsFixed(2)}')),
            ),
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(DateFormat.yMMMd().format(date)),
        trailing: IconButton(
          icon: Icon(Icons.delete_rounded),
          onPressed: () {
            deleteFunc(id);
          },
          color: Theme.of(context).primaryColor,
          splashColor: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}
