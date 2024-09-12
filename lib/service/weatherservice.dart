import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/pages/weather.dart';
import 'package:http/http.dart' as http;

class Weatherservice {
  final BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String Api_key;
  Weatherservice({required this.Api_key});

  Future<Weather> getweather(String Cityname) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$Cityname&appid=$Api_key'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw (Text('Error occured'));
    }
  }

  Future<String> Getcity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemark[0].locality;
    return city ?? ""; // returning empty string if null
  }
}
