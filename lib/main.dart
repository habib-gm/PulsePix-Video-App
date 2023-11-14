import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'application/splash_bloc/splash.dart';
import 'infrustructure/splash/data_provider/splash_data_provider.dart';
import 'infrustructure/splash/repository/splash_repository.dart';
import 'presentation/screens/splash_screen/splash_screen.dart';
import 'services/app_utils.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await dotenv.load();
  AppUtils.changeStatusBarColor(color: Colors.black);
  runApp(const MyApp());
}

/// The `MyApp` class represents the root of the Flutter application.
///
/// This class is a `StatelessWidget` that initializes the application by
/// configuring the root `MaterialApp`. It sets the `debugShowCheckedModeBanner`
/// to false and sets the `home` property to display the initial screen.
///
/// Within the `MaterialApp`, it uses `RepositoryProvider` and `BlocProvider`
/// to provide the required repositories and blocs for the application's
/// state management. It initializes the `SplashRepository` and `SplashBloc`
/// while triggering the `FetchDataEvent` to load initial data.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RepositoryProvider(
          create: (context) =>
              SplashRepository(splashDataProvider: SplashDataProvider()),
          child: BlocProvider(
            create: (context) => SplashBloc(
                splashRepo: RepositoryProvider.of<SplashRepository>(context))
              ..add(FetchDataEvent()),
            child: const SplashScreen(),
          ),
        ));
  }
}
