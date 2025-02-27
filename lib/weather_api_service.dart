import '../model/weather_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WeatherApiService {
  Future<WeatherResponse> getWeather(String url) async {
    try{
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final utfBody = convert.utf8.decode(response.bodyBytes);
        final responseMap = convert.jsonDecode(utfBody) as Map<String, dynamic>;
        return WeatherResponse.fromJson(responseMap);
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw Exception('天気情報取得APIでエラー発生: $e');
    }
  }
}