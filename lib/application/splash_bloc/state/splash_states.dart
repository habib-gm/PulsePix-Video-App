import 'package:flutter/material.dart';

import '../../../domain/video_data/video_data.dart';

abstract class SplashState {}

class InitialState extends SplashState {}

class LoadingState extends SplashState {}

class DataLoadedState extends SplashState {
  final Color color;
  final List<VideoData> videos;

  DataLoadedState({required this.color, required this.videos});
}

class ErrorState extends SplashState {
  final String error;

  ErrorState({required this.error});
}
