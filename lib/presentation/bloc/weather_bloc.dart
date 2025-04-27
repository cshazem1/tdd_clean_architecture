import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:rxdart/rxdart.dart';
import 'package:tdd/presentation/bloc/weather_event.dart';
import 'package:tdd/presentation/bloc/weather_state.dart';

import '../../domain/use_cases/get_current_weather_use_case.dart';
@lazySingleton
class WeatherBloc extends Bloc<WeatherEvent,WeatherState> {

  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
          (event, emit) async {
        print("Event: OnCityChanged: ${event.cityName}");  // طباعة الحدث المستلم

        emit(WeatherLoading());
        final result = await _getCurrentWeatherUseCase(event.cityName);
        result.fold(
              (failure) {
            print("Failure: ${failure.message}");  // طباعة الخطأ
            emit(WeatherLoadFailue(failure.message));
          },
              (data) {
            print("Data: ${data}");  // طباعة البيانات
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}