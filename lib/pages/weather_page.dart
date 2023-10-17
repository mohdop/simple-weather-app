import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/service/weatherService.dart';

class weather_app extends StatefulWidget {
  const weather_app({super.key});

  @override
  State<weather_app> createState() => _weather_appState();
}

class _weather_appState extends State<weather_app> {

  final _weatherService = WeatherService("6857c12a136b73294cf12c60698e74f4");
  Weather? _weather; //Weather object to store the data from API call

  //fetch weather
_fetchWeather() async {
  // get the current city
  String cityName = await _weatherService.getCurrentCity();

  try {
    // get weather for city
    final weather = await _weatherService.getWeather(cityName);
    print("Weather Data: $weather"); // Add this line
    setState(() {
      _weather = weather;
    });
  } catch (e) {
    print("Error fetching weather: $e"); // Add this line
  }
}
 //weather animations
 String getWeatherAnimation(String? mainCondition){
  if(mainCondition == null) return "assets/sun.json";
  switch (mainCondition.toLowerCase()) {
    case "clouds":
    case "few clouds":
    case "mist":
    case "smoke":
    case "haze":
    case "fog":
    return "assets/cloud.json";
    case "rain":
    case "drizzle":
    case "shower rain":
    return "assets/rain.json";
    case "thunderstorm":
    return "assets/thunder.json";
    case "clear":
    return "assets/sun.json";
    default:
    return "assets/sun.json";
  }
 }
  // initState
@override
void initState() {
  super.initState();
  // fetch weather on startup
  _fetchWeather();
}

// UI Rendering
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // city name
          Text(_weather?.cityName ?? "Loading city..."),

          Lottie.asset(getWeatherAnimation(_weather?.mainCondition?? "")),
          // temperature
          Text("${_weather?.temperature.round()}°C"),

          // condition
          Text(_weather?.mainCondition?? "")
        ],
      ),
    ),
  );
}

}
