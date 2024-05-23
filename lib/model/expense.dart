import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


final formatter = DateFormat('dd-MM-yyyy')  /**DateFormat.yMd()*/;
const uuid = Uuid();

enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  // : id = uuid.v4(); deja le " : " apres la s'appel colone et se code vas permettre de generer un id quand un objet de cette classe est cree

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formatter.format(date);
  }
  
}


class ExpenseBucket {

  const ExpenseBucket({
    required this.category,
    required this.expenses
  });

  // filtrer les dépenses de allExpense dont la category correspond à la catégorie fournie. La méthode toList convertit ensuite le résultat en une liste.
  ExpenseBucket.forCategory(List<Expense> allExpense, this.category) 
    : expenses = allExpense                                   // le `:` initialise les depenses de `List<Expense> expenses` de la classe ExpenseBucket, egale a `List<Expense> allExpense` qu'on a dans mon .forCategory()
      .where((oneExpense) => oneExpense.category == category) // Et on vas filtre pour chaque depenses la categories qui a ete mis ici this.category
      .toList();



  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final eachExpense in expenses) {
      sum = sum + eachExpense.amount; // autre facon de l'ecrire sum =+ eachExpense.amount
    }

    return sum;
  }

}