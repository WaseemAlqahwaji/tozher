import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/generated/l10n.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationInitial(Locale('en')));

  /// Changes the application locale to [languageCode] (e.g. 'en' or 'ar').
  Future<void> changeLocale(String languageCode) async {
    final locale = Locale(languageCode);
    await S.load(locale);
    emit(LocaleChanged(locale));
  }
}

