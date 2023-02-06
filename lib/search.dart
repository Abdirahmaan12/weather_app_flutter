import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  Weather? weather;
  final openWeather = WeatherFactory('4667e71be9ef6cafaa15b2d3d352e853');
  String cityName = '';

  set isLoading(bool isLoading) {}

  getWeather() async {
    try {
      isLoading = true;
      setState(() {});
      weather = await openWeather.currentWeatherByCityName(cityName);
      isLoading = false;
      setState(() {});
    } catch (e) {
      print('THE ERROR $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          elevation: 0,
          title: Text(
            'search by city name',
          )),
      body: Column(children: [
        Container(
          margin: EdgeInsets.all(22.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                cityName = value;
              });
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    getWeather();
                  },
                  icon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 5, 5, 5),
                  ),
                ),
                hintText: 'Enter city Name'),
          ),
        ),
        Expanded(
          child: weather != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${weather!.temperature!.celsius!.round()} °C',
                      style: TextStyle(fontSize: 55.0),
                    ),
                    Text('${weather!.weatherDescription}'),
                  ],
                )
              : const SizedBox(),
        ),
      ]),
    );
  }
}
