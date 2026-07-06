import 'package:tozher/features/interests/domain/params/interest_update_params.dart';

class InterestUpdateModel {
  final String name;
  final String icon;

  InterestUpdateModel({required this.name, required this.icon});
}

extension InterestUpdateModelExtension on InterestUpdateModel {
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
    };
  }
}

extension InterestUpdateParamsExtension on InterestUpdateParams {
  InterestUpdateModel toModel() {
    return InterestUpdateModel(
      name: name,
      icon: icon,
    );
  }
}

