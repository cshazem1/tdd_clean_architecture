import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as Http;
import 'package:tdd/data/models/weather_model.dart';

import '../../core/constants/constants.dart';
import '../../core/error/server_exception.dart';

abstract class WeatherRemoteDataResource{
 Future<WeatherModel?> getCurrentWeather(String city);
}
class WeatherRemoteDataResourceImpl implements WeatherRemoteDataResource{
  WeatherRemoteDataResourceImpl(this.client);
  final Http.Client client;

  @override
  Future<WeatherModel?> getCurrentWeather(String city) async {
    final response = await client.get(Uri.parse(Urls.currentWeatherByName(city)));
    if (response.statusCode != 200) {
      return null;
    }
    return WeatherModel.fromJson(jsonDecode(response.body));
  }
}