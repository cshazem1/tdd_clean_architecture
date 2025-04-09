import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:tdd/core/error/failure.dart';
import 'package:tdd/data/data_sources/remote_data_rsource.dart';

import 'package:tdd/domain/entities/weather_entity.dart';

import '../../core/error/server_exception.dart';
import '../../domain/repositories/weather_repo.dart';

@LazySingleton(as: WeatherRepo)
class WeatherRepoImpl extends WeatherRepo {
  final WeatherRemoteDataResource weatherRemoteDataResource;
  WeatherRepoImpl(this.weatherRemoteDataResource);
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) async {
    try {
      final response =await weatherRemoteDataResource.getCurrentWeather(city);
return Right(response);

    }
    on ServerException {
      return const Left(ServerFailure("City not found"));
    }
    on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    }

  }
  // @override
  // Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) {
  //   return Future.value(
  //     const Right(
  //       WeatherEntity(
  //         name: 'New',
  //         country: "Clods",
  //         icon: 'wow',
  //         condition: "Sunny",
  //       ),
  //     ),
  //   );
  // }
}
