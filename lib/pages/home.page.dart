import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/weather_locations.dart';
import '../provider/wheater.provider.dart';
import '../screens/wheater.screen.dart';
import '../widgets/additional_information.dart';
import '../widgets/current_weather.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WheaterProvider client = WheaterProvider();
  Weather? data;

  var date1;

  Future<void> getData() async {
    data = await client.ObtenerWheater("Bogota");

    var coloricon;
    String bgImg = ('');

    // final timestamp1 = data!.dt; // timestamp in seconds
    // final DateTime date1 =
    //     DateTime.fromMillisecondsSinceEpoch(timestamp1! * 1000);

    // if (data!.main == 'Sunny') {
    //   bgImg = 'assets/dia_soleado.jpg';
    //   coloricon = Colors.black;
    // } else if (data!.main == 'Night') {
    //   bgImg = 'assets/noche_despejada.jpg';
    //   coloricon = Colors.white;
    // } else if (data!.main == 'Rainy') {
    //   bgImg = 'assets/dia_lluvia.jpg';
    //   coloricon = Colors.black;
    // } else if (data!.main == 'Cloudy') {
    //   bgImg = 'assets/dia_nubes.jpg';
    //   coloricon = Colors.black;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text(
            "Weather App",
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 140.0,
                  ),
                  //widget
                  Text("${data!.temp}°"),
                  Text("${data!.dt}"),
                  Text("$date1"),
                  // currentWeather(Icons.wb_sunny_rounded, "${data!.temp}°",
                  //     "${data!.cityName}"),
                  SizedBox(
                    height: 140.0,
                  ),
                  Text(
                    "Additional Information",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 20.0,
                  ),
                  //adi
                  additionalInformation("${data!.wind}", "${data!.humidity}",
                      "${data!.pressure}", "${data!.feels_like}"),
                  //uidone
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ));
  }
}
