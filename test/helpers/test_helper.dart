import 'package:mockito/annotations.dart';
import 'package:tdd/data/data_sources/remote_data_rsource.dart';
import 'package:tdd/domain/repositories/weather_repo.dart';
import 'package:http/http.dart' as http;
import 'package:tdd/domain/use_cases/get_current_weather_use_case.dart';

@GenerateMocks([
  WeatherRepo,
  WeatherRemoteDataResource,
  GetCurrentWeatherUseCase


],customMocks: [
  MockSpec<http.Client>(as: #MocHttpClient)
])
void main() {}