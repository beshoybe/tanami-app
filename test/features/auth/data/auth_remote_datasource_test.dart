import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/config/constants.dart';
import 'package:tanami_capital/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:tanami_capital/features/auth/data/models/auth_response_model.dart';
import 'package:dio/dio.dart';

import '../../../mock_specs.mocks.dart';

void main() {
  late MockApiHelper mockApiHelper;
  late MockCacheHelper mockCacheHelper;
  late AuthRemoteDatasource datasource;

  setUp(() {
    mockApiHelper = MockApiHelper();
    mockCacheHelper = MockCacheHelper();
    datasource = AuthRemoteDatasource(mockApiHelper, mockCacheHelper);
  });

  const email = 'test@example.com';
  const password = 'password123';
  const name = 'John Doe';
  const token = 'mock_token';
  const refreshToken = 'mock_refresh_token';
  const passwordLessToken = 'mock_passwordless_token';

  final mockResponse = {
    'data': {
      'token': token,
      'refresh_token': refreshToken,
      'password_less_token': passwordLessToken,
    },
  };

  final expectedModel = AuthResponseModel.fromJson(mockResponse['data']!);

  void verifyCacheCalls() {
    verify(mockCacheHelper.remove(kTokenCacheKey)).called(1);
    verify(mockCacheHelper.remove(kRefreshTokenCacheKey)).called(1);
    verify(mockCacheHelper.remove(kPasswordLessTokenCacheKey)).called(1);
    verify(mockCacheHelper.writeString(kTokenCacheKey, token)).called(1);
    verify(
      mockCacheHelper.writeString(kRefreshTokenCacheKey, refreshToken),
    ).called(1);
    verify(
      mockCacheHelper.writeString(
        kPasswordLessTokenCacheKey,
        passwordLessToken,
      ),
    ).called(1);
  }

  group('AuthRemoteDatasource', () {
    test('should call API and return AuthResponseModel on login', () async {
      when(
        mockApiHelper.post('/auth/login', body: anyNamed('body')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: mockResponse,
          statusCode: 200,
        ),
      );

      final result = await datasource.login(email, password);

      expect(result, expectedModel);
      verify(
        mockApiHelper.post(
          '/auth/login',
          body: {'email': email, 'password': password},
        ),
      ).called(1);
      verifyCacheCalls();
    });

    test(
      'should call API and return AuthResponseModel on passwordLessLogin',
      () async {
        when(
          mockApiHelper.post(
            '/auth/passwordless-login',
            body: anyNamed('body'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockResponse,
            statusCode: 200,
          ),
        );

        final result = await datasource.passwordLessLogin(token);

        expect(result, expectedModel);
        verify(
          mockApiHelper.post(
            '/auth/passwordless-login',
            body: {'token': token},
          ),
        ).called(1);
        verifyCacheCalls();
      },
    );

    test('should call API and return AuthResponseModel on signup', () async {
      when(
        mockApiHelper.post('/auth/register', body: anyNamed('body')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: mockResponse,
          statusCode: 200,
        ),
      );

      final result = await datasource.signup(email, password, name);

      expect(result, expectedModel);
      verify(
        mockApiHelper.post(
          '/auth/register',
          body: {'email': email, 'password': password, 'name': name},
        ),
      ).called(1);
      verifyCacheCalls();
    });

    test('should call API for forgetPassword', () async {
      when(
        mockApiHelper.post('/auth/forget-password', body: anyNamed('body')),
      ).thenAnswer(
        (_) async =>
            Response(requestOptions: RequestOptions(path: ''), statusCode: 200),
      );

      await datasource.forgetPassword(email);

      verify(
        mockApiHelper.post('/auth/forget-password', body: {'email': email}),
      ).called(1);
    });

    test('should return token on confirmOtp', () async {
      final otpResponse = {
        'data': {'token': token},
      };

      when(
        mockApiHelper.post('/auth/confirm-otp', body: anyNamed('body')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: otpResponse,
          statusCode: 200,
        ),
      );

      final result = await datasource.confirmOtp(email, '123456');

      expect(result, token);
      verify(
        mockApiHelper.post(
          '/auth/confirm-otp',
          body: {'email': email, 'otp': '123456'},
        ),
      ).called(1);
    });

    test(
      'should call API and return AuthResponseModel on resetPassword',
      () async {
        when(
          mockApiHelper.post('/auth/reset-password', body: anyNamed('body')),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: ''),
            data: mockResponse,
            statusCode: 200,
          ),
        );

        final result = await datasource.resetPassword(token, password);

        expect(result, expectedModel);
        verify(
          mockApiHelper.post(
            '/auth/reset-password',
            body: {'password': password, 'token': token},
          ),
        ).called(1);
        verifyCacheCalls();
      },
    );
  });
}
