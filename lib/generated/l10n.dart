// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Collective goals, shared achievement.`
  String get appTagline {
    return Intl.message(
      'Collective goals, shared achievement.',
      name: 'appTagline',
      desc: 'Tagline shown on auth pages below the logo',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: 'Title on the login card',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: 'Label for email input field',
      args: [],
    );
  }

  /// `Hello@tozher.com`
  String get emailHint {
    return Intl.message(
      'Hello@tozher.com',
      name: 'emailHint',
      desc: 'Placeholder hint inside the email text field',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: 'Label for password input field',
      args: [],
    );
  }

  /// `********`
  String get passwordHint {
    return Intl.message(
      '********',
      name: 'passwordHint',
      desc: 'Placeholder hint inside the password text field',
      args: [],
    );
  }

  /// `Forget Password?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password?',
      name: 'forgetPassword',
      desc: 'Button label to navigate to password reset flow',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: 'Label for the login submit button',
      args: [],
    );
  }

  /// `Don't you have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t you have an account?',
      name: 'dontHaveAccount',
      desc:
          'Prompt shown below the login form asking if the user needs to register',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: 'Label for the register button / submit button',
      args: [],
    );
  }

  /// `Join a community designed for\n shared growth and celebration.`
  String get joinCommunity {
    return Intl.message(
      'Join a community designed for\n shared growth and celebration.',
      name: 'joinCommunity',
      desc: 'Tagline shown on the registration page below the logo',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: 'Label for full name input field',
      args: [],
    );
  }

  /// `Raghad Zeno`
  String get fullNameHint {
    return Intl.message(
      'Raghad Zeno',
      name: 'fullNameHint',
      desc: 'Placeholder hint inside the full name text field',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: 'Label for username input field',
      args: [],
    );
  }

  /// `raghad.7o_`
  String get usernameHint {
    return Intl.message(
      'raghad.7o_',
      name: 'usernameHint',
      desc: 'Placeholder hint inside the username text field',
      args: [],
    );
  }

  /// `You have an account?`
  String get haveAccount {
    return Intl.message(
      'You have an account?',
      name: 'haveAccount',
      desc:
          'Prompt shown below the registration form asking if the user already has an account',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: 'Title for the password reset page',
      args: [],
    );
  }

  /// `Enter your email to receive a verification code.`
  String get enterEmailForVerification {
    return Intl.message(
      'Enter your email to receive a verification code.',
      name: 'enterEmailForVerification',
      desc: 'Instruction shown on the password reset page',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message(
      'Send Code',
      name: 'sendCode',
      desc: 'Label for the button that sends the verification code',
      args: [],
    );
  }

  /// `Field required`
  String get fieldRequired {
    return Intl.message(
      'Field required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email not valid`
  String get emailNotValid {
    return Intl.message(
      'Email not valid',
      name: 'emailNotValid',
      desc: '',
      args: [],
    );
  }

  /// `password must contain sympol and big letter and number and not least that 8 letters`
  String get passwordShouldHaveSymbolAndBigLetterAndNumber {
    return Intl.message(
      'password must contain sympol and big letter and number and not least that 8 letters',
      name: 'passwordShouldHaveSymbolAndBigLetterAndNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enterNewPassword {
    return Intl.message(
      'Enter New Password',
      name: 'enterNewPassword',
      desc: 'Title on the change password page',
      args: [],
    );
  }

  /// `Verification Code`
  String get verificationCode {
    return Intl.message(
      'Verification Code',
      name: 'verificationCode',
      desc: 'Hint text for the verification code input',
      args: [],
    );
  }

  /// `Verification code is required`
  String get verificationCodeRequired {
    return Intl.message(
      'Verification code is required',
      name: 'verificationCodeRequired',
      desc: 'Validation message when verification code is empty',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: 'Hint text for the new password input on change password page',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: 'Validation message when password is empty',
      args: [],
    );
  }

  /// `Password is not valid`
  String get passwordNotValid {
    return Intl.message(
      'Password is not valid',
      name: 'passwordNotValid',
      desc:
          'Validation message when password does not meet strength requirements',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: 'Label for the change password submit button',
      args: [],
    );
  }

  /// `Enter the verification code sent to your account`
  String get enterCodeSentToAccount {
    return Intl.message(
      'Enter the verification code sent to your account',
      name: 'enterCodeSentToAccount',
      desc: 'Instruction shown on the confirm code page',
      args: [],
    );
  }

  /// `Invalid code`
  String get invalidCode {
    return Intl.message(
      'Invalid code',
      name: 'invalidCode',
      desc: 'Validation message when the entered code is invalid or too short',
      args: [],
    );
  }

  /// `Confirm Account`
  String get confirmAccount {
    return Intl.message(
      'Confirm Account',
      name: 'confirmAccount',
      desc: 'Label for the confirm account button',
      args: [],
    );
  }

  /// `Error Happend`
  String get errorHappend {
    return Intl.message(
      'Error Happend',
      name: 'errorHappend',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message('Ok', name: 'ok', desc: '', args: []);
  }

  /// `completed successfully`
  String get completedSuccessfully {
    return Intl.message(
      'completed successfully',
      name: 'completedSuccessfully',
      desc: 'Title shown in the success dialog',
      args: [],
    );
  }

  /// `Verification link have been sent, please verify the email and login`
  String get verificationLinkHaveBeenSent {
    return Intl.message(
      'Verification link have been sent, please verify the email and login',
      name: 'verificationLinkHaveBeenSent',
      desc: '',
      args: [],
    );
  }

  /// `Send Email`
  String get sendEmail {
    return Intl.message('Send Email', name: 'sendEmail', desc: '', args: []);
  }

  /// `Reset password email have been sended successfully`
  String get resetPasswordEmailHaveBeenSendedSuccessfully {
    return Intl.message(
      'Reset password email have been sended successfully',
      name: 'resetPasswordEmailHaveBeenSendedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Goals`
  String get goals {
    return Intl.message('Goals', name: 'goals', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Email not verified`
  String get emailNotVerified {
    return Intl.message(
      'Email not verified',
      name: 'emailNotVerified',
      desc: '',
      args: [],
    );
  }

  /// `Please verify your email`
  String get pleaseVerifyEmail {
    return Intl.message(
      'Please verify your email',
      name: 'pleaseVerifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Complete your profile`
  String get completeYourProfile {
    return Intl.message(
      'Complete your profile',
      name: 'completeYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Full name should be more than 3 letters`
  String get fullnameShouldBeMoreThat3Letters {
    return Intl.message(
      'Full name should be more than 3 letters',
      name: 'fullnameShouldBeMoreThat3Letters',
      desc: '',
      args: [],
    );
  }

  /// `Username should be more than 3 letters`
  String get usernameShouldBeMoreThat3Letters {
    return Intl.message(
      'Username should be more than 3 letters',
      name: 'usernameShouldBeMoreThat3Letters',
      desc: '',
      args: [],
    );
  }

  /// `age`
  String get age {
    return Intl.message('age', name: 'age', desc: '', args: []);
  }

  /// `male`
  String get male {
    return Intl.message('male', name: 'male', desc: '', args: []);
  }

  /// `female`
  String get female {
    return Intl.message('female', name: 'female', desc: '', args: []);
  }

  /// `gender`
  String get gender {
    return Intl.message('gender', name: 'gender', desc: '', args: []);
  }

  /// `Let's go`
  String get letsGo {
    return Intl.message('Let\'s go', name: 'letsGo', desc: '', args: []);
  }

  /// `Enter your age`
  String get ageHint {
    return Intl.message('Enter your age', name: 'ageHint', desc: '', args: []);
  }

  /// `Select your gender`
  String get genderHint {
    return Intl.message(
      'Select your gender',
      name: 'genderHint',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get userNotFound {
    return Intl.message(
      'User not found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Username has been taken, change it`
  String get usernameHasBeenTakenChangeIt {
    return Intl.message(
      'Username has been taken, change it',
      name: 'usernameHasBeenTakenChangeIt',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
