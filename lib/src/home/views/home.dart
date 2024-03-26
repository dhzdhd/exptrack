import 'package:exptrack/src/home/pages/subscriptions.dart';
import 'package:flutter/material.dart';

import '../../settings/settings_view.dart';
import 'package:exptrack/utils.dart';

enum Page {
  expenses,
  subscriptions;
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const routeName = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Expenses'),
          BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions), label: 'Subscriptions')
        ],
        currentIndex: _currentPage.index,
        onTap: (value) {
          setState(() {
            _currentPage = Page.values[value];
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                width: double.infinity,
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
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: switch (_currentPage) {
        Page.expenses => Container(),
        Page.subscriptions => const SubscriptionsPage(),
      },
    );
  }
}
