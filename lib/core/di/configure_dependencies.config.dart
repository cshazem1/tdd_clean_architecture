// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:tdd/data/data_sources/remote_data_rsource.dart' as _i724;
import 'package:tdd/data/repositories/weather_repo_impl.dart' as _i778;
import 'package:tdd/domain/repositories/weather_repo.dart' as _i675;
import 'package:tdd/domain/use_cases/get_current_weather_use_case.dart'
    as _i237;
import 'package:tdd/presentation/bloc/weather_bloc.dart' as _i955;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i519.Client>(() => registerModule.httpClient);
    gh.lazySingleton<_i724.WeatherRemoteDataResource>(
      () => _i724.WeatherRemoteDataResourceImpl(gh<_i519.Client>()),
    );
    gh.lazySingleton<_i675.WeatherRepo>(
      () => _i778.WeatherRepoImpl(gh<_i724.WeatherRemoteDataResource>()),
    );
    gh.lazySingleton<_i237.GetCurrentWeatherUseCase>(
      () => _i237.GetCurrentWeatherUseCase(gh<_i675.WeatherRepo>()),
    );
    gh.lazySingleton<_i955.WeatherBloc>(
      () => _i955.WeatherBloc(gh<_i237.GetCurrentWeatherUseCase>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i724.RegisterModule {}
