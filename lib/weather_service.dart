import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

const String apiBaseUrl = 'api.weatherapi.com';
const String apiPath = '/v1/current.json';
const String apiKey = '410b5f59199a4f079f1212528241712';

class WeatherService {
  Future<WeatherModel> getWeather(String city) async {
    final uri = Uri.https(apiBaseUrl, apiPath, {'key': apiKey, 'q': city});
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
