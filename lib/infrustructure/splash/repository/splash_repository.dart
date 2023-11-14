import '../data_provider/splash_data_provider.dart';

class SplashRepository {
  final SplashDataProvider splashDataProvider;

  SplashRepository({required this.splashDataProvider});

  Future<Map<String, dynamic>> fetchData() async {
    return splashDataProvider.fetchData();
  }
}
