import 'package:flutter/material.dart';

Widget elevatedButton({
  required BuildContext context,
  required VoidCallback callback,
  String? text,
  Icon? icon,
  double? width,
  double? height,
  double? borderRadius,
  double? padding,
  TextStyle? textStyle,
  Color? color,
}) {
  return Padding(
    padding: EdgeInsets.all(padding ?? 0.0),
    child: SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
          onPressed: callback,
          clipBehavior: Clip.antiAlias,
          style: ElevatedButton.styleFrom(
              backgroundColor: color ?? Colors.blue.shade400,
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 15)),
              padding: EdgeInsets.symmetric(vertical: height ?? 15)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (text != null)
                  Text(text, style: textStyle ?? const TextStyle(fontSize: 15)),
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: icon,
                  ),
              ],
            ),
          )),
    ),
  );
}

Widget outlinedButton({
  required BuildContext context,
  required VoidCallback callback,
  String? text,
  IconData? icon,
  double? width,
  double? height,
  double? borderRadius,
  double? padding,
  TextStyle? textStyle,
  Color? color,
}) {
  return Padding(
    padding: EdgeInsets.all(padding ?? 0.0),
    child: SizedBox(
      width: width ?? double.infinity,
      child: TextButton(
        onPressed: callback,
        clipBehavior: Clip.antiAlias,
        style: OutlinedButton.styleFrom(
            backgroundColor: color ?? Colors.blue.shade400,
            elevation: 0,
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1.4, color: Colors.white54),
                borderRadius: BorderRadius.circular(borderRadius ?? 15)),
            padding: EdgeInsets.symmetric(vertical: height ?? 15)),
        child: text != null
            ? Text(
                text,
                style: textStyle ?? const TextStyle(fontSize: 15),
              )
            : icon != null
                ? Icon(icon)
                : const Text(""),
      ),
    ),
  );
}
