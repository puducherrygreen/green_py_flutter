import 'package:flutter/material.dart';

willPopBack(BuildContext context) async {
  return await showExitConfirmationDialog(context);
}

Future showExitConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Exit the app?'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Stay on the current screen
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Allow navigating back
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
