import 'dart:io';

import 'package:exptrack/src/home/views/pages/expenses.dart';
import 'package:exptrack/src/home/views/pages/subscriptions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../settings/views/settings_view.dart';
import 'package:exptrack/utils.dart';

enum Page {
  expenses,
  subscriptions;
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  Page _currentPage = Page.values[0];
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

  (String, String?) getCurrency() {
    final format = NumberFormat.simpleCurrency(locale: Platform.localeName);
    return (format.currencySymbol, format.currencyName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentPage.name.capitalize()),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.attach_money),
            label: 'Expenses',
          ),
          NavigationDestination(
            icon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          )
        ],
        selectedIndex: _currentPage.index,
        onDestinationSelected: (value) {
          setState(() {
            _currentPage = Page.values[value];
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 16.0, bottom: 8.0),
                                child: TextField(
                                  controller: _titleController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Title',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
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
                                      initialSelection: getCurrency().$1,
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
                                padding:
                                    EdgeInsets.only(top: 16.0, bottom: 8.0),
                                child: DropdownMenu(
                                  // width: double.infinity,
                                  enableSearch: false,
                                  initialSelection: '',
                                  label: Text('Hello'),
                                  dropdownMenuEntries: [],
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
                            Navigator.of(context).pop();
                          },
                          child: const Text('Create'),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: switch (_currentPage) {
        Page.expenses => const ExpensesPage(),
        Page.subscriptions => const SubscriptionsPage(),
      },
    );
  }
}
