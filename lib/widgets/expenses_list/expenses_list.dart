import 'package:expenses_tracker/model/expense.dart';
import 'package:expenses_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';


class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses
  });

  final List<Expense> expenses ;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return ExpenseItem(expenses[index]);
      }
    );
  }
}