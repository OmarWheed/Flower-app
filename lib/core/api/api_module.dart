import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/env.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

@module
abstract class ApiModule {
  @lazySingleton
  ApiClient provideApiClient(Dio dio) {
    return ApiClient(dio, baseUrl: Env.baseUrl);
  }

  @preResolve
  @lazySingleton
  Future<Dio> provideDio(BaseOptions option, TalkerDioLogger logger) async {
    var dio = Dio(option);
    dio.interceptors.add(logger);

    final userToken = await AppLocalStorage.getSecuredString(
      key: LocalKeys.authToken,
    );

    if (userToken.isNotEmpty) {
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
      };
    }

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
  TalkerDioLogger provideLogger() {
    return TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printErrorHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
        printErrorMessage: true,
        printRequestData: true,
        printResponseData: true,
      ),
    );
  }
}
