// forecast_card.dart
import 'package:flutter/material.dart';

class ForecastCard extends StatelessWidget {
  final String day;
  final double maxTemp;
  final double minTemp;
  final String description;
  final String icon;

  const ForecastCard({Key? key,
    required this.day,
    required this.maxTemp,
    required this.minTemp,
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
            day,
            style: const TextStyle(fontSize: 24),
          ),
          Text(
            'Max: $maxTemp°C',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Min: $minTemp°C',
            style: const TextStyle(fontSize: 18),
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
