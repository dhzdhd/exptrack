import 'dart:io';

import 'package:exptrack/src/home/controllers/subscription_controller.dart';
import 'package:exptrack/src/home/views/pages/subscriptions.dart';
import 'package:flutter/material.dart';
import 'package:exptrack/src/home/models/transaction_model.dart';
import 'package:exptrack/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';

class SubscriptionSheetWidget extends ConsumerStatefulWidget {
  const SubscriptionSheetWidget({super.key});

  @override
  ConsumerState<SubscriptionSheetWidget> createState() =>
      _SubscriptionSheetWidgetState();
}

class _SubscriptionSheetWidgetState
    extends ConsumerState<SubscriptionSheetWidget> {
  late final TextEditingController _titleController;
  late final TextEditingController _amountController;
  String currency = getCurrency().$1;
  DurationSegment selectedSegment = DurationSegment.month;

  static (String, String?) getCurrency() {
    final format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return (format.currencySymbol, format.currencyName);
  }

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
    final transactionNotifier = ref.read(subscriptionProvider.notifier);

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
                      'New subscription',
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
                          DropdownMenu(
                            enableSearch: false,
                            initialSelection: currency,
                            onSelected: (value) => setState(
                              () {
                                currency = value!;
                              },
                            ),
                            dropdownMenuEntries: [
                              DropdownMenuEntry(
                                value: getCurrency().$1,
                                label: getCurrency().$1,
                              ),
                              const DropdownMenuEntry(
                                value: '\$',
                                label: '\$',
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: SegmentedButton<DurationSegment>(
                        segments: DurationSegment.values
                            .map(
                              (e) => ButtonSegment(
                                value: e,
                                label: Text(e.name.capitalize()),
                              ),
                            )
                            .toList(),
                        selected: <DurationSegment>{selectedSegment},
                        showSelectedIcon: false,
                        onSelectionChanged: (newSelection) => {
                          setState(() {
                            selectedSegment = newSelection.first;
                          })
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  transactionNotifier.addSubscription(
                    TransactionModel(
                      title: _titleController.text,
                      desc: 'None',
                      amount: int.parse(_amountController.text),
                      currency: currency,
                      startDate: DateTime.now(),
                      duration: Some(switch (selectedSegment) {
                        DurationSegment.day => const Duration(days: 1),
                        DurationSegment.week => const Duration(days: 7),
                        DurationSegment.month => const Duration(days: 30),
                        DurationSegment.year => const Duration(days: 365)
                      }),
                    ),
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
