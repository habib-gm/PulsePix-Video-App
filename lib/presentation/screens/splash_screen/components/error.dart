import 'package:flutter/material.dart';

import '../../../../application/splash_bloc/splash.dart';

/// The `ErrorScreen` class is a Flutter widget designed to display an error
/// message and provide an option to retry a specific action.
///
/// This class receives an [error] message as a parameter and constructs a
/// `Scaffold` with a column layout. The column contains:
///
/// - A container displaying the received [error] message.
/// - An elevated button labeled 'Retry Again' that triggers a new data-fetching
///   event when pressed.
///
/// The [error] parameter represents the error message to be displayed.
/// The button triggers the `FetchDataEvent` on the `SplashBloc` using the
/// `BlocProvider` to attempt fetching data again.
class ErrorScreen extends StatelessWidget {
  final String error;

  /// Constructor for ErrorScreen requiring an [error] message.
  const ErrorScreen({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20), child: Text(error)),
          ElevatedButton(
            child: const Text(
              'Retry Again',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              BlocProvider.of<SplashBloc>(context).add(FetchDataEvent());
            },
          ),
        ],
      ),
    );
  }
}
