import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/domain/entities/weather_entity.dart';
import 'package:tdd/domain/repositories/weather_repo.dart';
@lazySingleton
class GetCurrentWeatherUseCase {
  final WeatherRepo weatherRepo;
  GetCurrentWeatherUseCase(this.weatherRepo);
  Future<Either<Failure, WeatherEntity>> call(String city) {
    return weatherRepo.getCurrentWeather(city);
  }
}
