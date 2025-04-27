import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/data/models/Clouds.dart';
import 'package:tdd/data/models/Coord.dart';
import 'package:tdd/data/models/Main.dart';
import 'package:tdd/data/models/Sys.dart';
import 'package:tdd/data/models/Weather.dart';
import 'package:tdd/data/models/WeatherModel.dart';
import 'package:tdd/data/models/Wind.dart';
import 'package:tdd/domain/entities/weather_entity.dart';

import '../../helpers/dummy_data/json_reader.dart';

void main() {
  final testWeatherDetail = {
    "coord": {
      "lat": 48.85,
      "lon": 2.35,
    },
    "weather": [
      {
        "id": 1000,
        "main": "Clear",
        "description": "Clear sky",
        "icon": "01d",
      }
    ],
    "base": "stations",
    "main": {
      "temp": 19.1,
      "feels_like": 19.1,
      "temp_min": 18.5,
      "temp_max": 20.5,
      "pressure": 1017,
      "humidity": 40,
    },
    "visibility": 10000,
    "wind": {
      "speed": 12.3,
      "deg": 135,
      "gust": 14.2,
    },
    "clouds": {
      "all": 0,
    },
    "dt": 1743677100,
    "sys": {
      "type": 1,
      "id": 1,
      "country": "FR",
      "sunrise": 1743651420,
      "sunset": 1743703650,
    },
    "timezone": 3600,
    "id": 2988507,
    "name": "Saint-Merri",
    "cod": 200
  };

  final weather = WeatherModel(
    coord: Coord(lat: 48.85, lon: 2.35),
    weather: [
      Weather(id: 1000, main: "Clear", description: "Clear sky", icon: "01d")
    ],
    base: "stations",
    main: Main(
      temp: 19.1,
      feelsLike: 19.1,
      tempMin: 18.5,
      tempMax: 20.5,
      pressure: 1017,
      humidity: 40,
    ),
    visibility: 10000,
    wind: Wind(
      speed: 12.3,
      deg: 135,
      gust: 14.2,
    ),
    clouds: Clouds(all: 0),
    dt: 1743677100,
    sys: Sys(
      type: 1,
      id: 1,
      country: "FR",
      sunrise: 1743651420,
      sunset: 1743703650,
    ),
    timezone: 3600,
    id: 2988507,
    namex: "Saint-Merri",
    cod: 200,
  );

  test('should return a valid model from json', () async {
    final Map<String, dynamic> jsonMap = json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    var result = WeatherModel.fromJson(jsonMap);

    expect(result, weather);
  });

  test('should be a subclass of WeatherEntity', () async {
    // arrange
    dynamic testWeatherDetail = WeatherModel();

    expect(testWeatherDetail, isA<WeatherEntity>());
  });

  test('should return a json map containing proper data', () {
    final Map<String, dynamic> jsonMap = json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    final result = WeatherModel.fromJson(testWeatherDetail);
    final testWeatherJson = weather.toJson();

    expect(jsonMap, equals(testWeatherJson));
  });
}
