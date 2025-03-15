import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mockito/annotations.dart';
import 'package:tanami_capital/core/api/api_helper.dart';
import 'package:tanami_capital/core/api/language_interceptor.dart';
import 'package:tanami_capital/core/api/token_interceptor.dart';
import 'package:tanami_capital/core/cache/cache_helper.dart';
import 'package:tanami_capital/core/cache/secure_cache_helper.dart';
import 'package:tanami_capital/features/auth/data/datasource/auth_datasource.dart';
import 'package:tanami_capital/features/auth/domain/repositories/auth_repository.dart';
import 'package:tanami_capital/features/auth/domain/usecases/forget_password_usecase.dart';
import 'package:tanami_capital/features/auth/domain/usecases/login_usecase.dart';
import 'package:tanami_capital/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:tanami_capital/features/auth/domain/usecases/signup_usecase.dart';

@GenerateMocks([
  ApiHelper,
  CacheHelper,
  SecureCacheHelper,
  AuthRepository,
  AuthDatasource,
  FlutterSecureStorage,
  Dio,
  LanguageInterceptor,
  TokenInterceptor,
  Interceptors,
  LoginUsecase,
  SignupUsecase,
  ResetPasswordUsecase,
  ForgetPasswordUsecase,
], customMocks: [])
void main() {}
