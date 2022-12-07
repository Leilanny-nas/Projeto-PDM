import 'package:flutter/material.dart';

void showBottomModal(BuildContext context,
    {Widget? child,
    List<Widget>? children,
    double? height = 150,
    double topBorderRadius = 20,
    Color backgroundColor = const Color.fromARGB(255, 104, 58, 183)}) {
  showModalBottomSheet<void>(
    isScrollControlled: true,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topBorderRadius),
        topRight: Radius.circular(topBorderRadius),
      ),
    ),
    builder: (BuildContext ctx) {
      return Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topBorderRadius),
            topRight: Radius.circular(topBorderRadius),
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
