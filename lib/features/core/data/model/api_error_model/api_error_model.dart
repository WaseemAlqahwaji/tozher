import 'package:json_annotation/json_annotation.dart';

part 'api_error_model.g.dart';

@JsonSerializable()
class ApiErrorModel {
  final String title;
  final int status;
  final String detail;
  final List<ApiErrorDetailModel> errors;

  ApiErrorModel({
    required this.title,
    required this.status,
    required this.detail,
    required this.errors,
  });

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorModelToJson(this);
}

@JsonSerializable()
class ApiErrorDetailModel {
  final String name;
  final String reason;

  ApiErrorDetailModel({
    required this.name,
    required this.reason,
  });

  factory ApiErrorDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApiErrorDetailModelToJson(this);
}
