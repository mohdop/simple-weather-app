import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather.dart';
import 'package:weather_app/model/weatherr.dart';
import 'package:weather_app/pages/widgets.dart';
import 'package:weather_app/service/weatherService.dart';

class weather_app extends StatefulWidget {
  const weather_app({super.key});

  @override
  State<weather_app> createState() => _weather_appState();
}

class _weather_appState extends State<weather_app> {

  final _weatherService = WeatherService("6857c12a136b73294cf12c60698e74f4");
  Weather? _weather; //Weather object to store the data from API call
  Weatherr? _weatherr;
  
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
 
  body: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.blue[100]!,Colors.blue[200]!,Colors.blue[300]!], // Replace with your desired colors
      ),
    ),
    child: Column(
      children: [
         Padding(
           padding: const EdgeInsets.only(top:50.0),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                 padding: const EdgeInsets.only(left: 2.0),
                 child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back, color: Colors.white),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 0),
                 child: Row(
            children: [
              FutureBuilder<String>(
                future: _weatherService.getCurrentCountry(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading country...",style: TextStyle(fontSize: 20, color: Colors.white),);
                  } else if (snapshot.hasError) {
                    return Text("Error loading country",style: TextStyle(fontSize: 20, color: Colors.white),);
                  } else {
                    return Text(
                      snapshot.data ?? "Unknown country",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    );
                  }
                },
              ),
              Text(", ", style: TextStyle(fontSize: 20, color: Colors.white),),
              Text(
                _weather?.cityName ?? "Loading city...",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(right: 10.0),
                 child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz, color: Colors.white),
                 ),
               ),
              ],
           ),
         ),
    
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // city name
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition ?? ""), height: 150, width: 150),
              // temperature
              Column(
                children: [
                  Text(
                    "${_weather?.temperature.round()}°C",
                    style: TextStyle(fontSize: 32,color: Colors.white),
                  ),
                  // condition
                  Text(_weather?.mainCondition ?? "", style: TextStyle(fontSize: 22,color: Colors.white)),
                  Text("${_weatherr?.minTemperature.round()}°C / ${_weatherr?.maxTemperature.round()}°C",style: TextStyle(color: Colors.white),),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:88.0,left: 12,right: 12,bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  infoWeather(CupertinoIcons.cloud_sun_rain, "Rain","4%"),
                  infoWeather(CupertinoIcons.wind, "Wind","4 km/h")
                ],
              ),
              Column(
                children: [
                  infoWeather(CupertinoIcons.drop, "Humidity","24%"),
                  infoWeather(CupertinoIcons.sun_min,"UV index","High")
                ],
              )
            ],
          ),
        ),
        Padding(
          padding:  EdgeInsets.all(12),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(28),
                          
                        ),
            child: Padding(padding: EdgeInsets.only(top: 12,bottom: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
               forecast("11", "assets/cloud.json", "${_weather?.temperature.round()}°C","4%"),
               forecast("12", "assets/sun.json", "${_weather?.temperature.round()}°C","0%"),
               forecast("13", "assets/cloudy sun.json", "${_weather?.temperature.round()}°C","2%"),
               forecast("14", "assets/rain.json", "${_weather?.temperature.round()}°C","8%"),
               forecast("15", "assets/thunder.json", "${_weather?.temperature.round()}°C","12%"),
               forecast("16", "assets/cloud.json", "${_weather?.temperature.round()}°C","4%"),
               forecast("17", "assets/cloud.json", "${_weather?.temperature.round()}°C","4%"),
               forecast("18", "assets/cloud.json", "${_weather?.temperature.round()}°C","4%"),

              ],),
            ),
            ),
          ),
        )

      ],
      
    ),
  ),
);

}

}

