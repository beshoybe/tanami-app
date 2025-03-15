import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tanami_capital/core/api/dio_api_helper.dart';
import 'package:tanami_capital/core/errors/base.dart';

import '../../mock_specs.mocks.dart';

// Generate mock classes
void main() {
  late MockDio mockDio;
  late DioApiHelper apiHelper;

  setUp(() {
    mockDio = MockDio();
    apiHelper = DioApiHelper(mockDio);
  });

  group('DioApiHelper Tests', () {
    const testUrl = 'https://example.com/api';

    test('GET request should return valid response', () async {
      final mockResponse = Response(
        data: {'message': 'Success'},
        statusCode: 200,
        requestOptions: RequestOptions(path: testUrl),
      );

      when(
        mockDio.get(testUrl, options: anyNamed('options')),
      ).thenAnswer((_) async => mockResponse);

      final response = await apiHelper.get(testUrl);

      expect(response.statusCode, 200);
      expect(response.data['message'], 'Success');
    });

    test('POST request should return valid response', () async {
      final mockResponse = Response(
        data: {'message': 'Created'},
        statusCode: 201,
        requestOptions: RequestOptions(path: testUrl),
      );

      when(
        mockDio.post(
          testUrl,
          data: anyNamed('data'),
          options: anyNamed('options'),
        ),
      ).thenAnswer((_) async => mockResponse);

      final response = await apiHelper.post(testUrl, body: {'key': 'value'});

      expect(response.statusCode, 201);
      expect(response.data['message'], 'Created');
    });

    test('PUT request should return valid response', () async {
      final mockResponse = Response(
        data: {'message': 'Updated'},
        statusCode: 200,
        requestOptions: RequestOptions(path: testUrl),
      );

      when(
        mockDio.put(
          testUrl,
          data: anyNamed('data'),
          options: anyNamed('options'),
        ),
      ).thenAnswer((_) async => mockResponse);

      final response = await apiHelper.put(testUrl, body: {'key': 'value'});

      expect(response.statusCode, 200);
      expect(response.data['message'], 'Updated');
    });

    test('DELETE request should return valid response', () async {
      final mockResponse = Response(
        data: {'message': 'Deleted'},
        statusCode: 200,
        requestOptions: RequestOptions(path: testUrl),
      );

      when(
        mockDio.delete(testUrl, options: anyNamed('options')),
      ).thenAnswer((_) async => mockResponse);

      final response = await apiHelper.delete(testUrl);

      expect(response.statusCode, 200);
      expect(response.data['message'], 'Deleted');
    });

    test(
      'Should throw ServerFailure and use response.statusMessage if response data is not a Map',
      () async {
        final errorResponse = Response(
          data: "Something went wrong", // Not a Map
          statusCode: 500,
          statusMessage: "Internal Server Error",
          requestOptions: RequestOptions(path: testUrl),
        );

        when(
          mockDio.get(testUrl, options: anyNamed('options')),
        ).thenAnswer((_) async => errorResponse);

        expect(
          () async => await apiHelper.get(testUrl),
          throwsA(
            isA<ServerFailure>().having(
              (e) => e.message,
              'message',
              contains("Internal Server Error"), // Should use statusMessage
            ),
          ),
        );
      },
    );
    test(
      'Should throw ServerFailure with message from response.data["message"] if response data is a Map',
      () async {
        final errorResponse = Response(
          data: {"message": "Custom error message"}, // Response as a Map
          statusCode: 400,
          requestOptions: RequestOptions(path: testUrl),
        );

        when(
          mockDio.get(testUrl, options: anyNamed('options')),
        ).thenAnswer((_) async => errorResponse);

        expect(
          () async => await apiHelper.get(testUrl),
          throwsA(
            isA<ServerFailure>().having(
              (e) => e.message,
              'message',
              contains(
                "Custom error message",
              ), // Should use response.data['message']
            ),
          ),
        );
      },
    );

    test('Should handle DioExceptionType.connectionTimeout', () async {
      when(mockDio.get(testUrl, options: anyNamed('options'))).thenThrow(
        DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(path: testUrl),
        ),
      );

      expect(
        () async => await apiHelper.get(testUrl),
        throwsA(isA<ServerFailure>()),
      );
    });
    test('Should handle DioExceptionType.badCertificate', () async {
      when(mockDio.get(testUrl, options: anyNamed('options'))).thenThrow(
        DioException(
          type: DioExceptionType.badCertificate,
          requestOptions: RequestOptions(path: testUrl),
        ),
      );

      expect(
        () async => await apiHelper.get(testUrl),
        throwsA(isA<ServerFailure>()),
      );
    });
    test(
      'Should handle DioExceptionType.badResponse with status code and message',
      () async {
        final errorResponse = Response(
          statusCode: 500,
          statusMessage: "Internal Server Error",
          requestOptions: RequestOptions(path: testUrl),
        );

        when(mockDio.get(testUrl, options: anyNamed('options'))).thenThrow(
          DioException(
            type: DioExceptionType.badResponse,
            response: errorResponse,
            requestOptions: RequestOptions(path: testUrl),
          ),
        );

        expect(
          () async => await apiHelper.get(testUrl),
          throwsA(
            isA<ServerFailure>().having(
              (e) => e.message,
              'message',
              contains("Server error: 500 - Internal Server Error"),
            ),
          ),
        );
      },
    );
    test(
      'Should throw GeneralFailure when an unknown exception occurs',
      () async {
        when(mockDio.get(testUrl, options: anyNamed('options'))).thenThrow(
          Exception("Unexpected error"), // Simulating an unexpected error
        );

        expect(
          () async => await apiHelper.get(testUrl),
          throwsA(
            isA<GeneralFailure>().having(
              (e) => e.message,
              'message',
              contains(
                "Unexpected error",
              ), // Ensures the message comes from `e.toString()`
            ),
          ),
        );
      },
    );
  });
}
