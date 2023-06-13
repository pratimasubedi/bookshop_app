import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about_us_model.dart';

class ApiService {
  final baseURL = "";
  final Dio dio = Dio();

  Future<List<AboutUsModel>> fetchAboutUs() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    try {
      var response = await dio.get(
        "/about_us",
        options: Options(
          // Use Options instead of Type
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return List<AboutUsModel>.from(
          response.data['data'].map((x) => AboutUsModel.fromMap(x)));
    } on DioError catch (e) {
      throw Exception(e);
    }
  }
}

// class _cacheOptionsCalendar {}
