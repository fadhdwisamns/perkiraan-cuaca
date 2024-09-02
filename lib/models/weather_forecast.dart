import 'package:xml/xml.dart' as xml;

class WeatherForecast {
  final String time;
  final String temperature;
  final String condition;

  WeatherForecast({
    required this.time,
    required this.temperature,
    required this.condition,
  });

  factory WeatherForecast.fromXml(xml.XmlElement element) {
    return WeatherForecast(
      time: element.findElements('datetime').first.text,
      temperature: element.findElements('value').first.text,
      condition: element.findElements('parameter').first.text,
    );
  }
}
