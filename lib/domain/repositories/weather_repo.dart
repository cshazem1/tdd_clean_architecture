import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/domain/entities/weather.dart';

abstract class WeatherRepo {
  Future<Either<Failure, WeatherEntity>> getWeather(String city);
}