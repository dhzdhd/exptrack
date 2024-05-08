import 'package:flutter/material.dart';
import 'package:exptrack/utils.dart';

enum AutomatedSegment { manual, automated }

class TransactionSheetWidget extends StatefulWidget {
  const TransactionSheetWidget({super.key});

  @override
  State<TransactionSheetWidget> createState() => _TransactionSheetWidgetState();
}

class _TransactionSheetWidgetState extends State<TransactionSheetWidget> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  AutomatedSegment selectedSegment = AutomatedSegment.manual;

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
                      child: SegmentedButton<AutomatedSegment>(
                        segments: AutomatedSegment.values
                            .map(
                              (e) => ButtonSegment(
                                value: e,
                                label: Text(e.name.capitalize()),
                              ),
                            )
                            .toList(),
                        selected: <AutomatedSegment>{selectedSegment},
                        showSelectedIcon: false,
                        onSelectionChanged: (newSelection) => {
                          setState(() {
                            selectedSegment = newSelection.first;
                          })
                        },
                      ),
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
                    Visibility(
                      visible: selectedSegment == AutomatedSegment.manual,
                      child: Padding(
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
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  // transactionNotifier.addSubscription(
                  //   TransactionModel(
                  //     title: _titleController.text,
                  //     desc: 'None',
                  //     amount: int.parse(_amountController.text),
                  //     currency: currency,
                  //     startDate: DateTime.now(),
                  //     duration: Duration.zero
                  //   ),
                  // );
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
