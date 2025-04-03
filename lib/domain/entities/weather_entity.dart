import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String name;
  final String country;
  final String icon;
  final String condition;

  const WeatherEntity({
    required this.name,
    required this.country,
    required this.icon,
    required this.condition,
  });

  @override
  List<Object?> get props => [name, country, icon, condition];
}
