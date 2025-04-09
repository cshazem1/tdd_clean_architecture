import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/core/error/server_exception.dart';
import 'package:tdd/data/models/condition.dart';
import 'package:tdd/data/models/current.dart';
import 'package:tdd/data/models/location.dart';
import 'package:tdd/data/models/weather_model.dart';
import 'package:tdd/data/repositories/weather_repo_impl.dart';
import 'package:tdd/domain/repositories/weather_repo.dart';

import '../../helpers/test_helper.mocks.dart';

main(){
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
  late WeatherRepo weatherRepo;
late MockWeatherRemoteDataResource mockWeatherRemoteDataSource;

setUp(() {
  mockWeatherRemoteDataSource = MockWeatherRemoteDataResource();
  weatherRepo = WeatherRepoImpl(mockWeatherRemoteDataSource);
},);

const testCityName = 'New York';
group('get current weather', () {

  test('should return current weather when called is successful', () async {
    // arrange
    when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
        .thenAnswer((_) async =>  weather);
    // act
    final result = await weatherRepo.getCurrentWeather(testCityName);
    // assert
    expect(result, equals(Right(weather)));
  });

  test('should return current weather when called is successful', () async {
    // arrange
    when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
        .thenThrow(ServerException());
    // act
    final result = await weatherRepo.getCurrentWeather(testCityName);
    // assert
    expect(result, equals(const Left(ServerFailure('City not found'))));
  });


  test('no internet connection', () async {
    // arrange
    when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
        .thenThrow(const SocketException('No internet connection'));
    // act
    final result = await weatherRepo.getCurrentWeather(testCityName);
    // assert
    expect(result, equals(const Left(ConnectionFailure('No internet connection'))));
  });

});

}