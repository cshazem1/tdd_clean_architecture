import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/core/error/server_exception.dart';
import 'package:tdd/data/models/Clouds.dart';
import 'package:tdd/data/models/Coord.dart';
import 'package:tdd/data/models/Main.dart';
import 'package:tdd/data/models/Sys.dart';
import 'package:tdd/data/models/Weather.dart';
import 'package:tdd/data/models/WeatherModel.dart';
import 'package:tdd/data/models/Wind.dart';

import 'package:tdd/data/repositories/weather_repo_impl.dart';
import 'package:tdd/domain/repositories/weather_repo.dart';

import '../../helpers/test_helper.mocks.dart';

main() {


  List<Weather> weatherList = [
    Weather(
      id: 1000,
      main: 'Clear',
      description: 'Sunny',
      icon: '113.png',
    ),
  ];

  Main main = Main(
    temp: 19.1,
    feelsLike: 19.1,
    tempMin: 18.0,
    tempMax: 21.0,
    pressure: 1017,
    humidity: 40,
    seaLevel: 1015,
    grndLevel: 1000,
  );

  Wind wind = Wind(
    speed: 12.3,
    deg: 135,
    gust: 14.2,
  );

  Clouds clouds = Clouds(
    all: 0,
  );

  Sys sys = Sys(
    type: 1,
    id: 1,
    country: 'FR',
    sunrise: 1743678003,
    sunset: 1743720803,
  );

  final weatherModel = WeatherModel(
    coord: Coord(lon: 2.35, lat: 48.85),
    weather: weatherList,
    base: 'stations',
    main: main,
    visibility: 10000,
    wind: wind,
    clouds: clouds,
    dt: 1743677100,
    sys: sys,
    timezone: 3600,
    id: 12345,
    namex: "Saint-Merri",
    cod: 200,
  );

  late WeatherRepo weatherRepo;
  late MockWeatherRemoteDataResource mockWeatherRemoteDataSource;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataResource();
    weatherRepo = WeatherRepoImpl(mockWeatherRemoteDataSource);
  });

  const testCityName = 'New York';
  group('get current weather', () {
    test('should return current weather when called is successful', () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => weatherModel);
      final result = await weatherRepo.getCurrentWeather(testCityName);
      expect(result, equals(Right(weatherModel)));
    });

    test('should return failure when server exception is thrown', () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());
      final result = await weatherRepo.getCurrentWeather(testCityName);
      expect(result, equals(const Left(ServerFailure('City not found'))));
    });

    test('should return failure when there is no internet connection', () async {
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException('No internet connection'));
      final result = await weatherRepo.getCurrentWeather(testCityName);
      expect(result, equals(const Left(ConnectionFailure('No internet connection'))));
    });
  });
}
