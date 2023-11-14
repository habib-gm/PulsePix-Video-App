import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../../domain/video_data/video_data.dart';
import '../../../exceptions/splash_exceptions/splash_exceptions.dart';
import '../../../services/app_utils.dart';
import '../../core/data_provider.dart';

class SplashDataProvider extends DataProvider {
  Future<Map<String, dynamic>> fetchData() async {
    try {
      Uri uri = Uri.parse('$baseUrl/list.json');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = response.body;
        if (kDebugMode) {
          print(jsonData);
        }
        await saveJsonToLocal(jsonData);
        final decodedData = await compute(decodeJsonInBackground, jsonData);
        decodedData['internet'] = false;
        return decodedData;
      } else {
        final jsonData = await readJsonFromLocal();
        if (jsonData.isEmpty) {
          throw NoDataFoundException(message: 'No data available');
        }
        final decodedData = await compute(decodeJsonInBackground, jsonData);
        decodedData['internet'] = false;
        return decodedData;
      }
    } catch (e) {
      try {
        final jsonData = await readJsonFromLocal();
        if (jsonData.isEmpty) {
          throw NoDataFoundException(message: 'No data available');
        }
        final decodedData = await compute(decodeJsonInBackground, jsonData);
        decodedData['internet'] = false;
        return decodedData;
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching data: $e');
        }
        throw ErrorFetchingData(message: e.toString());
      }
    }
  }

  Future<void> saveJsonToLocal(String data) async {
    final file = await _localFile;
    await file.writeAsString(data);
  }

  Future<String> readJsonFromLocal() async {
    try {
      final file = await _localFile;
      return await file.readAsString();
    } catch (e) {
      if (kDebugMode) {
        print('Error reading local data: $e');
      }
      return '';
    }
  }

  static Map<String, Object> decodeJsonInBackground(String jsonData) {
    final Map<String, dynamic> jsonMap = json.decode(jsonData);
    final List<VideoData> videos = [];

    jsonMap['videos'].forEach((value) {
      videos.add(VideoData(
          title: value["videoTitle"],
          url: Uri.parse(value["videoUrl"]),
          description: value["videoDescription"] ?? '',
          thumbnail: value['videoThumbnail'] ?? ''));
    });

    return {
      'video': videos,
      'color':
          AppUtils.extractAppBackgroundColor(jsonMap['appBackgroundHexColor']),
    };
  }

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/list.json');
  }
}
