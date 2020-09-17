import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/forecast.dart';
import 'package:flutter_weather_app/models/location.dart';
import 'package:flutter_weather_app/models/weather.dart';
import 'package:flutter_weather_app/services/own_api.dart';
import 'package:flutter_weather_app/views/gradient_container.dart';

import 'gradient_container.dart';
import 'location_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  WeatherCondition condition;
  Location location = new Location(latitude: 0, longitude: 0);
  String city = "Ciudad";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildGradientContainer(
          true,
          condition,
          ListView(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(0, 3))
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: "Ingrese Ciudad"),
                        onSubmitted: (value) async {
                          city = value;
                          OpenWeatherMapApi api = OpenWeatherMapApi();
                          location = await api.getLocation(value);
                          Forecast f = await api.getForecast(location);
                          print(f.current.condition.toString());
                          setState(() {
                            city = city;
                            location = location;
                            condition = f.current.condition;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              LocationView(city: city, location: location),
            ],
          )),
    );
  }

  GradientContainer _buildGradientContainer(
      bool isDayTime, WeatherCondition condition, Widget child) {
    GradientContainer container;
    if (!isDayTime) {
      container = GradientContainer(color: Colors.blueGrey, child: child);
    } else {
      switch (condition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          container = GradientContainer(color: Colors.yellow, child: child);
          break;
        case WeatherCondition.fog:
        case WeatherCondition.atmosphere:
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container = GradientContainer(color: Colors.indigo, child: child);
          break;
        case WeatherCondition.snow:
          container = GradientContainer(color: Colors.lightBlue, child: child);
          break;
        case WeatherCondition.thunderstorm:
          container = GradientContainer(color: Colors.deepPurple, child: child);
          break;
        default:
          container = GradientContainer(color: Colors.lightBlue, child: child);
      }
    }
    return container;
  }
}
