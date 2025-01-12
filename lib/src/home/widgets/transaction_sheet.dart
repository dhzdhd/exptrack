import 'package:exptrack/src/home/controllers/transaction_controller.dart';
import 'package:exptrack/src/home/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' hide State;

class TransactionSheetWidget extends ConsumerStatefulWidget {
  const TransactionSheetWidget({super.key});

  @override
  ConsumerState<TransactionSheetWidget> createState() =>
      _TransactionSheetWidgetState();
}

class _TransactionSheetWidgetState
    extends ConsumerState<TransactionSheetWidget> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionNotifier = ref.read(transactionProvider.notifier);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height - 300,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ListView(
                  children: <Widget>[
                    Text(
                      'New transaction',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                      child: TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Amount',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  transactionNotifier.addTransaction(
                    TransactionModel(
                        title: _titleController.text,
                        desc: 'None',
                        amount: int.parse(_amountController.text),
                        currency: '\$',
                        startDate: DateTime.now(),
                        duration: const None()),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Create'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
