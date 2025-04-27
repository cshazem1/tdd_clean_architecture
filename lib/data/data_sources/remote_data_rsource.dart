import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as Http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:injectable/injectable.dart';

import '../../core/constants/constants.dart';
import '../../core/error/server_exception.dart';
import '../models/WeatherModel.dart';

abstract class WeatherRemoteDataResource {
  Future<WeatherModel> getCurrentWeather(String city);
}

@LazySingleton(as: WeatherRemoteDataResource)
class WeatherRemoteDataResourceImpl implements WeatherRemoteDataResource {
  WeatherRemoteDataResourceImpl(this.client){

  }
  final Http.Client client;

  @override
  Future<WeatherModel> getCurrentWeather(String city) async {
    final response = await client.get(
      Uri.parse(Urls.currentWeatherByName(city)),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return WeatherModel.fromJson(jsonDecode(response.body));
  }
}


@module
abstract class RegisterModule {
  @lazySingleton
  Http.Client get httpClient => InterceptedClient.build(
    interceptors: [PrettyLoggerInterceptor()],
  );
}


class PrettyLoggerInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    _printRequest(data);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    _printResponse(data);
    return data;
  }

  void _printRequest(RequestData data) {
    print('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
➡️  REQUEST
URL: ${data.url}
METHOD: ${data.method}
HEADERS: ${data.headers}
BODY: ${_prettyJson(data.body)}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');
  }

  void _printResponse(ResponseData data) {
    print('''
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⬅️  RESPONSE
STATUS CODE: ${data.statusCode}
BODY: ${_prettyJson(data.body)}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');
  }

  String _prettyJson(dynamic input) {
    if (input == null || input.toString().isEmpty) {
      return 'NO BODY';
    }
    try {
      var jsonObject = json.decode(input.toString());
      var encoder = const JsonEncoder.withIndent('  ');
      return encoder.convert(jsonObject);
    } catch (e) {
      return input.toString();
    }
  }
}
