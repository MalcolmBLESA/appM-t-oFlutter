
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
  DateTimeRange? selectedDateRange;
  List<dynamic> dailyForecasts = [];

  Future<void> _pickDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 14)),
      saveText: 'Valider',
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
      _fetchWeatherData();
      }
      
    }

    Future<void> _fetchWeatherData() async {
  if (cityName == "..." || cityName.isEmpty) return;

  String start, end;
  if (selectedDateRange != null) {
    start = selectedDateRange!.start.toIso8601String().split('T')[0];
    end = selectedDateRange!.end.toIso8601String().split('T')[0];
  } else {
    start = DateTime.now().toIso8601String().split('T')[0];
    end = DateTime.now().add(const Duration(days: 6)).toIso8601String().split('T')[0];
  }
  final coords = await _weatherService.getCoordinates(cityName);

  if (coords != null) {
    final data = await _weatherService.getWeather(coords['lat']!, coords['lon']!, start, end);
    
    if (data != null) {
      setState(() {
        String nowHour = DateTime.now().toIso8601String().substring(0, 13) + ":00";
        int index = data['hourly']['time'].indexOf(nowHour);
        if (index == -1) index = 0;

        temperature = data['hourly']['temperature_2m'][index].toString();
        felt = data['hourly']['apparent_temperature'][index].toString();
        humidity = data['hourly']['relative_humidity_2m'][index].toString();
        wind = data['hourly']['wind_speed_10m'][index].toString();
        precipitation = data['hourly']['precipitation'][index].toString();
        cloud = data['hourly']['cloud_cover'][index].toString();

        dailyForecasts = [];
        for (int i = 0; i < data['daily']['time'].length; i++) {
          dailyForecasts.add({
            'day': data['daily']['time'][i],
            'max': data['daily']['temperature_2m_max'][i],
            'min': data['daily']['temperature_2m_min'][i],
            'code': data['daily']['weathercode'][i],
          });
        }
      });
    }
  }
}


  Map<String, String> getNextSevenDays() {
  DateTime now = DateTime.now();
  DateTime sevenDaysLater = now.add(Duration(days: 6)); // J+6 pour avoir 7 jours au total

  return {
    'start': now.toIso8601String().split('T')[0],
    'end': sevenDaysLater.toIso8601String().split('T')[0],
  };
}

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              _searchBar(),
              _nameCity(),
              _dailyForecastList(),
              _responsiveWheatherCard(),
            ],
          ),
        ),
      ),
    );
  }

  LayoutBuilder _responsiveWheatherCard() {
    return LayoutBuilder(
              builder: (context, constraints) {
                
                int crossAxisCount = constraints.maxWidth > 800 ? 6 : (constraints.maxWidth > 500 ? 3 : 2);
                
                return GridView.count(
                  
                  shrinkWrap: true,           
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  
                  childAspectRatio: 1.0, 
                  children: [
                    _buildWeatherCard(label: "Température", value: temperature, unit: "°C"),
                    _buildWeatherCard(label: "Ressentie", value: felt, unit: "°C"),
                    _buildWeatherCard(label: "Humidité", value: humidity, unit: "%"),
                    _buildWeatherCard(label: "Vent", value: wind, unit: "km/h"),
                    _buildWeatherCard(label: "Précipitations", value: precipitation, unit: "mm"),
                    _buildWeatherCard(label: "Nuages", value: cloud, unit: "%"),
                  ],
                );
              },
            );
  }


  Widget _nameCity() {
    return Container(
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
          BoxShadow(color: Color.fromARGB(200, 0, 0, 0), blurRadius: 40),
        ],
      ),
      child: TextField(
        onSubmitted: (value) async {
          setState(() {
          cityName = value; // On enregistre d'abord le nom
          });
          _fetchWeatherData();
        },
        decoration: InputDecoration(
          hintText: 'Rechercher une ville',
          hintStyle: const TextStyle(fontSize: 14),
          filled: true,
          fillColor: const Color.fromARGB(250, 255, 255, 255),
          contentPadding: const EdgeInsets.all(0),
          suffixIcon: GestureDetector(
            onTap: _pickDateRange, 
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
      constraints: const BoxConstraints(
      minWidth: 100, 
      maxWidth: 150,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(50, 255, 255, 255),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          Text(unit, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.all(15),
        child: SvgPicture.asset('assets/icons/left-arrow-svgrepo-com (1).svg'),
      ),
      title: const Text("Météo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      actions: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: SvgPicture.asset('assets/icons/three-dots-menu-svgrepo-com (1).svg'),
        ),
      ],
    );
  }


  Widget _dailyForecastList() {
  if (dailyForecasts.isEmpty) return const SizedBox();

  return SizedBox(
    height: 150,
    child: Center(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: dailyForecasts.length,
        itemBuilder: (context, index) {
          var dayData = dailyForecasts[index];
          
          DateTime date = DateTime.parse(dayData['day']);
          List<String> weekdays = ["Lun.", "Mar.", "Mer.", "Jeu.", "Ven.", "Sam.", "Dim."];
          String dayName = weekdays[date.weekday - 1];

          return Container(
            width: 90,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(dayName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                
                Icon(
                  dayData['code'] > 75 ? Icons.cloud : Icons.wb_sunny,
                  color: dayData['code'] > 50 ? Colors.white : Colors.yellow[600],
                ),
                const SizedBox(height: 8),
                Text("${dayData['max']}°", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text("${dayData['min']}°", style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          );
        },
      ),
    ),
  );
}
}