
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, double>?> getCoordinates(String cityName) async {
    final url = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=1&language=fr&format=json'
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['results'] != null && data['results'].isNotEmpty) {
          final result = data['results'][0];
          return {
            'lat': result['latitude'],
            'lon': result['longitude'],
          };
        }
      }
    } catch (e) {
      print("Erreur réseau : $e");
    }
    return null;
  }
}