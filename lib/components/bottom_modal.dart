import 'package:flutter/material.dart';

void showBottomModal(
  BuildContext context, {
  Widget? child,
  List<Widget>? children,
  double? height = 150,
}) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (BuildContext ctx) {
      return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 104, 58, 183),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: height,
        child: child ??
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: children ?? [],
            ),
      );
    },
  );
}
