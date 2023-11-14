import 'package:flutter/material.dart';
import '../../../application/splash_bloc/splash.dart';
import 'components/error.dart';
import 'components/loading.dart';
import '../video_list_screen/video_list_screen.dart';

/// The `SplashScreen` class is a Flutter widget responsible for displaying
/// different screens based on the state received from the `SplashBloc`. It
/// functions as the initial screen and reacts to different states such as
/// loading, data loaded, and error states.
///
/// This class utilizes `BlocBuilder` from the `flutter_bloc` package to listen
/// to the state changes emitted by the `SplashBloc`. Depending on the received
/// state, it dynamically renders different screens:
///
/// - When the state is `LoadingState`, it displays the `LoadingScreen`.
/// - When the state is `DataLoadedState`, it shows the `ListScreen` by passing
///   the videos and color from the state.
/// - When the state is `ErrorState`, it presents the `ErrorScreen` with the
///   error information.
/// - For any other unknown state, it displays an empty `Container`.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const LoadingScreen();
        } else if (state is DataLoadedState) {
          return ListScreen(videos: state.videos, color: state.color);
        } else if (state is ErrorState) {
          return ErrorScreen(error: state.error);
        } else {
          return Container();
        }
      },
    );
  }
}
