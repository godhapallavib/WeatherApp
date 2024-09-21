import 'package:flutter/cupertino.dart';

class DailyWeather with ChangeNotifier {
  DailyWeather({
    this.dailyTemp,
    this.condition,
    this.date,
    this.precip,
    this.uvi,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> dailyData) {
    const double precipData = 0.05;
    const double calcPrecip = precipData * 100;
    final String precipitation = calcPrecip.toStringAsFixed(0);
    return DailyWeather(
      precip: precipitation,
      uvi: 2,
    );
  }
  final dynamic dailyTemp;
  final String? condition;
  final DateTime? date;
  final String? precip;
  final int? uvi;

  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp']['day'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
    );
  }

  static DailyWeather fromHourlyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
