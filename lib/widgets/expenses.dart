import 'package:expenses_tracker/widgets/chart/chart.dart';
import 'package:expenses_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker/widgets/new_expense.dart';
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

  void _openAddExpenseOverlay (){
    showModalBottomSheet(
      isScrollControlled: true,
      context: context, 
      builder: (ctx){
        return  NewExpense(onAddExpenses: addExpense,);
      }
    );
  }

  

  void addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars(); // Si on supprime plusieur sa s'assure que message de un reste pas avant pour l'autre
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Depense supprimer"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = Center(
      child: Text('Aucune depense trouver'),
    );

    _registeredExpenses.isEmpty ? mainContent : mainContent = ExpensesList(expenses: _registeredExpenses, onRemoveExpenses: _removeExpense,);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: _openAddExpenseOverlay,
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          
          Expanded(
            child: mainContent
          )
        ],
      ),
    );
  }
}