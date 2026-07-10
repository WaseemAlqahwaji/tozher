import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/core/data/source/local/hive_local_storge.dart';
import 'package:tozher/features/core/helpers/bloc_observer.dart';
import 'package:tozher/features/core/presentation/cubit/localization/localization_cubit.dart';
import 'package:tozher/firebase_options.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/routing/app_router.dart';
import 'package:tozher/theme/app_theme.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await HiveLocalStorge.openBox();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await configureInjection('dev');
  await FlutterLocalization.instance.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = AppRouter.createRouter();
  final localCubit = getIt<LocalizationCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      bloc: localCubit,
      builder: (context, state) {
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          builder: (_, child) => MaterialApp.router(
            locale: state.locale,
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
            title: 'Tozher',
            theme: AppTheme.lightTheme,
          ),
        );
      },
    );
  }
}
