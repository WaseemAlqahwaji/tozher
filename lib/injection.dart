// import 'dart:developer' as developer;

// import 'package:dio/dio.dart';
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
