import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../models/weather_forecast.dart';

class WeatherService {
  final String url =
      'https://data.bmkg.go.id/DataMKG/MEWS/DigitalForecast/DigitalForecast-DKIJakarta.xml';

  Future<List<WeatherForecast>> fetchWeather() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final timeElements = document.findAllElements('time');
      return timeElements
          .map((element) => WeatherForecast.fromXml(element))
          .toList();
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
