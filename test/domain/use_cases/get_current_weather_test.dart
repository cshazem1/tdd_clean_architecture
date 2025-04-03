import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/data/repositories/weather_repo_impl.dart';
import 'package:tdd/domain/entities/weather_entity.dart';
import 'package:tdd/domain/repositories/weather_repo.dart';
import 'package:tdd/domain/use_cases/get_current_weather_use_case.dart';

import '../../helpers/test_helper.mocks.dart';

Future<void> main() async {
  GetCurrentWeatherUseCase? getCurrentWeatherUseCase;
 MockWeatherRepo? mocWeatherRepo;
setUp((){
  mocWeatherRepo = MockWeatherRepo();
  getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mocWeatherRepo!);

});
  const testWeatherDetail=WeatherEntity(name: 'New York', country: "Clods", icon: 'wow', condition: "Sunny");

  const testCityName = 'New';
  test('get current weather', () async {
    // arrange
    when(
        mocWeatherRepo!.getCurrentWeather(testCityName)
    ).thenAnswer(
            (_)async => const Right(testWeatherDetail)

    );
    //act
    final result = await getCurrentWeatherUseCase!(testCityName);
    // assert
    expect(result, const Right(testWeatherDetail));
  });




    // arrange
//act
// assert
}




  // arrange
//act
// assert
