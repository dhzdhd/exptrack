import 'package:flutter/material.dart';

enum Segment { all, week, month, year }

class SubscriptionsPage extends StatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  State<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends State<SubscriptionsPage> {
  Segment selectedSegment = Segment.all;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SegmentedButton<Segment>(
            segments: const [
              ButtonSegment(
                value: Segment.all,
                label: Text('All'),
              ),
              ButtonSegment(
                value: Segment.week,
                label: Text('Week'),
              ),
              ButtonSegment(
                value: Segment.month,
                label: Text('Month'),
              ),
              ButtonSegment(
                value: Segment.year,
                label: Text('Year'),
              ),
            ],
            selected: <Segment>{selectedSegment},
            showSelectedIcon: false,
            onSelectionChanged: (newSelection) => {
              setState(() {
                selectedSegment = newSelection.first;
              })
            },
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.home),
                  title: Text(
                    'AWS VPS',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                  subtitle: Text('26 July 2024'),
                  trailing: Text(
                    '\$5 / mo',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
