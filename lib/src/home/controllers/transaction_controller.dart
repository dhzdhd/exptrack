import 'package:exptrack/src/home/models/auto_expense_model.dart';
import 'package:exptrack/src/home/models/transaction_model.dart';
import 'package:exptrack/src/home/repositories/auto_expense_repo.dart';
import 'package:exptrack/src/home/repositories/transaction_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_controller.g.dart';

@riverpod
class Transaction extends _$Transaction {
  final _repo = TransactionRepository();

  @override
  List<TransactionModel> build() => _repo.fetch().getOrElse((l) => throw l);

  Future<void> addTransaction(TransactionModel transaction) async {
    state = [...state, transaction];
    await _repo.upsert(state).run();
  }
}

@riverpod
class AutoExpense extends _$AutoExpense {
  final _repo = AutoExpenseRepository();

  @override
  List<AutoExpenseModel> build() => _repo.fetch().getOrElse((l) => throw l);

  Future<void> addAutoExpense(AutoExpenseModel transaction) async {
    state = [...state, transaction];
    await _repo.upsert(state).run();
  }
}
