import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/pages/weather.dart';
import 'package:weatherapp/service/weatherservice.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  Weather? _weather;
  final _weatherservice =
      Weatherservice(Api_key: "08b39eae4b006009d7273c050be603b5");

  String getweatherani(String? maincondition) {
    if (maincondition == null) {
      return 'assets/sunny.json';
    }
    switch (maincondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'fog':
      case 'haze':
        return "assets/cloudy.json";

      case 'rain':
      case 'drizzle':
      case 'shower':
      case 'thunderstorm':
        return "assets/rainy.json";
      default:
        return "assets/sunny.json";
    }
  }

  void fetchweather() async {
    final String cityname = await _weatherservice.Getcity();

    final weatherinfo = await _weatherservice.getweather(cityname);
    setState(() {
      _weather = weatherinfo;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    fetchweather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  _weather?.Placename ?? "Loading city",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 231, 230, 230)),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Lottie.asset(getweatherani(_weather?.condition)),
              const SizedBox(
                height: 20,
              ),
              Text(
                _weather != null
                    ? '${(_weather!.Temperature - 273.15).round()}°C'
                    : "Loading temperature",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              Text(
                _weather?.condition ?? "",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 217, 0)),
              ),
            ],
          ),
        ));
  }
}
