import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_register_cubit.dart';
import 'package:tozher/features/core/helpers/validation_helper.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_listner.dart';
import 'package:tozher/gen/assets.gen.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/routing/route_paths.dart';

class AuthRegisterPage extends StatefulWidget {
  const AuthRegisterPage({super.key});

  @override
  State<AuthRegisterPage> createState() => _AuthRegisterPageState();
}

class _AuthRegisterPageState extends State<AuthRegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController usernameController;
  late TextEditingController fullNameController;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  bool _obscurePassword = true;
  final resigterCubit = getIt<AuthRegisterCubit>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    usernameController = TextEditingController();
    fullNameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return Scaffold(
      body: ReusableBlocListener<AuthRegisterCubit, void>(
        cubit: resigterCubit,
        showSuccessDialog: true,
        successMessage: strings.verificationLinkHaveBeenSent,
        onSuccess: (value) {},
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                Assets.images.logo.image(height: 200.h, width: 200.h),
                Text(strings.joinCommunity, textAlign: TextAlign.center),
                Gap(8.h),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(strings.emailAddress),
                        Gap(8.h),
                        TextFormField(
                          controller: emailController,
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

                        // Text(strings.username),
                        // Gap(8.h),
                        // TextFormField(
                        //   controller: usernameController,
                        //   decoration: InputDecoration(
                        //     prefixIcon: Icon(Icons.text_format),
                        //     hintText: strings.usernameHint,
                        //   ),
                        //   validator: (value) {
                        //     if (ValidationHelper.isNullOrEmpty(value)) {
                        //       return strings.fieldRequired;
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // Gap(16.h),
                        Text(strings.password),
                        Gap(8.h),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
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
                            if (!ValidationHelper.isValidStrongPassword(
                              value!,
                            )) {
                              return strings
                                  .passwordShouldHaveSymbolAndBigLetterAndNumber;
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
                                resigterCubit.register(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(strings.register),
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
                    Text(strings.haveAccount),
                    TextButton(
                      onPressed: () {
                        context.pushReplacement(RoutePaths.login);
                      },
                      child: Text(strings.login),
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
