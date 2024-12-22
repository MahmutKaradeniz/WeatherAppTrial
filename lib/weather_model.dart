class WeatherModel {
  final String temp;
  final String weatherText;
  final String weatherIcon;
  WeatherModel({
    required this.temp,
    required this.weatherText,
    required this.weatherIcon,
  });
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['current']['temp_c'].toString(),
      weatherText: json['current']['condition']['text'],
      weatherIcon: "https:${json['current']['condition']['icon']}",
    );
  }
}
