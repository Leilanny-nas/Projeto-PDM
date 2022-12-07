import 'package:uru_bank/utils/styles.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbarMessage({
  required BuildContext context,
  required String message,
  bool error = false,
  bool ok = true,
  int duration = 5,
  VoidCallback? onOkPressed,
  VoidCallback? onVisible,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      onVisible: onVisible,
      action: ok
          ? SnackBarAction(
              label: "OK",
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();

                if (onOkPressed != null) onOkPressed();
              },
            )
          : null,
      duration: Duration(seconds: duration),
      backgroundColor: error ? Colors.red : Styles.buttonPrimaryColor,
    ),
  );
}
