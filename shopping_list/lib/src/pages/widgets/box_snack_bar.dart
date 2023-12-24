import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String message, required Color backgroundColor, SnackBarBehavior? behavior}) {
  final snackBar = SnackBar(
    content: Text(message),
    behavior: behavior,
    backgroundColor: backgroundColor,
    action: SnackBarAction(
      label: 'x',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
