import 'package:exptrack/src/home/views/pages/expenses.dart';
import 'package:exptrack/src/home/views/pages/subscriptions.dart';
import 'package:exptrack/src/home/widgets/expense_sheet.dart';
import 'package:exptrack/src/home/widgets/subscription_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              return switch (_currentPage) {
                Page.expenses => const ExpenseSheetWidget(),
                Page.subscriptions => const SubscriptionSheetWidget()
              };
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
