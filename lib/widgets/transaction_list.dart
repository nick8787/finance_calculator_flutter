import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_card.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  TransactionList(this._userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 560,
      child: _userTransactions.isEmpty
          ? Column(
              children: [
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'No transactions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.grey,
                      ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            )
          : ListView.builder(
              itemCount: _userTransactions.length,
              itemBuilder: (ctx, index) {
                return TransactionCard(
                  id: _userTransactions[index].id,
                  amount: _userTransactions[index].amount,
                  title: _userTransactions[index].title,
                  date: _userTransactions[index].date,
                  deleteFunc: _deleteTransaction,
                );
              },
            ),
    );
  }
}
