import 'package:flutter/material.dart';
import 'package:clima_col/screens/home_screen.dart';
import 'package:clima_col/screens/forecast_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  await Permission.locationWhenInUse.request();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima Col',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreenWrapper(),
      routes: {
        '/forecast': (context) => const ForecastScreen(),
      },
    );
  }
}

class HomeScreenWrapper extends StatefulWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  _HomeScreenWrapperState createState() => _HomeScreenWrapperState();
}

class _HomeScreenWrapperState extends State<HomeScreenWrapper> {
  String _savedData = '';

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedData = prefs.getString('weatherData') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen(weatherData: _savedData);
  }
}
