import 'package:freezed_annotation/freezed_annotation.dart';

part 'auto_expense_model.freezed.dart';
part 'auto_expense_model.g.dart';

@freezed
class AutoExpenseModel with _$AutoExpenseModel {
  const factory AutoExpenseModel({
    required String title,
    required String packageName,
    required String content,
  }) = _AutoExpenseModel;

  factory AutoExpenseModel.fromJson(Map<String, Object?> json) =>
      _$AutoExpenseModelFromJson(json);
}
