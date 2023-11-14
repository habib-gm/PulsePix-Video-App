import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../domain/video_data/video_data.dart';
import '../../../../services/app_utils.dart';
import '../../video_play_screen/video_play_screen.dart';

/// The `VideoListItem` class represents a widget to display a video item.
///
/// This widget, when tapped, navigates to the `VideoPlayScreen` to play the
/// selected video. It also integrates an interstitial ad functionality to show
/// ads before navigating to the video screen.
class VideoListItem extends StatefulWidget {
  final VideoData video;

  /// Constructor for VideoListItem widget, requiring a [video] data.
  VideoListItem({super.key, required this.video});

  @override
  State<VideoListItem> createState() => _VideoListItemState();
}

class _VideoListItemState extends State<VideoListItem> {
  final int maxFailedLoadAttempts = 5;

  int _interstitialLoadAttempts = 0;

  InterstitialAd? _interstitialAd;

  final interstitialAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712' // Android test ad unit ID
      : 'ca-app-pub-3940256099942544/4411468910'; // IOS test ad unit ID

  /// Function to create an interstitial ad.
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback:
            InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _interstitialLoadAttempts = 0;
        }, onAdFailedToLoad: (LoadAdError error) {
          _interstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_interstitialLoadAttempts <= maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        }));
  }

  /// Function to show the interstitial ad before navigating to the video screen.
  void _showInterstitialAd() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        _createInterstitialAd();
      }, onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        _createInterstitialAd();
      });
      _interstitialAd!.show();
    }
  }

  /// Initializes the interstitial ad when the state is initialized.
  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
  }

  /// Disposes of the interstitial ad when the state is disposed.
  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

  /// Builds the widget with a card layout representing the video item.
  /// Displays video details and thumbnail, handles tap event to navigate to
  /// the video screen after showing the interstitial ad.
  @override
  Widget build(BuildContext context) {
    // Build widget with a card layout representing the video item.
    // Details and thumbnail are displayed, tap event navigates to the video screen.
    // The interstitial ad is displayed before navigating to the video screen.
    return Card(
      elevation: 8.0,
      shadowColor: const Color(0xff2da9ef),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.threeLine,
        title: Text(widget.video.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            )),
        subtitle: Text(
          widget.video.description,
        ),
        leading: SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                        "assets/images/thumbnail_placeholder.jpg");
                  },
                  widget.video.thumbnail,
                  fit: BoxFit.fill,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 25.0,
                ),
              ),
            ],
          ),
        ),
        // trailing: const Icon(Icons.keyboard_arrow_right,
        //     color: Colors.black, size: 30.0),
        onTap: () {
          // Change to landscape mode before showing the interstitial ad
          AppUtils.changeToLandscape();
          _showInterstitialAd(); // Show the interstitial ad
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  VideoPlayScreen(videoUrl: widget.video.url),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          );
          _createInterstitialAd(); // Create a new interstitial ad after screen return
        },
      ),
    );
  }
}
