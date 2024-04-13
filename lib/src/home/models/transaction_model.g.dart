// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      title: json['title'] as String,
      desc: json['desc'] as String,
      amount: json['amount'] as int,
      currency: json['currency'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      duration: Option<Duration>.fromJson(
          json['duration'], (value) => Duration(microseconds: value as int)),
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
      'amount': instance.amount,
      'currency': instance.currency,
      'startDate': instance.startDate.toIso8601String(),
      'duration': instance.duration.toJson(
        (value) => value.inMicroseconds,
      ),
    };
