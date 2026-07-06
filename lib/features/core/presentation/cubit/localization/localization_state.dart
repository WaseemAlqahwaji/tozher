part of 'localization_cubit.dart';

abstract class LocalizationState {
  final Locale locale;

  const LocalizationState(this.locale);
}

class LocalizationInitial extends LocalizationState {
  const LocalizationInitial(super.locale);
}

class LocaleChanged extends LocalizationState {
  const LocaleChanged(super.locale);
}
