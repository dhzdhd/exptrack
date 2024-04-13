import 'package:exptrack/src/home/models/transaction_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_controller.g.dart';

@riverpod
class Subscription extends _$Subscription {
  @override
  List<TransactionModel> build() => const [];

  Future<void> addSubscription(TransactionModel subscription) async {
    state = [...state, subscription];
  }
}
