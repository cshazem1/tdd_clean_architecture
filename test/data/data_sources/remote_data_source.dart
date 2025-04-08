import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tdd/core/constants/constants.dart';
import 'package:tdd/core/error/server_exception.dart';
import 'package:tdd/data/data_sources/remote_data_rsource.dart';
import 'package:tdd/data/models/weather_model.dart';

import '../../helpers/dummy_data/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MocHttpClient mocHttpClient;
  late WeatherRemoteDataResourceImpl weatherRemoteDataSourceImplement;
  setUp(() {
    mocHttpClient = MocHttpClient();
    weatherRemoteDataSourceImplement = WeatherRemoteDataResourceImpl(
      mocHttpClient,
    );
  });
  group("get current weather", () {
    test("should return weather model when the response code is 200", () async {
      // arrange
      when(
        mocHttpClient.get(Uri.parse(Urls.currentWeatherByName('New York'))),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('helpers/dummy_data/dummy_weather_response.json'),
          200,
        ),
      );
      // act
      final result = await weatherRemoteDataSourceImplement.getCurrentWeather(
        'New York',
      );
      // assert
      expect(result, isA<WeatherModel>());
    });

    test("should return weather model when the response code is 404 or other", () async {
      // arrange
      when(
        mocHttpClient.get(Uri.parse(Urls.currentWeatherByName('New York'))),
      ).thenAnswer(
            (_) async => http.Response(
         "Not found",
          404,
        ),
      );
      // act
      final result = await weatherRemoteDataSourceImplement.getCurrentWeather(
        'New York',
      );
      // assert
      expect(result, null);
    });

  });
}
