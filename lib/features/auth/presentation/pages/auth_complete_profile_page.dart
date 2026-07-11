import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/auth/domain/params/auth_update_profile_params.dart';
import 'package:tozher/features/auth/presentation/cubit/auth_update_profile_cubit.dart';
import 'package:tozher/features/core/constants/app_constants.dart';
import 'package:tozher/features/core/helpers/validation_helper.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_listner.dart';
import 'package:tozher/gen/assets.gen.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/routing/route_paths.dart';

class AuthCompleteProfilePage extends StatefulWidget {
  final String userUid;
  const AuthCompleteProfilePage({super.key, required this.userUid});

  @override
  State<AuthCompleteProfilePage> createState() =>
      _AuthCompleteProfilePageState();
}

class _AuthCompleteProfilePageState extends State<AuthCompleteProfilePage> {
  late TextEditingController fullNameController;
  late TextEditingController usernameController;
  late TextEditingController ageController;
  late TextEditingController genderController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final updateProfileCubit = getIt<AuthUpdateProfileCubit>();

  @override
  void initState() {
    fullNameController = TextEditingController();
    usernameController = TextEditingController();
    ageController = TextEditingController();
    genderController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    ageController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: ReusableBlocListener<AuthUpdateProfileCubit, void>(
        cubit: updateProfileCubit,
        onSuccess: (value) {
          context.pushReplacement(RoutePaths.addUserInterests, extra: true);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.pagePadding),
            child: Column(
              children: [
                Assets.images.logo.image(width: 200.w, height: 200.h),
                Text(
                  strings.completeYourProfile,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Gap(16.h),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(strings.fullName),
                      Gap(4.h),
                      TextFormField(
                        controller: fullNameController,
                        validator: (value) {
                          if (ValidationHelper.isNullOrEmpty(value)) {
                            return strings.fieldRequired;
                          }

                          if (value!.length < 3) {
                            return strings.fullnameShouldBeMoreThat3Letters;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: strings.fullNameHint,
                        ),
                      ),
                      Gap(8.h),
                      Text(strings.username),
                      Gap(4.h),
                      TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          if (ValidationHelper.isNullOrEmpty(value)) {
                            return strings.fieldRequired;
                          }

                          if (value!.length < 3) {
                            return strings.usernameShouldBeMoreThat3Letters;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: strings.usernameHint,
                        ),
                      ),
                      Gap(8.h),
                      Text(strings.age),
                      Gap(4.h),
                      TextFormField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(hintText: strings.ageHint),
                        validator: (value) {
                          if (ValidationHelper.isNullOrEmpty(value)) {
                            return strings.fieldRequired;
                          }
                          return null;
                        },
                      ),
                      Gap(8.h),
                      Text(strings.gender),
                      Gap(4.h),
                      DropdownMenu(
                        width: double.infinity,
                        hintText: strings.genderHint,
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: 'male', label: strings.male),
                          DropdownMenuEntry(
                            value: 'female',
                            label: strings.female,
                          ),
                        ],
                        controller: genderController,
                      ),

                      Gap(32.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              updateProfileCubit.updateProfile(
                                AuthUpdateProfileParams(
                                  fullname: fullNameController.text,
                                  username: usernameController.text,
                                  age: int.parse(ageController.text),
                                  gender: genderController.text,
                                  uid: widget.userUid,
                                ),
                              );
                            }
                          },
                          child: Text(strings.letsGo),
                        ),
                      ),
                    ],
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
