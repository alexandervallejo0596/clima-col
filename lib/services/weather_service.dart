import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '1309b6eeef51d5858b65966ff2dbcdfa';

  Future<Map<String, dynamic>> getCurrentWeather(double latitude, double longitude, {String lang = 'es'}) async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey&lang=$lang');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el clima: ${response.statusCode} ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> getForecast(double latitude, double longitude, {String lang = 'es'}) async {
    final url = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&units=metric&cnt=3&appid=$apiKey&lang=$lang');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el pronóstico: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
