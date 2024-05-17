import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'errors.freezed.dart';

@freezed
abstract class AppExceptions with _$AppExceptions {
  const factory AppExceptions.requestCancelled() = RequestCancelled;
  const factory AppExceptions.canceledByUser() = CanceledByUser;
  const factory AppExceptions.firebasePlatformException() =
      FirebasePlatformException;

  const factory AppExceptions.badRequest(String reason) = BadRequest;
  const factory AppExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;
  const factory AppExceptions.forbidden() = Forbidden;

  const factory AppExceptions.notFound(String reason) = NotFound;

  const factory AppExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory AppExceptions.notAcceptable() = NotAcceptable;

  const factory AppExceptions.requestTimeout() = RequestTimeout;

  const factory AppExceptions.sendTimeout() = SendTimeout;

  const factory AppExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory AppExceptions.conflict() = Conflict;

  const factory AppExceptions.internalServerError() = InternalServerError;

  const factory AppExceptions.notImplemented() = NotImplemented;

  const factory AppExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory AppExceptions.noInternetConnection() = NoInternetConnection;

  const factory AppExceptions.formatException() = FormatException;

  const factory AppExceptions.unableToProcess() = UnableToProcess;

  const factory AppExceptions.defaultError(String error) = DefaultError;

  const factory AppExceptions.unexpectedError() = UnexpectedError;

  factory AppExceptions._handleResponse(Response? response) {
    ApiErrorResponse errorModel =
        ApiErrorResponse.fromJson(jsonDecode(response?.data));

    int statusCode = response?.statusCode ?? 0;

    switch (statusCode) {
      case 400:
        return AppExceptions.badRequest('${errorModel.message}');
      case 401:
        return AppExceptions.unauthorizedRequest('${errorModel.message}');
      case 403:
        return const AppExceptions.forbidden();

      case 404:
        return AppExceptions.notFound('${errorModel.message}');
      case 405:
        return const AppExceptions.methodNotAllowed();
      case 409:
        return const AppExceptions.conflict();
      case 408:
        return const AppExceptions.requestTimeout();
      case 422:
        return AppExceptions.unprocessableEntity('${errorModel.message}');
      case 500:
        return const AppExceptions.internalServerError();
      case 503:
        return const AppExceptions.serviceUnavailable();
      default:
        int responseCode = statusCode;
        return AppExceptions.defaultError(
          'Received invalid status code: $responseCode',
        );
    }
  }

  factory AppExceptions.getException(error) {
    if (error is Exception) {
      try {
        AppExceptions exception;

        if (error is DioException) {
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
              exception = AppExceptions._handleResponse(error.response);
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
        } else if (error is SocketException) {
          exception = const AppExceptions.noInternetConnection();
        } else {
          exception = const AppExceptions.unexpectedError();
        }
        return exception;
      } on FormatException {
        return const AppExceptions.formatException();
      } catch (_) {
        return const AppExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const AppExceptions.unableToProcess();
      } else {
        return const AppExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(AppExceptions exception) {
    String errorMessage = '';
    exception.when(
      notImplemented: () {
        errorMessage = 'Not Implemented';
      },
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
      notAcceptable: () {
        errorMessage = 'Not acceptable';
      },
      forbidden: () {
        errorMessage = 'Forbidden';
      },
      firebasePlatformException: () {
        errorMessage = 'Platform Exception';
      },
      canceledByUser: () {
        errorMessage = 'Canceled By The User';
      },
    );
    return errorMessage;
  }
}