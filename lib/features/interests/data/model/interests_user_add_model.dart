import 'package:tozher/features/interests/domain/params/interests_user_add_params.dart';

class InterestsUserAddModel {
  final List<String> interestsIds;
  final String uid;

  InterestsUserAddModel({required this.interestsIds, required this.uid});
}

extension InterestsUserAddToModel on InterestsUserAddParams {
  InterestsUserAddModel toModel() {
    return InterestsUserAddModel(interestsIds: interestsIds, uid: uid);
  }
}
