import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meteo_aquatech/weather_service.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  String cityName = "...";
  String temperature = "--";
  String felt = "--";
  String humidity = "--";
  String wind = "--";
  String precipitation = "--";
  String cloud = "--";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 54, 54, 211),
            Color(0xFF64B5F6),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _appBar(),
        body: Column(
          children: [
            _searchBar(),
            _nameCity(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                padding: const EdgeInsets.all(20),
                children: [
                  _buildWeatherCard(label: "Température", value: temperature, unit: "°C"),
                  _buildWeatherCard(label: "Ressentie", value: felt, unit: "°C"),
                  _buildWeatherCard(label: "Humidité", value: humidity, unit: "%"),
                  _buildWeatherCard(label: "Vent", value: wind, unit: "km/h"),
                  _buildWeatherCard(label: "Précipitations", value: precipitation, unit: "mm"),
                  _buildWeatherCard(label: "Nuages", value: cloud, unit: "%"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _nameCity() {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(50, 255, 255, 255),
            blurRadius: 40,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Text(
        cityName,
        style: const TextStyle(
          fontSize: 40,
          color: Color.fromARGB(200, 255, 255, 255),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(200, 0, 0, 0),
            blurRadius: 40,
          ),
        ],
      ),
      child: TextField(
        onSubmitted: (value) async { 
          setState(() {
            cityName = value;
          });

          final coords = await _weatherService.getCoordinates(value);

          if (coords != null) {
            print("Coordonnées de $value : Lat ${coords['lat']}, Lon ${coords['lon']}");
          } else {
            print("Ville non trouvée");
          }
        },
        decoration: InputDecoration(
          hintText: 'Rechercher une ville',
          hintStyle: const TextStyle(fontSize: 14),
          filled: true,
          fillColor: const Color.fromARGB(250, 255, 255, 255),
          contentPadding: const EdgeInsets.all(0),
          suffixIcon: SizedBox(
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.asset('assets/icons/calendar-days-svgrepo-com.svg'),
            ),
          ),
          prefixIcon: SizedBox(
            width: 50,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset('assets/icons/loupe-search-svgrepo-com (1).svg'),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherCard({required String label, required String value, required String unit}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(15, 255, 255, 255),
            blurRadius: 40,
          ),
        ],
        color: const Color.fromARGB(50, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(0, 255, 255, 255),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(
            'assets/icons/left-arrow-svgrepo-com (1).svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      title: const Text(
        "Météo",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(
              'assets/icons/three-dots-menu-svgrepo-com (1).svg',
              height: 20,
              width: 20,
            ),
          ),
        ),
      ],
    );
  }
}