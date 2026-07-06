import 'package:tozher/features/interests/domain/params/interest_add_params.dart';

class InterestAddModel {
  final String name;
  final String icon;

  InterestAddModel({required this.name, required this.icon});
}

extension InterestAddModelExtension on InterestAddModel {
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
    };
  }
}

extension InterestAddParamsExtension on InterestAddParams {
  InterestAddModel toModel() {
    return InterestAddModel(
      name: name,
      icon: icon,
    );
  }
}

