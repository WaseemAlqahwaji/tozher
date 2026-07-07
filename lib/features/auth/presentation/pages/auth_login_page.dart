import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/auth/data/model/user_model.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_login_cubit.dart';
import 'package:tozher/features/core/helpers/validation_helper.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_listner.dart';
import 'package:tozher/features/core/presentation/widgets/success_dialog.dart';
import 'package:tozher/gen/assets.gen.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/routing/route_paths.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final loginCubit = getIt<AuthLoginCubit>();

  @override
  void initState() {
    emailController = TextEditingController(
      text: 'waseemalqahwaji123@gmail.com',
    );
    passwordController = TextEditingController(text: '@Tt123456');
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return Scaffold(
      body: ReusableBlocListener<AuthLoginCubit, UserModel>(
        cubit: loginCubit,
        onSuccess: (value) {
          if (value?.emailVerified == false) {
            showSuccessDialog(
              context: context,
              successDialogMessage:
                  "${strings.emailNotVerified} ${strings.pleaseVerifyEmail}",
            );
            return;
          }
          if (value?.isProfileCompleted() == false) {
            context.pushReplacement(RoutePaths.completeProfile);
            return;
          }
          context.pushReplacement(RoutePaths.home);
        },
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                Assets.images.logo.image(height: 200.h, width: 200.h),
                Text(strings.appTagline, textAlign: TextAlign.center),
                Gap(8.h),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.welcomeBack,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Gap(16.h),
                        Text(strings.emailAddress),
                        Gap(8.h),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: strings.emailHint,
                          ),
                          validator: (value) {
                            if (ValidationHelper.isNullOrEmpty(value)) {
                              return strings.fieldRequired;
                            }
                            if (!ValidationHelper.isValidEmail(value!)) {
                              return strings.emailNotValid;
                            }
                            return null;
                          },
                        ),
                        Gap(16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(strings.password),
                            TextButton(
                              onPressed: () {
                                context.push(RoutePaths.sendEmail);
                              },
                              child: Text(strings.forgetPassword),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: strings.passwordHint,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (ValidationHelper.isNullOrEmpty(value)) {
                              return strings.fieldRequired;
                            }
                            return null;
                          },
                        ),
                        Gap(16.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                loginCubit.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(strings.login),
                                Gap(8.w),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(strings.dontHaveAccount),
                    TextButton(
                      onPressed: () {
                        context.pushReplacement(RoutePaths.register);
                      },
                      child: Text(strings.register),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
