import 'package:tdd/domain/entities/weather_entity.dart';

import 'location.dart';
import 'current.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({this.location, this.current})
    : super(
        name: location?.name??'',
        country: location?.country??'',
        icon: current?.condition?.icon??'',
        condition: current?.condition?.text??'',
      );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      location: json['location'] != null ? Location.fromJson(json['location']) : null,
      current: json['current'] != null ? Current.fromJson(json['current']) : null,
    );
  }  Location? location;
  Current? current;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (current != null) {
      map['current'] = current?.toJson();
    }
    return map;
  }
}
