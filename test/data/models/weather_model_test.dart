import 'dart:convert';


import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/data/models/condition.dart';
import 'package:tdd/data/models/current.dart';
import 'package:tdd/data/models/location.dart';
import 'package:tdd/data/models/weather_model.dart';
import 'package:tdd/domain/entities/weather_entity.dart';

import '../../helpers/dummy_data/json_reader.dart';

void main(){

  final testWeatherDetail={
    "location": {
      "name": "Saint-Merri",
      "region": "Ile-de-France",
      "country": "France",
      "lat": 48.85,
      "lon": 2.35,
      "tz_id": "Europe/Paris",
      "localtime_epoch": 1743678003,
      "localtime": "2025-04-03 13:00"
    },
    "current": {
      "last_updated_epoch": 1743677100,
      "last_updated": "2025-04-03 12:45",
      "temp_c": 19.1,
      "temp_f": 66.4,
      "is_day": 1,
      "condition": {
        "text": "Sunny",
        "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png",
        "code": 1000
      },
      "wind_mph": 12.3,
      "wind_kph": 19.8,
      "wind_degree": 135,
      "wind_dir": "SE",
      "pressure_mb": 1017,
      "pressure_in": 30.03,
      "precip_mm": 0,
      "precip_in": 0,
      "humidity": 40,
      "cloud": 0,
      "feelslike_c": 19.1,
      "feelslike_f": 66.4,
      "windchill_c": 18.5,
      "windchill_f": 65.2,
      "heatindex_c": 18.5,
      "heatindex_f": 65.2,
      "dewpoint_c": 5.8,
      "dewpoint_f": 42.4,
      "vis_km": 10,
      "vis_miles": 6,
      "uv": 3,
      "gust_mph": 14.2,
      "gust_kph": 22.8
    }
  };


  Location? location;
  location= Location(
    name: "Saint-Merri",
    country: "France",
    region: "Ile-de-France",
    lat: 48.85,
    lon: 2.35,
    tzId: "Europe/Paris",
    localtimeEpoch: 1743678003,
    localtime: "2025-04-03 13:00",
  );
  Condition? condition;
  condition=Condition(
    text: "Sunny",
    icon: "//cdn.weatherapi.com/weather/64x64/day/113.png",
    code: 1000,
  );
  Current  current =Current(
    lastUpdatedEpoch: 1743677100,
    lastUpdated: "2025-04-03 12:45",
    tempC: 19.1,
    tempF: 66.4,
    isDay: 1,
    condition:condition,
    windMph: 12.3,
    windKph: 19.8,
    windDegree: 135,
    windDir: "SE",
    pressureMb: 1017,
    pressureIn: 30.03,
    precipMm: 0,
    precipIn: 0,
    humidity: 40,
    cloud: 0,
    feelslikeC: 19.1,
    feelslikeF: 66.4,
    windchillC: 18.5,
    windchillF: 65.2,
    heatindexC: 18.5,
    heatindexF: 65.2,
    dewpointC: 5.8,
    dewpointF: 42.4,
    visKm: 10,
    visMiles: 6,
    uv: 3,
    gustMph: 14.2,
    gustKph: 22.8,
  );

  final weather = WeatherModel(
    location: location,
    current: current,
  );


  test('should return a valid model from json', () async {
//arrange
    final Map<String, dynamic> jsonMap = json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

//act
    var result=WeatherModel.fromJson(jsonMap);
    //assert
    expect(result,weather);
  });

  test('should be a subclass of WeatherEntity', () async {
    dynamic  testWeatherDetail=WeatherModel();

   //arrange
   
   //act
   
    //assert
   expect(testWeatherDetail,isA<WeatherEntity>());
  });



 test('should return a json map containing proper data', () {
   //arrange

   //act
   final Map<String, dynamic> jsonMap = json.decode(readJson('helpers/dummy_data/dummy_weather_response.json'));

   final result=WeatherModel.fromJson(testWeatherDetail);
   final testWeatherJson=weather.toJson();
   //assert
   expect(jsonMap,equals(testWeatherJson));
 },);

  
}