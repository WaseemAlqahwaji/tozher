import 'package:tozher/features/interests/domain/params/interests_user_remove_params.dart';

class InterestsUserRemoveModel {
  final List<String> interestsIds;
  final String uid;

  InterestsUserRemoveModel({required this.interestsIds, required this.uid});
}

extension InterestsUserRemoveToModel on InterestsUserRemoveParams {
  InterestsUserRemoveModel toModel() {
    return InterestsUserRemoveModel(interestsIds: interestsIds, uid: uid);
  }
}
