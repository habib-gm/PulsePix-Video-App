import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class DataProvider {
  // String _baseUrl = 'http://10.0.2.2:8000';
  // String _baseUrl = 'http://10.0.2.2:5006/coffeeNet-api/api/v1';
  String? _baseUrl = dotenv.env["API_URL"];
  get baseUrl => _baseUrl;
  set baseUrl(baseurl) {
    _baseUrl = baseUrl;
  }
}
