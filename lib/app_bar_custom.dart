import 'package:flutter/material.dart';

class AppBarCustom extends AppBar {
  AppBarCustom({super.key})
      : super(
            leadingWidth: 200,
            leading: Builder(
              builder: (context) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(children: const [
                    Icon(Icons.arrow_back_ios_new),
                  ]),
                );
              },
            ));
}
