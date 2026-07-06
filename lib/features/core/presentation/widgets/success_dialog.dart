import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/theme/app_colors.dart';

void showSuccessDialog({
  required BuildContext context,
  required String successDialogMessage,
  VoidCallback? onDialogOk,
}) {

  showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (dialogContext) => _AnimatedSuccessDialog(
      message: successDialogMessage,
      onOk: () {
        Navigator.of(dialogContext).pop();
        onDialogOk?.call();
      },
    ),
  );
}

class _AnimatedSuccessDialog extends StatefulWidget {
  final String message;
  final VoidCallback onOk;

  const _AnimatedSuccessDialog({
    required this.message,
    required this.onOk,
  });

  @override
  State<_AnimatedSuccessDialog> createState() => _AnimatedSuccessDialogState();
}

class _AnimatedSuccessDialogState extends State<_AnimatedSuccessDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeIn),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.greenSuccessColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.greenSuccessColor,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
             Gap(20.h),
            Text(
              strings.completedSuccessfully,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
             Gap(8.h),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
             Gap(24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onOk,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greenSuccessColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(strings.ok),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
