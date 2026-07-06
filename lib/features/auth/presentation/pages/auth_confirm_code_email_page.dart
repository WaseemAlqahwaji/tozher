import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:tozher/features/core/constants/app_constants.dart';
import 'package:tozher/features/core/helpers/validation_helper.dart';
import 'package:tozher/gen/assets.gen.dart';
import 'package:tozher/generated/l10n.dart';


class AuthConfirmCodeEmailPage extends StatefulWidget {
  final String email;
  const AuthConfirmCodeEmailPage({super.key, required this.email});

  @override
  State<AuthConfirmCodeEmailPage> createState() =>
      _AuthConfirmCodeEmailPageState();
}

class _AuthConfirmCodeEmailPageState extends State<AuthConfirmCodeEmailPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _codeController;

  @override
  void initState() {
    _codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
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
                    strings.enterCodeSentToAccount,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Gap(16.h),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      keyboardType: TextInputType.text,
                      length: 5,
                      controller: _codeController,
                      validator: (value) {
                        if (ValidationHelper.isNullOrEmpty(value) || value!.length <= 4) {
                          return strings.invalidCode;
                        }
                        return null;
                      },
                    ),
                  ),
                  Gap(24.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          
                        }
                      },
                      child: Text(strings.confirmAccount),
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
