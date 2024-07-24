import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amtController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final myFirstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: myFirstDate,
        lastDate: now,
        currentDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final amtData = double.tryParse(_amtController.text);
    final isInvalidAmt = amtData == null || amtData <= 0;

    if (_titleController.text.trim().isEmpty ||
        isInvalidAmt ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Input Error'),
          content: const Text(
              'Please enter valid Title, Amount, Date and Category!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return; // returning in 'if' ensures that the code after if is not executed
    }

    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: amtData,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        width: width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width > 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text('Title')),
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .color),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              label: Text('Amount'), prefix: Text('\$ ')),
                          keyboardType: TextInputType.number,
                          controller: _amtController,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .color),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text('Title')),
                    style: TextStyle(
                        color: Theme.of(context).textTheme.titleSmall!.color),
                  ),
                if (width > 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: (Category.values.map((n) => DropdownMenuItem(
                            value: n,
                            child: Text(n.name.toUpperCase())))).toList(),
                        onChanged: (val) {
                          if (val == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = val;
                          });
                        },
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Selected Date'
                                  : formatter.format(_selectedDate!),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color),
                            ),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                              label: Text('Amount'), prefix: Text('\$ ')),
                          keyboardType: TextInputType.number,
                          controller: _amtController,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .color),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'No Selected Date'
                                  : formatter.format(_selectedDate!),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .color),
                            ),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width > 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense')),
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: (Category.values.map((n) => DropdownMenuItem(
                            value: n,
                            child: Text(n.name.toUpperCase())))).toList(),
                        onChanged: (val) {
                          if (val == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = val;
                          });
                        },
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleSmall!.color),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text('Save Expense')),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
