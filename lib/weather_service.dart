
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
  Future<Map<String, dynamic>?> getWeather(double lat, double lon, String start, String end) async {
  final url = Uri.parse(
    'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&start_date=$start&end_date=$end&hourly=temperature_2m,apparent_temperature,relative_humidity_2m,precipitation,cloud_cover,wind_speed_10m&timezone=auto'
  );

  final response = await http.get(url);
  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }
  return null;
}
}

