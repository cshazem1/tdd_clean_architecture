import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tdd/core/error/failure.dart';

import 'package:tdd/domain/entities/weather_entity.dart';

import '../../domain/repositories/weather_repo.dart';
@LazySingleton(as: WeatherRepo)

class WeatherRepoImpl extends WeatherRepo{
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) {
    return Future.value(const Right(WeatherEntity(name: 'New', country: "Clods", icon: 'wow', condition: "Sunny")));
  }
}