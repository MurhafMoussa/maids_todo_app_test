import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maids_todo_app_test/core/errors/error_model.dart';
import 'package:maids_todo_app_test/core/extensions/logger_extension.dart';

part 'app_exceptions.freezed.dart';

@freezed
abstract class AppExceptions with _$AppExceptions {
  const factory AppExceptions.requestCancelled() = RequestCancelled;
  const factory AppExceptions.canceledByUser() = CanceledByUser;

  const factory AppExceptions.badRequest(String reason) = BadRequest;
  const factory AppExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;
  const factory AppExceptions.forbidden(String reason) = Forbidden;

  const factory AppExceptions.notFound(String reason) = NotFound;

  const factory AppExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory AppExceptions.requestTimeout() = RequestTimeout;

  const factory AppExceptions.sendTimeout() = SendTimeout;

  const factory AppExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory AppExceptions.conflict() = Conflict;

  const factory AppExceptions.internalServerError() = InternalServerError;

  const factory AppExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory AppExceptions.noInternetConnection() = NoInternetConnection;

  const factory AppExceptions.formatException() = FormatException;

  const factory AppExceptions.unableToProcess() = UnableToProcess;

  const factory AppExceptions.defaultError(String error) = DefaultError;
  const factory AppExceptions.invalidCredentials() = InvalidCredentials;
  const factory AppExceptions.emailAlreadyUsed() = EmailAlreadyUsed;

  const factory AppExceptions.unexpectedError() = UnexpectedError;
  factory AppExceptions.getException(error, StackTrace stack) {
    error.toString().logE;
    stack.toString().logE;
    if (error is Exception) {
      try {
        if (error is DioException) {
          return AppExceptions._handleDioExceptions(error);
        } else {
          return const AppExceptions.unexpectedError();
        }
      } on FormatException {
        return const AppExceptions.formatException();
      } on SocketException {
        return const AppExceptions.noInternetConnection();
      } catch (_) {
        return const AppExceptions.unexpectedError();
      }
    } else {
      return const AppExceptions.unexpectedError();
    }
  }

  factory AppExceptions._handleDioExceptions(
    DioException error,
  ) {
    AppExceptions exception;
    switch (error.type) {
      case DioExceptionType.cancel:
        exception = const AppExceptions.requestCancelled();
        break;
      case DioExceptionType.connectionTimeout:
        exception = const AppExceptions.requestTimeout();
        break;
      case DioExceptionType.unknown:
        exception = const AppExceptions.noInternetConnection();
        break;
      case DioExceptionType.receiveTimeout:
        exception = const AppExceptions.sendTimeout();
        break;
      case DioExceptionType.badResponse:
        exception = AppExceptions._handleResponseStatusCodes(error.response);
        break;

      case DioExceptionType.sendTimeout:
        exception = const AppExceptions.sendTimeout();
        break;
      case DioExceptionType.badCertificate:
        exception = const AppExceptions.unableToProcess();
        break;
      case DioExceptionType.connectionError:
        exception = const AppExceptions.noInternetConnection();
        break;
    }
    return exception;
  }
  factory AppExceptions._handleResponseStatusCodes(Response? response) {
    ErrorModel errorModel = ErrorModel.fromJson(response?.data);

    int statusCode = response?.statusCode ?? 0;

    switch (statusCode) {
      case 400:
        return AppExceptions.badRequest(errorModel.message);
      case 401:
        return AppExceptions.unauthorizedRequest(errorModel.message);
      case 403:
        return AppExceptions.forbidden(errorModel.message);

      case 404:
        return AppExceptions.notFound(errorModel.message);
      case 405:
        return const AppExceptions.methodNotAllowed();
      case 409:
        return const AppExceptions.conflict();
      case 408:
        return const AppExceptions.requestTimeout();
      case 422:
        return AppExceptions.unprocessableEntity(errorModel.message);
      case 500:
        return const AppExceptions.internalServerError();
      case 503:
        return const AppExceptions.serviceUnavailable();
      default:
        return AppExceptions.defaultError(
          'Received invalid status code: $statusCode',
        );
    }
  }

  static String getErrorMessage(AppExceptions exception) {
    String errorMessage = '';
    exception.when(
      requestCancelled: () {
        errorMessage = 'Request Cancelled';
      },
      internalServerError: () {
        errorMessage = 'Internal Server Error';
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = 'Service unavailable';
      },
      methodNotAllowed: () {
        errorMessage = 'Method Not Allowed';
      },
      badRequest: (String message) {
        errorMessage = message;
      },
      unauthorizedRequest: (String error) {
        errorMessage = error;
      },
      unprocessableEntity: (String error) {
        errorMessage = error;
      },
      unexpectedError: () {
        errorMessage = 'Unexpected error occurred';
      },
      requestTimeout: () {
        errorMessage = 'Connection request timeout';
      },
      noInternetConnection: () {
        errorMessage = 'No internet connection';
      },
      conflict: () {
        errorMessage = 'Error due to a conflict';
      },
      sendTimeout: () {
        errorMessage = 'Send timeout in connection with API server';
      },
      unableToProcess: () {
        errorMessage = 'Unable to process the data';
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = 'Unexpected error occurred';
      },
      forbidden: (String error) {
        errorMessage = error;
      },
      canceledByUser: () {
        errorMessage = 'Canceled By The User';
      },
      invalidCredentials: () {
        errorMessage = 'Invalid Credentials';
      },
      emailAlreadyUsed: () {
        errorMessage = 'Email already used';
      },
    );
    return errorMessage;
  }
}
