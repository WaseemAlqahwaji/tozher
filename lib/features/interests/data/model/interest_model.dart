import 'package:tozher/features/interests/domain/entity/interest.dart';

class InterestModel {
  final String id;
  final String name;
  final String icon;

  InterestModel({required this.id, required this.name, required this.icon});

  Interest toEntity() => Interest(id: id, name: name, icon: icon);

  factory InterestModel.fromEntity(Interest entity) =>
      InterestModel(id: entity.id, name: entity.name, icon: entity.icon);

  factory InterestModel.fromMap(Map<String, dynamic> map, String documentId) {
    return InterestModel(
      id: documentId,
      name: map['name'] as String,
      icon: map['icon'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'icon': icon};
  }
}
