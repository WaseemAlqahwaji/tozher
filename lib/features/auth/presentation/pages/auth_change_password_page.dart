import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/features/core/constants/app_constants.dart';
import 'package:tozher/features/core/helpers/validation_helper.dart';
import 'package:tozher/gen/assets.gen.dart';
import 'package:tozher/generated/l10n.dart';


class AuthChangePasswordPage extends StatefulWidget {
  final String email;
  const AuthChangePasswordPage({super.key, required this.email});

  @override
  State<AuthChangePasswordPage> createState() => _AuthChangePasswordPageState();
}

class _AuthChangePasswordPageState extends State<AuthChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _newPasswordController;
  late TextEditingController _codeController;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppConstants.pagePadding),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.images.logo.image(width: 160.h, height: 160.h),
                  Text(
                    strings.enterNewPassword,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Gap(24.h),
                  TextFormField(
                    controller: _codeController,
                    decoration: InputDecoration(
                      hintText: strings.verificationCode,
                    ),
                    validator: (value) {
                      if (ValidationHelper.isNullOrEmpty(value)) {
                        return strings.verificationCodeRequired;
                      }
                      return null;
                    },
                  ),
                  Gap(16.h),
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                      hintText: strings.newPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
    
                    obscureText: !_isPasswordVisible,
                    validator: (value) {
                      if (ValidationHelper.isNullOrEmpty(value)) {
                        return strings.passwordRequired;
                      }
                      if (!ValidationHelper.isValidStrongPassword(value!)) {
                        return strings.passwordNotValid;
                      }
                      return null;
                    },
                  ),
                  Gap(16.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          
                        }
                      },
                      child: Text(strings.changePassword),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
