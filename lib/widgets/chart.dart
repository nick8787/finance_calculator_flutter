import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:udemy_2/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get _groupedTransactionAmounts {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var amount = 0.0;
      for (var tx in _recentTransactions) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          amount += tx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': amount,
      };
    });
  }

  double get _totalWeekAmount {
    double total = 0.0;
    for (var tx in _groupedTransactionAmounts) {
      total += tx['amount'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ..._groupedTransactionAmounts.map((tx) {
                // print((tx['amount'] as double) / _totalWeekAmount);
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    tx['day'],
                    (tx['amount'] as double),
                    _totalWeekAmount == 0.0
                        ? 0.0
                        : (tx['amount'] as double) / _totalWeekAmount,
                  ),
                );
              })
            ].reversed.toList(),
          ),
        ));
  }
}
