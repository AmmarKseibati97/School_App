import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/error/failure.dart';
import 'package:a_school_app/core/error/firebase_auth_error_handler.dart';
import 'package:a_school_app/core/error/firebase_realtime_db_error_handler.dart';
import 'package:equatable/equatable.dart';
import 'package:logger/web.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() {
    return '$message';
  }
}

class FetchDataException extends ServerException {
  const FetchDataException([message]) : super("Error During Communication");
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super("Bad Request");
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super("Unauthorized");
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super("Requested Info Not Found");
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super("Conflict Occurred");
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message])
      : super("Internal Server Error");
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([message])
      : super("No Internet Connection");
}

class CacheException implements Exception {}

class AppException extends Equatable implements Exception {
  const AppException({
    required this.code,
    this.message,
    this.stackTrace,
  });
  final ExceptionCode code;
  final String? message;
  final StackTrace? stackTrace;

  // Added copyWith method for immutability and convenience
  AppException copyWith({
    ExceptionCode? code,
    String? message,
    StackTrace? stackTrace,
  }) {
    return AppException(
      code: code ?? this.code,
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  // Factory constructors for common exceptions.
  factory AppException.unknown({String? message, StackTrace? stackTrace}) =>
      AppException(
          code: ExceptionCode.unknown,
          message: message,
          stackTrace: stackTrace);

  @override
  List<Object?> get props => [code, message];

  @override
  String toString() {
    return 'AppException(code: $code, message: $message, stackTrace: $stackTrace)';
  }
}

extension ExceptionExtension on Exception {
  Failure toFailure({bool realtimeDbException = false}) {
    switch (runtimeType) {
      case const (AppException):
        final e = this as AppException;
        return _appExceptionToFailure(e);
      case const (FirebaseAuthException):
        final e = this as FirebaseAuthException;
        final AppException appException =
            FirebaseAuthErrorHandler.handleFirebaseAuthException(e);
        return _appExceptionToFailure(appException);
      case const (FirebaseException):
        final e = this as FirebaseException;
        final AppException appException =
            FireBaseRealtimeDbErrorHandler.handleFirebaseRealtimeDbException(e);
        return _appExceptionToFailure(appException);
      default:
        Logger().e(this);
        return Failure(message: toString(), title: 'error');
    }
  }
}

Failure _appExceptionToFailure(AppException e) {
  Logger().e({
    'Message': e.message ?? e.code.title,
    'title': e.code.title,
  });
  return Failure(
    message: e.message ?? e.code.message,
    title: e.code.title,
    widget: e.code.widget,
  );
}

extension ExceptionCodeExtension on ExceptionCode {
  String get message {
    switch (this) {
      case ExceptionCode.urlLaunchFailed:
        return 'Failed to launch this URL';
      case ExceptionCode.verificationFailed:
        return 'user verification failed';
      case ExceptionCode.firebaseError:
        return 'firebase_error';
      case ExceptionCode.mappingError:
        return 'mapping_error';
      case ExceptionCode.invalidData:
        return 'Invalid Data';
      case ExceptionCode.invalidReference:
        return 'Invalid Reference';
      case ExceptionCode.unknown:
        return 'unknown_error';
      case ExceptionCode.invalidLocale:
        return 'Invalid Locale';
      case ExceptionCode.authError:
        return 'auth_error';
      case ExceptionCode.fireStoreError:
        return 'fire_store_error';
      case ExceptionCode.firebaseRealTimeDbError:
        return 'firebase_real_time_db_error';
      case ExceptionCode.dataNotFound:
        return 'data_not_found';
      case ExceptionCode.fileSizeExceedsLimit:
        return 'The uploaded file is larger than the limit, Please '
            'upload a smaller file.';
    }
  }

  String get title {
    switch (this) {
      case ExceptionCode.urlLaunchFailed:
      case ExceptionCode.firebaseError:
      case ExceptionCode.invalidData:
      case ExceptionCode.invalidReference:
      case ExceptionCode.dataNotFound:
      case ExceptionCode.unknown:
      case ExceptionCode.mappingError:
      case ExceptionCode.invalidLocale:
      case ExceptionCode.authError:
      case ExceptionCode.fireStoreError:
      case ExceptionCode.firebaseRealTimeDbError:
      case ExceptionCode.fileSizeExceedsLimit:
      case ExceptionCode.verificationFailed:
        return 'error';
    }
  }

  Widget? get widget {
    switch (this) {
      case ExceptionCode.urlLaunchFailed:
      case ExceptionCode.firebaseError:
      case ExceptionCode.invalidData:
      case ExceptionCode.invalidReference:
      case ExceptionCode.dataNotFound:
      case ExceptionCode.unknown:
      case ExceptionCode.mappingError:
      case ExceptionCode.invalidLocale:
      case ExceptionCode.authError:
      case ExceptionCode.fireStoreError:
      case ExceptionCode.firebaseRealTimeDbError:
      case ExceptionCode.fileSizeExceedsLimit:
      case ExceptionCode.verificationFailed:
        return null;
    }
  }
}
