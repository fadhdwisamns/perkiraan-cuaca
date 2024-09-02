import 'package:flutter/material.dart';
import 'service/weather_service.dart';
import 'models/weather_forecast.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Forecast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  late Future<List<WeatherForecast>> futureWeather;
  String selectedCity = 'Jakarta Pusat';

  @override
  void initState() {
    super.initState();
    futureWeather = WeatherService().fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: selectedCity,
            items: <String>[
              'Jakarta Pusat',
              'Jakarta Utara',
              'Jakarta Selatan',
              'Jakarta Barat',
              'Jakarta Timur'
            ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedCity = newValue!;
              });
            },
          ),
          Expanded(
            child: FutureBuilder<List<WeatherForecast>>(
              future: futureWeather,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final forecast = snapshot.data![index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                forecast.time,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('Temperature: ${forecast.temperature}°C'),
                              Text('Condition: ${forecast.condition}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
