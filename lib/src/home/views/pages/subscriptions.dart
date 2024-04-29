import 'package:exptrack/src/home/controllers/subscription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DurationSegment { day, week, month, year }

class SubscriptionsPage extends ConsumerStatefulWidget {
  const SubscriptionsPage({super.key});

  @override
  ConsumerState<SubscriptionsPage> createState() => _SubscriptionsPageState();
}

class _SubscriptionsPageState extends ConsumerState<SubscriptionsPage> {
  DurationSegment selectedSegment = DurationSegment.day;

  @override
  Widget build(BuildContext context) {
    final subscriptions = ref.watch(subscriptionProvider);
    final totalExpense = subscriptions.isEmpty
        ? 0
        : subscriptions
            .map(
              (e) => e.amount / e.duration.toNullable()!.inDays,
            )
            .reduce(
              (value, element) => value + element,
            )
            .round();

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Total expense',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '\$$totalExpense per day',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
          //   child: SegmentedButton<DurationSegment>(
          //     segments: DurationSegment.values
          //         .map(
          //           (e) => ButtonSegment(
          //             value: e,
          //             label: Text(e.name.capitalize()),
          //           ),
          //         )
          //         .toList(),
          //     selected: <DurationSegment>{selectedSegment},
          //     showSelectedIcon: false,
          //     onSelectionChanged: (newSelection) => {
          //       setState(() {
          //         selectedSegment = newSelection.first;
          //       })
          //     },
          //   ),
          // ),
          Expanded(
            child: ListView(
              children: subscriptions.isEmpty
                  ? [
                      Text(
                        'No subscriptions yet',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ]
                  : subscriptions
                      .map(
                        (sub) => Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                sub.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              subtitle: Text(sub.startDate
                                  .toString()
                                  .split(RegExp(r':\d\d\.'))[0]),
                              trailing: Text(
                                '${sub.currency}${sub.amount} / ${selectedSegment.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
