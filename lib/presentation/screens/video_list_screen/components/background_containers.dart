import 'package:flutter/material.dart';

/// The `BackgroundContainer` class is a Flutter widget that creates a positioned
/// container with customizable background properties such as color, size, and
/// positioning.
///
/// This class is designed to display a colored container with optional rounded
/// corners (specified by `borderRadius`). The container's position can be
/// adjusted using `top`, `bottom`, `left`, and `right` parameters.
///
/// The `color` parameter represents the background color of the container.
/// The `height` and `width` parameters determine the size of the container.
/// The `borderRadius` parameter, if provided, creates rounded corners for the
/// container.
///
/// The constructor of `BackgroundContainer` requires at least a `color`,
/// `height`, and `width`. The other positional parameters (`top`, `bottom`,
/// `left`, `right`) can be used to position the container within a `Stack`.
class BackgroundContainer extends StatelessWidget {
  final Color color;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double height;
  final double width;
  final BorderRadiusGeometry? borderRadius;

  /// Constructor for BackgroundContainer requiring [color], [height], and [width].
  ///
  /// The [color] parameter represents the background color of the container.
  /// The [height] parameter determines the height of the container.
  /// The [width] parameter determines the width of the container.
  /// The [top], [bottom], [left], and [right] parameters adjust the positioning
  /// of the container within a `Stack`.
  ///
  /// The [borderRadius] parameter, if provided, creates rounded corners for the
  /// container. It accepts a `BorderRadius` or `BorderRadiusGeometry` object.
  const BackgroundContainer({
    Key? key,
    required this.color,
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.height,
    required this.width,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        height: height,
        width: width,
      ),
    );
  }
}
