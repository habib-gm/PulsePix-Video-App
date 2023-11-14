import 'package:flutter/material.dart';

import '../../../domain/video_data/video_data.dart';
import '../../widgets/app_bar.dart';
import 'components/background_containers.dart';
import 'components/video_list.dart';

/// The `ListScreen` class is a Flutter widget that represents a screen layout
/// for displaying a list of video data. It utilizes a `Scaffold` widget to
/// structure the layout with a custom app bar and a `Stack` widget to overlay
/// various background containers, creating an aesthetically pleasing design.
///
/// This class requires a list of `VideoData` and a color as parameters. It
/// renders the provided videos within a `VideoList` widget if the video list
/// is not empty. In the case of an empty video list, it displays a message
/// indicating the absence of data.
///
/// The layout design incorporates curved and circular shapes placed at specific
/// positions on the screen, achieved using multiple `BackgroundContainer`
/// widgets. These containers are styled with different colors and sizes,
/// contributing to an appealing and artistic background design.
///
/// Overall, the `ListScreen` class orchestrates the visual presentation of
/// video data in a structured layout, catering to scenarios with both available
/// and empty video data, while providing an artistically designed backdrop.
class ListScreen extends StatelessWidget {
  final List<VideoData> videos;
  final Color color;

  /// Constructor for ListScreen requiring [videos] and [color].
  ///
  /// The [videos] parameter represents the list of video data to be displayed.
  /// The [color] parameter represents the color scheme of the screen.
  const ListScreen({super.key, required this.videos, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Stack(
        children: [
          // BackgroundContainer with provided color, covering the whole screen
          BackgroundContainer(
            color: color,
            top: 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          // BackgroundContainer forming the top curved design
          BackgroundContainer(
            color: const Color(0xFF2C2C2C),
            top: 0,
            height: MediaQuery.of(context).size.height / 11,
            width: MediaQuery.of(context).size.width,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100),
            ),
          ),
          // BackgroundContainer forming circular design on top right
          BackgroundContainer(
            bottom: MediaQuery.of(context).size.width / 1.3,
            right: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 8,
            width: MediaQuery.of(context).size.width / 8,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            // color: Color(0xFF2C2C2C),
            color: Colors.white,
          ),
          // BackgroundContainer forming smaller circular design on top right
          BackgroundContainer(
            color: const Color(0xFF2C2C2C),
            bottom: MediaQuery.of(context).size.width / 2,
            right: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 4,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          // BackgroundContainer forming larger circular design on top right
          BackgroundContainer(
            color: const Color(0xFF2C2C2C),
            bottom: MediaQuery.of(context).size.width / 4,
            right: -50,
            height: MediaQuery.of(context).size.width / 4,
            width: MediaQuery.of(context).size.width / 4,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          // BackgroundContainer forming circular design on bottom right
          BackgroundContainer(
            bottom: MediaQuery.of(context).size.width / 8,
            right: MediaQuery.of(context).size.width / 8,
            height: MediaQuery.of(context).size.width / 8,
            width: MediaQuery.of(context).size.width / 8,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            // color: Color(0xFF2C2C2C),
            color: Colors.white,
          ),
          // BackgroundContainer forming smaller circular design on bottom right
          BackgroundContainer(
            color: const Color(0xFF2C2C2C),
            bottom: -50,
            left: -50,
            height: MediaQuery.of(context).size.height / 11,
            width: MediaQuery.of(context).size.width / 1.5,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          // Conditionally rendered widget if videos list is empty
          videos.length == 0
              ? Positioned(
                  top: MediaQuery.of(context).size.height / 2.5,
                  child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(25),
                      child:
                          Text("Empty List,\n No data available currently...")),
                )
              : VideoList(videos: videos),
        ],
      ),
    );
  }
}
