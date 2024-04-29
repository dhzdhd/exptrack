import 'package:exptrack/src/home/models/transaction_model.dart';
import 'package:exptrack/src/home/repositories/subscription_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscription_controller.g.dart';

@riverpod
class Subscription extends _$Subscription {
  final _repo = SubscriptionRepository();

  @override
  List<TransactionModel> build() => _repo.fetch().getOrElse((l) => throw l);

  Future<void> addSubscription(TransactionModel subscription) async {
    state = [...state, subscription];
    await _repo.upsert(state).run();
  }
}
