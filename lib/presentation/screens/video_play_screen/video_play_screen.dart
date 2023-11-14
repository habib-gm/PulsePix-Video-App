import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../../services/app_utils.dart';

/// The `VideoPlayScreen` class displays and plays a video specified by [videoUrl].
///
/// This screen utilizes the `Chewie` video player package to render and control
/// the video playback. It handles video initialization, error handling, and
/// orientation changes during video playback.
class VideoPlayScreen extends StatefulWidget {
  final Uri videoUrl;

  /// Constructor for VideoPlayScreen widget, requiring a [videoUrl] to play.
  const VideoPlayScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayScreenState createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late Future<ChewieController> _chewieControllerFuture;
  late final VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(widget.videoUrl);
    _chewieControllerFuture =
        AppUtils.initializeVideoPlayer(videoPlayerController);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppUtils.changeToPortriatUp();
        return true;
      },
      child: SafeArea(
          child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: FutureBuilder<ChewieController>(
                  future: _chewieControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return _buildErrorWidget(); // Display error UI
                    } else if (snapshot.hasData) {
                      return _buildVideoPlayer(snapshot.data!);
                    } else {
                      return const SizedBox
                          .shrink(); // Handle other states if necessary
                    }
                  },
                ),
              ),
              Positioned(
                top: 3,
                left: 3,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    AppUtils.changeToPortriatUp();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  /// Builds the error UI widget when video loading encounters an error.
  Column _buildErrorWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textAlign: TextAlign.center,
          "Error, Please try again later \n Do not forget to check your network",
          style: TextStyle(color: Colors.red),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          child: const Text(
            'Retry Again',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            setState(() {
              _chewieControllerFuture =
                  AppUtils.initializeVideoPlayer(videoPlayerController);
            });
          },
        ),
      ],
    );
  }

  /// Builds the video player widget using the Chewie controller.
  Widget _buildVideoPlayer(ChewieController chewieController) {
    return Expanded(
      child: Chewie(
        controller: chewieController,
      ),
    );
  }
}
