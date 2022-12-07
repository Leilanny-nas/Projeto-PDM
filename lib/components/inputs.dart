import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uru_bank/utils/styles.dart';

Widget formInput({
  Key? key,
  String? initialValue,
  String? placeholder,
  VoidCallback? suffixIconPressed,
  String? suffixIconToolTip,
  TextEditingController? controller,
  TextInputType? keyboardType,
  String? Function(String?)? validator,
  void Function(String)? onSubmitted,
  void Function()? onEditingComplete,
  Widget? prefixIcon,
  Icon? sufixIcon,
  EdgeInsetsGeometry? sufixIconPadding,
  bool obscureText = false,
  Color? fillColor,
  double? borderRadius,
  double? suffixSplashRadius,
  double? fontSize,
  double? height,
  int? maxLines = 1,
  int? minLines,
  bool expands = false,
  bool autofocus = false,
  InputDecoration? decoration,
  List<TextInputFormatter>? inputFormatters,
}) {
  OutlineInputBorder borderStyle = OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.transparent,
    ),
    borderRadius: BorderRadius.circular(borderRadius ?? 10),
  );

  return SizedBox(
    height: height,
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      autofocus: autofocus,
      initialValue: initialValue,
      style: const TextStyle(color: Colors.white),
      inputFormatters: inputFormatters,
      onFieldSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      decoration: decoration ??
          InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: placeholder,
            hintStyle: const TextStyle(
              color: Colors.white54,
            ),
            errorStyle: TextStyle(
              color: Styles.errorTextColor,
              fontSize: fontSize ?? 14,
              fontWeight: FontWeight.w600,
            ),
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: fillColor ?? const Color(0xff262E45),
            suffixIcon: sufixIcon != null
                ? Padding(
                    padding:
                        sufixIconPadding ?? const EdgeInsets.only(right: 0),
                    child: IconButton(
                      tooltip: suffixIconToolTip ?? '',
                      splashRadius: suffixSplashRadius ?? 20,
                      onPressed: suffixIconPressed,
                      icon: sufixIcon,
                    ),
                  )
                : null,
            suffixIconColor: Colors.white70,
            border: const OutlineInputBorder(),
            focusedErrorBorder: borderStyle,
            errorBorder: borderStyle,
            enabledBorder: borderStyle,
            focusedBorder: borderStyle,
          ),
      cursorColor: Colors.white,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
    ),
  );
}
