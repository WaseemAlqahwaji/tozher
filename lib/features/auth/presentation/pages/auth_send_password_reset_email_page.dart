import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_send_password_reset_email_cubit.dart';
import 'package:tozher/features/core/helpers/validation_helper.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_listner.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';

class AuthSendPasswordResetEmailPage extends StatefulWidget {
  const AuthSendPasswordResetEmailPage({super.key});

  @override
  State<AuthSendPasswordResetEmailPage> createState() =>
      _AuthSendPasswordResetEmailPageState();
}

class _AuthSendPasswordResetEmailPageState
    extends State<AuthSendPasswordResetEmailPage> {
  late TextEditingController emailController;
  GlobalKey<FormState> key = GlobalKey<FormState>();
  final sendResetPasswordEmailCubit = getIt<AuthSendPasswordResetCubit>();

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: ReusableBlocListener<AuthSendPasswordResetCubit, void>(
        cubit: sendResetPasswordEmailCubit,
        showSuccessDialog: true,
        successMessage: strings.resetPasswordEmailHaveBeenSendedSuccessfully,
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.resetPassword,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text(strings.enterEmailForVerification),
                        Gap(24.h),
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
                            if (ValidationHelper.isValidEmail(value!)) {
                              return strings.emailNotValid;
                            }
                            return null;
                          },
                        ),
                        Gap(16.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              sendResetPasswordEmailCubit
                                  .sendPasswordResetEmail(emailController.text);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(strings.sendEmail),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
