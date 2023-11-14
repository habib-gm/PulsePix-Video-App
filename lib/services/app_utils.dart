import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class AppUtils {
  static Color extractAppBackgroundColor(String? colorString) {
    try {
      if (colorString == null) {
        return Colors.white;
      }
      final Color color = Color(_getColorFromHex(colorString));
      return color;
    } catch (e) {
      if (kDebugMode) {
        print('Error extracting app background color: $e');
      }
      return Colors.white;
    }
  }

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  static void openAppStore() async {
    if (Platform.isAndroid) {
      final url = Uri(
          scheme: 'https',
          host: 'play.google.com',
          path: 'store/apps/details',
          queryParameters: {"id": "your.app.package"});
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isIOS) {
      final url = Uri(
        scheme: 'https',
        host: 'itunes.apple.com',
        path: 'app/your-app-name/idyourappid',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      final url = Uri(
        scheme: 'https',
        host: 'itunes.apple.com',
        path: 'app/your-app-name/idyourappid',
      );
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static Future<ChewieController> initializeVideoPlayer(
      VideoPlayerController videoPlayerController) async {
    await videoPlayerController.initialize();

    final ChewieController chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9, // Adjust as needed
      autoInitialize: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft
      ],
      autoPlay: false,
      looping: true,
    );

    return chewieController;
  }

  static void changeToPortriatUp() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  static void changeToLandscape() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  static void changeStatusBarColor({required Color color}) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }
}
