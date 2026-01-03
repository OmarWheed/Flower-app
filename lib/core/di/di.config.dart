// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker_dio_logger/talker_dio_logger.dart' as _i52;

import '../../features/auth/data/data_source/auth_data_source.dart' as _i364;
import '../../features/auth/data/data_source/auth_data_source_impl.dart'
    as _i985;
import '../../features/auth/data/repositories/auth_repo_impl.dart' as _i662;
import '../../features/auth/domain/repositories/auth_repo.dart' as _i723;
import '../../features/auth/domain/use_cases/forget_password/reset_password_use_case.dart'
    as _i437;
import '../../features/auth/domain/use_cases/forget_password/send_reset_password_code_use_case.dart'
    as _i876;
import '../../features/auth/domain/use_cases/forget_password/verify_reset_password_code_use_case.dart'
    as _i1073;
import '../../features/auth/domain/use_cases/login/login_use_case.dart'
    as _i857;
import '../../features/auth/domain/use_cases/signup/signup_use_case.dart'
    as _i748;
import '../../features/auth/presentation/views/forget_password/view_model/forget_password_view_model.dart'
    as _i458;
import '../../features/auth/presentation/views/login/view_model/login_view_model.dart'
    as _i495;
import '../../features/auth/presentation/views/signup/view_model/signup_view_model.dart'
    as _i1025;
import '../api/client/api_client.dart' as _i364;
import '../api/di/api_module.dart' as _i713;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final apiModule = _$ApiModule();
    gh.lazySingleton<_i361.BaseOptions>(() => apiModule.providerOption());
    gh.lazySingleton<_i52.TalkerDioLogger>(() => apiModule.prvoideLogger());
    gh.lazySingleton<_i361.Dio>(
      () => apiModule.provideDio(
        gh<_i361.BaseOptions>(),
        gh<_i52.TalkerDioLogger>(),
      ),
    );
    gh.lazySingleton<_i364.ApiClient>(
      () => apiModule.provideApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i364.AuthDataSource>(
      () => _i985.AuthDataSourceImpl(gh<_i364.ApiClient>()),
    );
    gh.lazySingleton<_i723.AuthRepo>(
      () => _i662.AuthRepoImpl(gh<_i364.AuthDataSource>()),
    );
    gh.factory<_i748.SignUpUseCase>(
      () => _i748.SignUpUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i1025.SignupViewModel>(
      () => _i1025.SignupViewModel(gh<_i748.SignUpUseCase>()),
    );
    gh.factory<_i1073.VerifyResetPasswordCodeUseCase>(
      () => _i1073.VerifyResetPasswordCodeUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i876.SendResetPasswordCodeUseCase>(
      () => _i876.SendResetPasswordCodeUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i437.ResetPasswordUseCase>(
      () => _i437.ResetPasswordUseCase(gh<_i723.AuthRepo>()),
    );
    gh.lazySingleton<_i857.LoginUseCase>(
      () => _i857.LoginUseCase(gh<_i723.AuthRepo>()),
    );
    gh.factory<_i495.LoginViewModel>(
      () => _i495.LoginViewModel(gh<_i857.LoginUseCase>()),
    );
    gh.factory<_i458.ForgetPasswordViewModel>(
      () => _i458.ForgetPasswordViewModel(
        gh<_i876.SendResetPasswordCodeUseCase>(),
        gh<_i1073.VerifyResetPasswordCodeUseCase>(),
        gh<_i437.ResetPasswordUseCase>(),
      ),
    );
    return this;
  }
}

class _$ApiModule extends _i713.ApiModule {}
