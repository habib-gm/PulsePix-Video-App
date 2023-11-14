// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';/ Import the VideoListItem class

// // Mock class for Mocking InterstitialAd
// class MockInterstitialAd extends Mock implements InterstitialAd {}

// void main() {
//   group('VideoListItem Widget Tests', () {
//     late VideoData videoData;
//     late MockInterstitialAd mockInterstitialAd;

//     setUp(() {
//       videoData = VideoData(
//         title: 'Sample Title',
//         description: 'Sample Description',
//         thumbnail: 'sample_thumbnail_url',
//         url: 'sample_video_url',
//       );
//       mockInterstitialAd = MockInterstitialAd();
//     });

//     testWidgets('VideoListItem displays video details', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Material(
//             child: VideoListItem(video: videoData),
//           ),
//         ),
//       );

//       // Verify that the video details are displayed correctly
//       expect(find.text('Sample Title'), findsOneWidget);
//       expect(find.text('Sample Description'), findsOneWidget);
//       expect(find.byType(Image), findsOneWidget);
//     });

//     testWidgets('VideoListItem navigates to VideoPlayScreen onTap', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Material(
//             child: VideoListItem(video: videoData),
//           ),
//         ),
//       );

//       // Mock Navigator
//       final mockNavigatorObserver = MockNavigatorObserver();
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Material(
//             child: VideoListItem(video: videoData),
//           ),
//           navigatorObservers: [mockNavigatorObserver],
//         ),
//       );

//       // Tap on the VideoListItem
//       await tester.tap(find.byType(ListTile));
//       await tester.pumpAndSettle();

//       // Verify that the interstitial ad is shown and VideoPlayScreen is pushed to Navigator
//       verify(mockInterstitialAd.show()).called(1);
//       verify(mockNavigatorObserver.didPush(any, any)).called(1);
//       expect(find.byType(VideoPlayScreen), findsOneWidget);
//     });
//   });
// }
