import 'package:flutter/material.dart';
import 'package:clima_col/services/weather_service.dart';
import 'package:clima_col/services/location_service.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({Key? key}) : super(key: key);

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  WeatherService weatherService = WeatherService();
  LocationService locationService = LocationService();
  late List<dynamic> forecastData = []; // Inicializa con una lista vacía

  @override
  void initState() {
    super.initState();
    _getForecast();
  }

  Future<void> _getForecast() async {
    try {
      final location = await locationService.getLocation();
      if (location != null) {
        final latitude = location.latitude ?? 0.0; // Proporciona un valor predeterminado
        final longitude = location.longitude ?? 0.0; // Proporciona un valor predeterminado
        final data = await weatherService.getForecast(latitude, longitude);
        setState(() {
          forecastData = data['list'].take(3).toList();
        });
      }
    } catch (e) {
      print('Error al obtener el pronóstico: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pronóstico'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/tu_imagen.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: forecastData.isEmpty
                  ? const CircularProgressIndicator()
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: forecastData.map((day) {
                  int index = forecastData.indexOf(day);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Día ${index + 1}',
                          style: const TextStyle(
                            color: Colors.black, // Texto en negro
                            fontSize: 36, // Tamaño de letra aumentado
                            fontWeight: FontWeight.bold, // Grosor de letra aumentado
                          ),
                        ),
                        const SizedBox(height: 8.0), // Espacio entre el título y el subtítulo
                        Text(
                          '${day['main']['temp']}°C, ${day['weather'][0]['description']}',
                          style: const TextStyle(
                            color: Colors.black, // Texto en negro
                            fontSize: 30, // Tamaño de letra aumentado
                            fontWeight: FontWeight.bold, // Grosor de letra aumentado
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
