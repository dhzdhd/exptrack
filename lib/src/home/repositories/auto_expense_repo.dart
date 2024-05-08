import 'package:exptrack/src/home/models/auto_expense_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';

class AutoExpenseRepository {
  static late final Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox('autoexpenses');
  }

  Either<String, List<AutoExpenseModel>> fetch() {
    return Either.tryCatch(() {
      final raw = _box.get('autoexpenses', defaultValue: []) as List<dynamic>;
      return raw
          .map((e) => AutoExpenseModel.fromJson(Map<String, Object?>.from(e)))
          .toList();
    }, (o, s) => o.toString());
  }

  TaskEither<String, ()> upsert(List<AutoExpenseModel> model) {
    return TaskEither.tryCatch(
      () async {
        await _box.put('autoexpenses', model.map((e) => e.toJson()).toList());
        return ();
      },
      (o, s) => o.toString(),
    );
  }
}
