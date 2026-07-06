import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';
import 'package:tozher/features/core/presentation/widgets/kerror_widget.dart';
import 'package:tozher/features/core/presentation/widgets/loading_widget.dart';

typedef ReusableBlocErrorBuilder =
    Widget Function(BuildContext context, Failure failure, VoidCallback retry);

class ReusableBlocBuilder<B extends BlocBase<BaseState<T>>, T>
    extends StatelessWidget {
  final B cubit;
  final Widget Function(BuildContext context, BaseState<T> state) builder;
  final Widget? loadingWidget;
  final Widget? emptyWidget;
  final ReusableBlocErrorBuilder? errorBuilder;
  final VoidCallback onRetry;
  final bool Function(BaseState<T> previous, BaseState<T> current)? buildWhen;

  const ReusableBlocBuilder({
    super.key,
    required this.cubit,
    required this.builder,
    this.loadingWidget,
    this.emptyWidget,
    this.errorBuilder,
    required this.onRetry,
    this.buildWhen,
  });

  Widget _defaultErrorWidget(BuildContext context, Failure failure) {
    return KErrorWidget(failure: failure, onRetry: onRetry);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, BaseState<T>>(
      bloc: cubit,
      buildWhen: buildWhen,
      builder: (context, state) {
        if (state.isInProgress) {
          return loadingWidget ?? const Center(child: LoadingWidget());
        }

        if (state.isFailure && state.failure != null) {
          if (errorBuilder != null) {
            return errorBuilder!(context, state.failure!, onRetry);
          }

          return _defaultErrorWidget(context, state.failure!);
        }

        if (state.status == BaseStatus.initial) {
          return emptyWidget ?? const SizedBox.shrink();
        }

        return builder(context, state);
      },
    );
  }
}
