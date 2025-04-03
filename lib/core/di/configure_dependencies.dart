
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:tdd/core/di/configure_dependencies.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  getIt.init();

}