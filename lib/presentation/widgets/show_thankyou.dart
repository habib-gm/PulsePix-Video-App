import 'package:flutter/material.dart';

/// The `showThankYouDialog` function displays a 'Thank You' dialog to acknowledge
/// the user's action, such as sharing content within the app.
///
/// This function generates an `AlertDialog` with specific content:
///
/// - Title containing an icon (heart) and the text 'Thank You!' centered.
/// - Content displaying a thank you message for supporting the app.
/// - An 'OK' button that dismisses the dialog when pressed.
///
/// When called, this function creates and displays an alert dialog using
/// `showDialog`. It's intended to provide feedback or acknowledgment to the
/// user for actions such as sharing content.
void showThankYouDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            SizedBox(width: 10),
            Text(
              'Thank You!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Thank you for sharing the app! We appreciate your support.',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
