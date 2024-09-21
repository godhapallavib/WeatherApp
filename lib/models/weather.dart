import 'package:flutter/cupertino.dart';

class Weather with ChangeNotifier {

  Weather({
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.lat,
    required this.long,
    required this.feelsLike,
    required this.pressure,
    required this.description,
    required this.currently,
    required this.humidity,
    required this.windSpeed,
    required this.cityName,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      tempMax: ((json['main']['temp_max']) - 32).toDouble(),
      tempMin: ((json['main']['temp_min']) - 32).toDouble(),
      lat: json['coord']['lat'],
      long: json['coord']['lon'],
      feelsLike: json['main']['feels_like'].toDouble(),
      pressure: json['main']['pressure'],
      description: json['weather'][0]['description'],
      currently: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      cityName: json['name'],
    );
  }
  final double temp;
  final double tempMax;
  final double tempMin;
  final double lat;
  final double long;
  final double feelsLike;
  final int pressure;
  final String description;
  final String currently;
  final int humidity;
  final double windSpeed;
  final String cityName;
}
