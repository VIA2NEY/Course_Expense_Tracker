import 'package:expenses_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpenses});

  final void Function(Expense expense) onAddExpenses;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  @override
  void dispose() {

    _titleController.dispose(); // Pour quand quand il fini d'être call il se ferme pour ne pas que sa reste en memoire de l'app
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now,
      firstDate: firstDate, 
      lastDate: now
    );
    
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData (){

    final enteredAmount = double.tryParse(_amountController.text); // Parse [source] as a double literal and return its value.
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    // Si le titre est null (Aucune info) et que le montant entrer n'est pas valide 
    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) { /*trim enleve les espace de debut et de fin */
      // Afficher un message d'erreur 
      showDialog(
        context: context,
        builder: (ctx){
          return AlertDialog(
            title: Text('Entrée Invalid'),
            content: Text("S'il vous plaît assurer vous d'avoir renter toute les information correctement"),
            actions: [
              TextButton(
                onPressed: (){
                  Navigator.pop(ctx);
                }, 
                child: Text("Okay")
              )
            ],
          );
        }
      );
      return ;
    } 

    widget.onAddExpenses(
      Expense(
        title: _titleController.text, 
        amount: enteredAmount, 
        date: _selectedDate!, 
        category: _selectedCategory
      )
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [

          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(label: Text('Title')),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: 'Fcfa',
                    label: Text('Montant')
                  ),
                ),
              ),

              SizedBox(width: 16,),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text( 
                      _selectedDate == null ? 'no date selected' : formatter.format(_selectedDate!)
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.calendar_month
                      ),
                      onPressed: _presentDatePicker,
                    )
                  ],
                )
              )
            ],
          ),

          SizedBox(height: 15,),

          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                  (categori) => DropdownMenuItem(
                    value: categori,
                    child: Text(categori.name.toUpperCase())
                  )
                ).toList(), 
                onChanged: (value){
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              ),

              Spacer(),

              TextButton(
                child: Text('Anuler'),
                onPressed: (){
                  Navigator.pop(context);
                }, 
              ),

              ElevatedButton(
                child: Text('save Expense'),
                onPressed: _submitExpenseData, 
              )
            ],
          ),

          
        ],
      ),
    );
  }
}