// import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
// import 'package:retrofit/retrofit.dart';
import 'package:tozher/features/auth/data/repo/auth_repo_impl.dart';
import 'package:tozher/features/auth/data/source/auth_source.dart';
import 'package:tozher/features/auth/domain/repo/auth_repo.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_logout_cubit.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_register_cubit.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_send_password_reset_email_cubit.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_update_profile_cubit.dart';
import 'package:tozher/features/core/presentation/cubit/localization/localization_cubit.dart';
import 'package:tozher/features/interests/data/repo/interest_repo_impl.dart';
import 'package:tozher/features/interests/data/source/interest_source.dart';
import 'package:tozher/features/interests/domain/repo/interest_repo.dart';
import 'package:tozher/features/interests/presentation/cubit/interest_add_cubit.dart';
import 'package:tozher/features/interests/presentation/cubit/interest_delete_cubit.dart';
import 'package:tozher/features/interests/presentation/cubit/interest_get_cubit.dart';
import 'package:tozher/features/interests/presentation/cubit/interest_update_cubit.dart';
import 'package:tozher/features/interests/presentation/cubit/interests_get_user_cubit.dart';
import 'package:tozher/features/goals/data/repo/goal_repo_impl.dart';
import 'package:tozher/features/goals/data/source/goal_source.dart';
import 'package:tozher/features/goals/domain/repo/goal_repo.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_add_cubit.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_delete_cubit.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_get_cubit.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_toggle_achievement_cubit.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_update_cubit.dart';
import 'package:tozher/features/goals/presentation/cubit/goal_update_visibility_cubit.dart';
import 'package:tozher/features/image_upload/data/repo/image_upload_repo_impl.dart';
import 'package:tozher/features/image_upload/data/source/image_upload_source.dart';
import 'package:tozher/features/image_upload/domain/repo/image_upload_repo.dart';
import 'package:tozher/features/image_upload/presentation/cubit/image_upload_cubit.dart';
import 'package:tozher/features/posts/data/repo/post_repo_impl.dart';
import 'package:tozher/features/posts/data/source/post_source.dart';
import 'package:tozher/features/posts/domain/repo/post_repo.dart';
import 'package:tozher/features/posts/presentation/cubit/post_add_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_comment_add_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_comments_get_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_get_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_like_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_share_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_support_cubit.dart';
import 'package:tozher/features/posts/presentation/cubit/post_user_get_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureInjection(String env) async {
  getIt.registerSingleton<LocalizationCubit>(LocalizationCubit());
  getIt.registerLazySingleton<AuthSource>(
    () => AuthSource(FirebaseFirestore.instance),
  );
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authSource: getIt<AuthSource>()),
  );

  getIt.registerSingleton<AuthLoginCubit>(
    AuthLoginCubit(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<AuthRegisterCubit>(
    () => AuthRegisterCubit(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<AuthSendPasswordResetCubit>(
    () => AuthSendPasswordResetCubit(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<AuthLogoutCubit>(
    () => AuthLogoutCubit(authRepo: getIt<AuthRepo>()),
  );
  getIt.registerFactory<AuthUpdateProfileCubit>(
    () => AuthUpdateProfileCubit(authRepo: getIt<AuthRepo>()),
  );

  // Interests
  getIt.registerLazySingleton<InterestSource>(
    () => InterestSource(FirebaseFirestore.instance, getIt<AuthSource>()),
  );
  getIt.registerLazySingleton<InterestRepo>(
    () => InterestRepoImpl(getIt<InterestSource>()),
  );

  getIt.registerFactory<InterestGetCubit>(
    () => InterestGetCubit(interestRepo: getIt<InterestRepo>()),
  );
  getIt.registerFactory<InterestAddCubit>(
    () => InterestAddCubit(interestRepo: getIt<InterestRepo>()),
  );
  getIt.registerFactory<InterestUpdateCubit>(
    () => InterestUpdateCubit(interestRepo: getIt<InterestRepo>()),
  );
  getIt.registerFactory<InterestDeleteCubit>(
    () => InterestDeleteCubit(interestRepo: getIt<InterestRepo>()),
  );
  getIt.registerFactory<InterestsGetUserCubit>(
    () => InterestsGetUserCubit(interestRepo: getIt<InterestRepo>()),
  );

  // Goals
  getIt.registerLazySingleton<GoalSource>(
    () => GoalSource(FirebaseFirestore.instance),
  );
  getIt.registerLazySingleton<GoalRepo>(
    () => GoalRepoImpl(getIt<GoalSource>()),
  );

  getIt.registerFactory<GoalGetCubit>(
    () => GoalGetCubit(goalRepo: getIt<GoalRepo>()),
  );
  getIt.registerFactory<GoalAddCubit>(
    () => GoalAddCubit(goalRepo: getIt<GoalRepo>()),
  );
  getIt.registerFactory<GoalUpdateCubit>(
    () => GoalUpdateCubit(goalRepo: getIt<GoalRepo>()),
  );
  getIt.registerFactory<GoalDeleteCubit>(
    () => GoalDeleteCubit(goalRepo: getIt<GoalRepo>()),
  );
  getIt.registerFactory<GoalUpdateVisibilityCubit>(
    () => GoalUpdateVisibilityCubit(goalRepo: getIt<GoalRepo>()),
  );
  getIt.registerFactory<GoalToggleAchievementCubit>(
    () => GoalToggleAchievementCubit(goalRepo: getIt<GoalRepo>()),
  );

  // Posts
  getIt.registerLazySingleton<PostSource>(
    () => PostSource(FirebaseFirestore.instance),
  );
  getIt.registerLazySingleton<PostRepo>(
    () => PostRepoImpl(source: getIt<PostSource>()),
  );
  getIt.registerFactory<PostGetCubit>(
    () => PostGetCubit(postRepo: getIt<PostRepo>()),
  );
  getIt.registerFactory<PostAddCubit>(
    () => PostAddCubit(postRepo: getIt<PostRepo>()),
  );
  getIt.registerFactory<PostLikeCubit>(
    () => PostLikeCubit(postRepo: getIt<PostRepo>()),
  );
  getIt.registerFactory<PostCommentAddCubit>(
    () => PostCommentAddCubit(postRepo: getIt<PostRepo>()),
  );
  getIt.registerFactory<PostCommentsGetCubit>(
    () => PostCommentsGetCubit(postRepo: getIt<PostRepo>()),
  );
  getIt.registerFactory<PostSupportCubit>(
    () => PostSupportCubit(postRepo: getIt<PostRepo>()),
  );
  getIt.registerFactory<PostShareCubit>(
    () => PostShareCubit(postRepo: getIt<PostRepo>()),
  );
  getIt.registerFactory<PostUserGetCubit>(
    () => PostUserGetCubit(postRepo: getIt<PostRepo>()),
  );

  // Image Upload
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ImageUploadSource>(
    () => ImageUploadSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ImageUploadRepo>(
    () => ImageUploadRepoImpl(getIt<ImageUploadSource>()),
  );
  getIt.registerFactory<ImageUploadCubit>(
    () => ImageUploadCubit(repo: getIt<ImageUploadRepo>()),
  );
}

// class _AppParseErrorLogger extends ParseErrorLogger {
//   @override
//   void logError(
//     Object error,
//     StackTrace stackTrace,
//     RequestOptions options, {
//     Response? response,
//   }) {
//     developer.log(
//       'API parse error',
//       name: 'ApiService',
//       error: error,
//       stackTrace: stackTrace,
//     );
//   }
// }
