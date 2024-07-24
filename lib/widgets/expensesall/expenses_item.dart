import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            children: [
              Text(
                '\$${expense.amount.toStringAsFixed(2)}',
                style: TextStyle(
                    color: Theme.of(context).textTheme.titleSmall!.color),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(categoryItem[expense.category]),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    expense.formattedDate,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleSmall!.color),
                  )
                ],
              )
            ],
          )
        ],
      ),
    ));
  }
}
