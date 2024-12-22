import 'package:flutter/material.dart';
import 'package:weather_app/weather_service.dart';
import 'weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weatherModel;
  String city = 'Istanbul';
  Future<void> _getWeather(String city) async {
    try {
      final weather = await _weatherService.getWeather(city);
      setState(() {
        _weatherModel = weather;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load weather data'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String backgroundImage;
    String weatherText = _weatherModel?.weatherText ?? '';
    if (weatherText.contains('rain')) {
      backgroundImage = 'assets/images/rainy.png'; // Yağmurlu
    } else if (weatherText.contains('cloud') ||
        weatherText.contains('Overcast')) {
      backgroundImage = 'assets/images/cloudy.png'; // Bulutlu
    } else if (weatherText.contains('Clear') ||
        weatherText.contains('Sunny') ||
        weatherText.contains('Partly Cloudy')) {
      backgroundImage = 'assets/images/sunny.png'; // Güneşli
    } else if (weatherText.contains('Snowy')) {
      backgroundImage = 'assets/images/snowy.png'; // Güneşli
    } else {
      backgroundImage = 'assets/images/default.png'; // Varsayılan
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Şehir adı girin',
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  _getWeather(value);
                },
              ),
              const SizedBox(height: 20),
              _weatherModel != null
                  ? Column(
                      children: [
                        Text(
                          '${_weatherModel!.temp}°C',
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Colors.black,
                                offset: Offset(5.0, 5.0),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _weatherModel!.weatherText,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        Image.network(
                          _weatherModel!.weatherIcon,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        )
                      ],
                    )
                  : const Text('Hava durumu bilgisi bulunamadı.'),
            ],
          ),
        ),
      ),
    );
  }
}
