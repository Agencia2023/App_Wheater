import 'package:weather/models/weather_locations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/weather_locations.dart';

class WheaterProvider {
  Future<Weather>? ObtenerWheater(String? location) async {
    //https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=8f36aa489bb280013ea4b3be2e70e2dc&units=metric
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=708e3eb8288be09ad973ce5fd6655c94&units=metric");
    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    return Weather.fromJson(body);
  }
}
