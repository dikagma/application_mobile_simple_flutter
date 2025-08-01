import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MeteoService{
  static String? apiKey = dotenv.env['OPENAI_API_KEY'];//'d6575d63321e26e461b9eac276cf80ff';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Map<String, dynamic>?> getWeather(String city) async {
    final url = Uri.parse(
        '$baseUrl?q=$city&appid=$apiKey&units=metric&lang=fr');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Erreur API : ${response.statusCode}');

      return null;
    }
  }



}