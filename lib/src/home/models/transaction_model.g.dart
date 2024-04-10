// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      amount: json['amount'] as int,
      duration: Option<Duration>.fromJson(
          json['duration'], (value) => Duration(microseconds: value as int)),
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'duration': instance.duration.toJson(
        (value) => value.inMicroseconds,
      ),
    };
