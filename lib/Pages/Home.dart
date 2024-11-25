import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/Models/weather_model.dart';
import 'package:weather_app/Services/weather_service.dart';

import 'GetStarted.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _homeState();
}

class _homeState extends State<Home> {
  //api key
  final _weatherService = WeatherService('00e76cd3fb206726cedbd87a96db5ccb');
  weather? _weather;
  //fetch weather
  _fetchWeather() async {
    // get current city
    String cituName = await _weatherService.getCurentCity();
    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cituName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animation
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
        return 'assets/Cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/stormy.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  //weather animation
  Color getWeatherBackgroundColor(String? mainCondition) {
    if (mainCondition == null) return Colors.amberAccent;

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'fog':
        return Colors.grey;
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return const Color(0xFF01579B);
      case 'thunderstorm':
        return const Color(0xFF6A1B9A);
      case 'clear':
        return Colors.amberAccent;
      default:
        return Colors.amberAccent;
    }
  }

  @override
  void initState() {
    super.initState();
    //fetch weather
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Dynamically set font size based on screen size
    double fontSize = screenWidth * 0.06; // 6% of screen width
    double smallFontSize = screenWidth * 0.05; // 5% of screen width

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'signout') {
                // Sign out logic
                await FirebaseAuth.instance.signOut();

                // Navigate to GetStarted/Login page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Getstarted()),
                  (route) => false,
                );
              }
            },
            icon: Icon(
              Icons.account_circle,
              color: Colors.white, // Adjust the color as per your theme
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'signout',
                child: Text('Sign Out'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: getWeatherBackgroundColor(_weather?.mainCondition),
      body: Center(
        child: SingleChildScrollView(
          // To allow scrolling on smaller screens
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // City name
              Text(
                _weather?.cityName ?? "Loading city...",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    fontStyle: FontStyle.italic),
              ),

              // Animation
              SizedBox(
                height: screenHeight *
                    0.1, // 10% of screen height for animation spacing
              ),
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
              SizedBox(
                height: screenHeight * 0.05, // 5% of screen height for spacing
              ),

              // Temperature
              Text(
                '${_weather?.temperature.round()}°C',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    fontStyle: FontStyle.italic),
              ),

              // Weather condition
              Text(
                _weather?.mainCondition ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: smallFontSize,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
