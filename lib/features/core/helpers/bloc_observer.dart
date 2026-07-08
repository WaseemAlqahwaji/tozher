import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      developer.log('onCreate -- ${bloc.runtimeType}', name: 'BlocObserver');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      developer.log(
        'onChange -- ${bloc.runtimeType}, $change',
        name: 'BlocObserver',
      );
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      developer.log(
        'onError -- ${bloc.runtimeType}, $error',
        name: 'BlocObserver',
        error: error,
        stackTrace: stackTrace,
      );
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      developer.log('onClose -- ${bloc.runtimeType}', name: 'BlocObserver');
    }
  }
}