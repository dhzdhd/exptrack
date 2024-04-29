import 'package:exptrack/src/home/models/transaction_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';

class SubscriptionRepository {
  static late final Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox('transactions');
  }

  Either<String, List<TransactionModel>> fetch() {
    return Either.tryCatch(() {
      final raw = _box.get('subscriptions', defaultValue: []) as List<dynamic>;
      return raw.map((e) => TransactionModel.fromJson(e)).toList();
    }, (o, s) => o.toString());
  }

  TaskEither<String, ()> upsert(List<TransactionModel> model) {
    return TaskEither.tryCatch(
      () async {
        await _box.put('subscriptions', model.map((e) => e.toJson()).toList());
        return ();
      },
      (o, s) => o.toString(),
    );
  }
}
