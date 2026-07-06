import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';

import 'error_dialog.dart' as dialogs;
import 'loading_dialog.dart';
import 'success_dialog.dart' as dialogs;

class ReusableBlocListener<B extends BlocBase<BaseState<T>>, T>
    extends StatelessWidget {
  final B cubit;
  final Widget child;
  final bool Function(BaseState<T> previous, BaseState<T> current)? listenWhen;
  final ValueChanged<BaseState<T>>? onStateChanged;

  final bool showLoadingOnProgress;
  final bool showSuccessDialog;
  final String? successMessage;
  final bool showErrorDialog;

  final VoidCallback? onLoading;
  final ValueChanged<T?>? onSuccess;
  final VoidCallback? onError;
  final VoidCallback? onRetry;

  const ReusableBlocListener({
    super.key,
    required this.cubit,
    required this.child,
    this.listenWhen,
    this.onStateChanged,
    this.showLoadingOnProgress = true,
    this.showSuccessDialog = false,
    this.successMessage,
    this.showErrorDialog = true,
    this.onLoading,
    this.onSuccess,
    this.onError,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, BaseState<T>>(
      bloc: cubit,
      listenWhen: listenWhen,
      listener: (context, state) {
        onStateChanged?.call(state);

        if (state.isInProgress) {
          onLoading?.call();
          if (showLoadingOnProgress) {
            _showLoading(context);
          }
        } else if (state.isSuccess) {
          _dismissLoading(context);
          onSuccess?.call(state.item);
          if (showSuccessDialog && successMessage != null) {
            dialogs.showSuccessDialog(
              context: context,
              successDialogMessage: successMessage!,
              onDialogOk: onRetry,
            );
          }
        } else if (state.isFailure && state.failure != null) {
          _dismissLoading(context);
          onError?.call();
          if (showErrorDialog) {
            dialogs.showErrorDialog(
              context: context,
              errorMessage: state.failure!.message,
              onDialogOk: onRetry,
            );
          }
        }
      },
      child: child,
    );
  }

  void _showLoading(BuildContext context) {
    showLoadingDialog(context);
  }

  void _dismissLoading(BuildContext context) {
    if (showLoadingOnProgress) {
      context.pop();
    }
  }
}
