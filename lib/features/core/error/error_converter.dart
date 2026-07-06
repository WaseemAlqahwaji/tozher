import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tozher/features/core/data/model/api_error_model/api_error_model.dart';
import 'package:tozher/features/core/domain/entity/failure.dart';

class ErrorConverter {
  static Failure handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.connectionError) {
      if (kDebugMode) {
        developer.log(
          'Network error: ${error.message}',
          name: 'ErrorConverter',
          error: error,
          stackTrace: error.stackTrace,
        );
      }
      return NetworkFailure('خطأ في الاتصال. يرجى التحقق من اتصالك بالإنترنت.');
    }

    if (error.response != null) {
      try {
        final apiError = ApiErrorModel.fromJson(error.response!.data);
        // title is the error code (e.g. "AccessCode.NotFound");
        // detail is the human-readable fallback from the server.
        final message = apiError.title;
        if (kDebugMode) {
          developer.log(
            'Server error (${apiError.status}): $message — ${apiError.detail}',
            name: 'ErrorConverter',
            error: error,
            stackTrace: error.stackTrace,
          );
        }
        return ServerFailure(
          message,
          statusCode: apiError.status,
        );
      } catch (e, s) {
        // JSON parsing / modeling error — log the stack trace so you can debug
        if (kDebugMode) {
          developer.log(
            'Model parsing error: $e',
            name: 'ErrorConverter',
            error: e,
            stackTrace: s,
          );
        }
        return ServerFailure(
          error.response?.statusMessage ?? 'خطأ غير معروف في الخادم',
          statusCode: error.response?.statusCode,
        );
      }
    }

    if (kDebugMode) {
      developer.log(
        'Unexpected Dio error: ${error.message}',
        name: 'ErrorConverter',
        error: error,
        stackTrace: error.stackTrace,
      );
    }
    return ServerFailure(error.message ?? 'خطأ غير متوقع حدث');
  }

  static Future<Either<Failure, T>> safeCall<T>(
    Future<T> Function() action,
  ) async {
    try {
      final result = await action();
      return Right(result);
    } on DioException catch (dioException, s) {
      if (kDebugMode) {
        developer.log(
          'DioException in safeCall: ${dioException.message}',
          name: 'ErrorConverter',
          error: dioException,
          stackTrace: s,
        );
      }
      return Left(handleError(dioException));
    } on Failure catch (failure, s) {
      if (kDebugMode) {
        developer.log(
          'Failure in safeCall: $failure',
          name: 'ErrorConverter',
          error: failure,
          stackTrace: s,
        );
      }
      return Left(failure);
    } catch (error, s) {
      if (kDebugMode) {
        developer.log(
          'Unexpected error in safeCall: $error',
          name: 'ErrorConverter',
          error: error,
          stackTrace: s,
        );
      }
      return Left(ServerFailure(error.toString()));
    }
  }
}
