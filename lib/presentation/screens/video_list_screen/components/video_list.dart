import 'package:flutter/material.dart';

import '../../../../domain/video_data/video_data.dart';
import 'video_list_item.dart';

/// The `VideoList` class is a Flutter widget responsible for displaying a list
/// of video data using a `ListView.builder`. It receives a list of `VideoData`
/// as a parameter and generates a scrollable list of `VideoListItem` widgets
/// based on the provided video data.
///
/// The `videos` parameter represents the list of `VideoData` to be displayed in
/// the video list.
///
/// Inside the `build` method, this class utilizes `ListView.builder` to
/// efficiently construct a scrollable list based on the length of the `videos`
/// list. For each item in the list, it creates a `VideoListItem` using the
/// `VideoData` at the corresponding index.
class VideoList extends StatelessWidget {
  final List<VideoData> videos;

  /// Constructor for VideoList requiring [videos].
  const VideoList({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return VideoListItem(video: videos[index]);
      },
    );
  }
}
