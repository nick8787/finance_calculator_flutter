import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finance_calculator/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  const Chart(this._recentTransactions, {super.key});

  List<Map<String, Object>> get _groupedTransactionAmounts {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double amount = 0.0;
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
    return _groupedTransactionAmounts.fold(0.0, (sum, tx) {
      return sum + (tx['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _groupedTransactionAmounts.reversed.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                tx['day'] as String,
                tx['amount'] as double,
                _totalWeekAmount == 0.0
                    ? 0.0
                    : (tx['amount'] as double) / _totalWeekAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
