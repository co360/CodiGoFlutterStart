import 'package:flutter/material.dart';
import 'package:flutter_weather_app/models/location.dart';

class LocationView extends StatelessWidget {
  const LocationView({
    Key key,
    @required this.city,
    @required this.location,
  }) : super(key: key);

  final String city;
  final Location location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          city,
          style: TextStyle(
              fontSize: 40, fontWeight: FontWeight.w300, color: Colors.white),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.white,
              size: 15,
            ),
            Text(
              "Lat.${location.latitude} , Lon. ${location.longitude}",
              style: TextStyle(color: Colors.white),
            ),
          ],
        )
      ],
    );
  }
}
