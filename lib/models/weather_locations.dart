import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather {
  String? cityName;
  String? main;
  double? temp;
  double? wind;
  int? humidity;
  double? feels_like;
  int? pressure;
  int? dt;

  Weather(
      {this.cityName,
      this.main,
      this.temp,
      this.wind,
      this.humidity,
      this.feels_like,
      this.pressure,
      this.dt});

  //functiion
  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    main = json["weather"][0]["main"];
    temp = json["main"]["temp"];
    wind = json["wind"]["speed"];
    pressure = json["main"]["pressure"];
    humidity = json["main"]["humidity"];
    feels_like = json["main"]["feels_like"];
    dt = json["dt"];
  }
}
