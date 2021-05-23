import 'package:flutter/material.dart';

class EditableSnackBar {
  static void showSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
              content: Text(message)
          ),
        );
}
