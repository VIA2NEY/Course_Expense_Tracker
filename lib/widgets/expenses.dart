import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

import 'package:expenses_tracker/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: (){}
          )
        ],
      ),
      body: Column(
        children: [
          Text('The chart'),
          
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses)
          )
        ],
      ),
    );
  }
}