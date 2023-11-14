import 'package:flutter/material.dart';

/// The `LoadingScreen` class is a Flutter widget designed to display a loading
/// indicator and a logo image while waiting for content to load.
///
/// This class constructs a `Scaffold` with a container in its body that contains
/// a column layout. The column comprises:
///
/// - An image widget displaying a logo using the asset image 'logo.png'.
/// - A circular progress indicator to indicate that content is being loaded.
///
/// The loading screen's layout is centered both vertically and horizontally,
/// utilizing `MainAxisAlignment` and `CrossAxisAlignment` parameters within
/// the column widget.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 8),
            const SizedBox(
              width: 8,
              height: 8,
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
