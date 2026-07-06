import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';

class KErrorWidget extends StatelessWidget {
  final Failure failure;
  final VoidCallback onRetry;
  const KErrorWidget({super.key, required this.failure, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              failure.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
             Gap(16.h),
            ElevatedButton(onPressed: onRetry, child: const Text('إعادة المحاولة')),
          ],
        ),
      ),
    );
  }
}
