
import 'package:dio/dio.dart';
import 'package:flower_app/core/api/client/api_client.dart';
import 'package:flower_app/core/api/env/env.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

@module
abstract class ApiModule {
  @lazySingleton
  ApiClient provideApiClient(Dio dio) {
    return ApiClient(dio, baseUrl: Env.baseUrl);
  }

  @lazySingleton
  Dio provideDio(BaseOptions option, TalkerDioLogger logger) {
    var dio = Dio(option);
    dio.interceptors.add(logger);
   
    return dio;
  }

  @lazySingleton
  BaseOptions providerOption() {
    return BaseOptions(
      baseUrl: Env.baseUrl,
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
  }

  @lazySingleton
  TalkerDioLogger prvoideLogger() {
    return TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
          printErrorMessage: true,
          printRequestData: true,
          printResponseData: true,
        ),
    );
  }
}
