import 'package:flutter/material.dart';
import 'package:tozher/features/core/presentation/widgets/loading_widget.dart';

Future<dynamic> showLoadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    useRootNavigator: true,

    builder: (context) =>
        PopScope(canPop: false, child: Center(child: LoadingWidget())),
  );
}
