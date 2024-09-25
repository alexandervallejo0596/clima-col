// weather_card.dart
import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final double temperature;
  final String description;
  final String icon;

  const WeatherCard({Key? key,
    required this.temperature,
    required this.description,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Temperatura: $temperature°C',
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            description,
            style: const TextStyle(fontSize: 18),
          ),
          Image.network('https://openweathermap.org/img/w/$icon.png'),
        ],
      ),
    );
  }
}
