class Weather {
  String Placename;
  double Temperature;
  String condition;
  Weather(
      {required this.Placename,
      required this.Temperature,
      required this.condition});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        Placename: json['name'],
        Temperature: json['main']['temp'].toDouble(),
        condition: json['weather'][0]['main']);
  }
}
