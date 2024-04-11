import 'package:flutter/material.dart';

class SubscriptionsPage extends StatelessWidget {
  const SubscriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'AWS VPS',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Text('\$5 / mo')
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}