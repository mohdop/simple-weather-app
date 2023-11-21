class Weatherr {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final double minTemperature;
  final double maxTemperature;

  Weatherr({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.minTemperature,
    required this.maxTemperature,
  });

  factory Weatherr.fromJson(Map<String, dynamic> json) {
    return Weatherr(
      cityName:json['name'],
      temperature: json['main']['temp'] ,
      mainCondition : json['weather'][0]['description'],
      maxTemperature: json['temp'][2]["max"],
      minTemperature: json['temp'][1]['min'],
    );
  }
}
