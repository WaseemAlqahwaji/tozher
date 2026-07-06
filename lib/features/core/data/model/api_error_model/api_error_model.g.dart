// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiErrorModel _$ApiErrorModelFromJson(Map<String, dynamic> json) =>
    ApiErrorModel(
      title: json['title'] as String,
      status: (json['status'] as num).toInt(),
      detail: json['detail'] as String,
      errors: (json['errors'] as List<dynamic>)
          .map((e) => ApiErrorDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiErrorModelToJson(ApiErrorModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'status': instance.status,
      'detail': instance.detail,
      'errors': instance.errors,
    };

ApiErrorDetailModel _$ApiErrorDetailModelFromJson(Map<String, dynamic> json) =>
    ApiErrorDetailModel(
      name: json['name'] as String,
      reason: json['reason'] as String,
    );

Map<String, dynamic> _$ApiErrorDetailModelToJson(
  ApiErrorDetailModel instance,
) => <String, dynamic>{'name': instance.name, 'reason': instance.reason};
