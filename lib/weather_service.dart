import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

/// Service gérant les appels aux APIs d'Open-Meteo (Géocodage et Prévisions)
class WeatherService {

  /// Pour afficher le chargement
  static ValueNotifier<bool> isLoading = ValueNotifier(false);

  /// Convertit un nom de ville en coordonnées
  /// Utilise l'API de géocodage d'Open-Meteo
  Future<Map<String, dynamic>?> getCoordinates(String cityName) async {
    isLoading.value = true; 

    final url = Uri.parse(
      'https://geocoding-api.open-meteo.com/v1/search?name=$cityName&count=1&language=fr&format=json'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Vérifie si la ville existe dans la base de données
        if (data['results'] != null && data['results'].isNotEmpty) {
          final result = data['results'][0];
          return {
            'lat': result['latitude'],
            'lon': result['longitude'],
            'name': result['name'],
          };
        }
      }
      isLoading.value = false; // Arrête le chargement en cas d'échec
      return {'error': "Ville non trouvée"};
    } catch (e) {
      debugPrint("Erreur lors du géocodage : $e"); // Log de l'erreur 
    }
    return null;
  }

  /// Récupère les données météo détaillées 
  Future<Map<String, dynamic>?> getWeather(double lat, double lon, String start, String end) async {
    isLoading.value = true;

    // Construction de l'URL 
    final url = Uri.parse(
      'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&start_date=$start&end_date=$end&hourly=temperature_2m,apparent_temperature,relative_humidity_2m,precipitation,cloud_cover,wind_speed_10m&daily=temperature_2m_max,temperature_2m_min,weathercode&timezone=auto'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Décode et retourne la réponse JSON
        return jsonDecode(response.body);
      }
    } catch (e) {
      debugPrint("Erreur lors de l'appel API météo : $e");
    } finally {
      isLoading.value = false;
    }
    return null;
  }
}