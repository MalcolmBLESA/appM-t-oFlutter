import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  _buildWeatherCard(label: "Température", value: "22", unit: "°C"),
                  _buildWeatherCard(label: "Ressentie", value: "24", unit: "°C"),
                  _buildWeatherCard(label: "Humidité", value: "78", unit: "%"),
                  _buildWeatherCard(label: "Vent", value: "15", unit: "km/h"),
                  _buildWeatherCard(label: "Précipitations", value: "0.5", unit: "mm"),
                  _buildWeatherCard(label: "Nuages", value: "60", unit: "%"),
                ],)
                ),
          ],  
        ),
      ),
    );
  }

  Container _nameCity() {
    return  Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(50, 255, 255, 255),
                  blurRadius: 40,
                  
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Text(
              "Ville",
              style: TextStyle(fontSize: 40, color: Color.fromARGB(200, 255, 255, 255)
              ),
            ),
          );
  }

  Container _searchBar() {
    return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(200, 0, 0, 0),
                  blurRadius: 40,
                  
                ),
              ],
            ),
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher une ville',
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
                filled: true,
                fillColor: const Color.fromARGB(250, 255, 255, 255),
                contentPadding: const EdgeInsets.all(0),
                suffixIcon: Container(
                  width: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset('assets/icons/calendar-days-svgrepo-com.svg'),
                    ),
                ),
                prefixIcon: Container(
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
  Widget _buildWeatherCard({required String label, required String value, required String unit}) {
  return Container(
    width: 5,
    height: 5,
    decoration: BoxDecoration(
      boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(15, 255, 255, 255),
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
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          unit, 
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    ),
  );
}
}

