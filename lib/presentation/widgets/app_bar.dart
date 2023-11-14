import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'show_thankyou.dart';
import '../../services/app_utils.dart';

/// The `customAppBar` function returns a customized `AppBar` widget for the
/// video list screen in the app.
///
/// This function generates an `AppBar` with specific attributes:
///
/// - Background color set to a dark color (#2C2C2C).
/// - System overlay style configured to match the status bar color.
/// - Centered title displaying 'Video List' in white text.
/// - Action icons for sharing and rating the app.
///
/// The 'Share' action icon triggers the sharing of app-related content using
/// the `Share` package. Upon sharing, it displays a 'Thank You' dialog if the
/// sharing operation was successful.
///
/// The 'Star' action icon allows users to rate the app, which is handled by
/// opening the app store through `AppUtils.openAppStore()` function.
///
/// This function is intended to be used within the video list screen to provide
/// a consistent and customized app bar.
AppBar customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: const Color(0xFF2C2C2C),
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: const Color(0xFF2C2C2C)),
    centerTitle: true,
    elevation: 0,
    // leading: Image.asset("assets/images/app_logo.png"),
    title: const Text('Video List', style: TextStyle(color: Colors.white)),
    actions: [
      IconButton(
        icon: const Icon(Icons.share, color: Colors.white),
        onPressed: () async {
          ShareResult result = await Share.shareWithResult(
              'Check out this awesome app! Download it now: https://your-app-url.com');
          if (result.raw.isNotEmpty) {
            // ignore: use_build_context_synchronously
            showThankYouDialog(context);
          }
        },
      ),
      IconButton(
        icon: const Icon(Icons.star, color: Colors.white),
        onPressed: () {
          // Handle rate app action
          AppUtils.openAppStore();
        },
      ),
    ],
  );
}
