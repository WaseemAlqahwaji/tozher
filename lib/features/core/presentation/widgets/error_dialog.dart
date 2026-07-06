import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/theme/app_colors.dart';

void showErrorDialog({
  required BuildContext context,
  required String errorMessage,
  VoidCallback? onDialogOk,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (dialogContext) => _AnimatedErrorDialog(
      message: errorMessage,
      onOk: () {
        Navigator.of(dialogContext).pop();
        onDialogOk?.call();
      },
    ),
  );
}

class _AnimatedErrorDialog extends StatefulWidget {
  final String message;
  final VoidCallback onOk;

  const _AnimatedErrorDialog({required this.message, required this.onOk});

  @override
  State<_AnimatedErrorDialog> createState() => _AnimatedErrorDialogState();
}

class _AnimatedErrorDialogState extends State<_AnimatedErrorDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shakeAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
                scale: _shakeAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.redErrorColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.cancel_rounded,
                      color: AppColors.redErrorColor,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
            Gap(20.h),
            Text(
              strings.errorHappend,
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
                  backgroundColor: AppColors.redErrorColor,
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
