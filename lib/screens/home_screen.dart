import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima_col/services/weather_service.dart';
import 'package:clima_col/services/location_service.dart';
import 'package:clima_col/screens/forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, Position? currentPosition, required String weatherData}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherService weatherService = WeatherService();
  LocationService locationService = LocationService();

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> _getWeather() async {
    final location = await locationService.getLocation();
    if (location != null) {
      final latitude = location.latitude ?? 0.0;
      final longitude = location.longitude ?? 0.0;
      final data = await weatherService.getCurrentWeather(latitude, longitude, lang: 'es'); // Añadir el parámetro de idioma
      return data;
    }
    return {};
  }

  Stream<Map<String, dynamic>> _weatherUpdates() async* {
    while (true) {
      final data = await _getWeather();
      yield data;
      await Future.delayed(const Duration(minutes: 10)); // Actualizar cada 10 minutos
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima Actual'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tu_imagen.jpg'), // Asegúrate de tener esta imagen en tu proyecto
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<Map<String, dynamic>>(
          stream: _weatherUpdates(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final weatherData = snapshot.data!;
              final cityName = weatherData['name'];
              final temperature = weatherData['main']['temp'];
              final description = weatherData['weather'][0]['description'];

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$temperature°C',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 60,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$cityName',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$description',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForecastScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                      ),
                      child: const Text('Ver Pronóstico'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.transparent,
                      ),
                      child: const Icon(Icons.refresh),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No hay datos disponibles'));
            }
          },
        ),
      ),
    );
  }
}
