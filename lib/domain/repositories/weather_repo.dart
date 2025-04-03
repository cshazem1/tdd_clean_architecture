import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/domain/entities/weather_entity.dart';

abstract class WeatherRepo {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);
}