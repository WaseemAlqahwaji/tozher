import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/core/constants/app_constants.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_builder.dart';
import 'package:tozher/features/interests/domain/entity/interest.dart';
import 'package:tozher/features/interests/presentation/cubit/interest_get_cubit.dart';
import 'package:tozher/features/interests/presentation/widget/interests_chips_list.dart';
import 'package:tozher/features/posts/presentation/pages/post_page.dart';
import 'package:tozher/injection.dart';
import 'package:tozher/routing/route_paths.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final getInterestCubit = getIt<InterestGetCubit>();

  @override
  initState() {
    getInterestCubit.getInterests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePaths.addPost);
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.pagePadding),
          child: Column(
            children: [
              ReusableBlocBuilder<InterestGetCubit, List<Interest>>(
                cubit: getInterestCubit,
                builder: (context, state) {
                  return SizedBox(
                    height: 50.h,
                    child: InterestsChipsList(
                      interests: state.item!,
                      onSelectionChanged: (value) {},
                    ),
                  );
                },
                onRetry: getInterestCubit.getInterests,
              ),
              Gap(8.h),
              PostPage(),
            ],
          ),
        ),
      ),
    );
  }
}
