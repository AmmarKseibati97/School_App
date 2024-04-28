import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/error/exeption.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthErrorHandler {
  static AppException handleFirebaseAuthException(FirebaseAuthException e) {
    ExceptionCode code = ExceptionCode.authError;

    // Mapping FirebaseAuth error codes to user friendly messages
    final Map<String, String> errorCodeMessages = {
      'invalid-credential':
          'The supplied auth credential is incorrect, malformed or has expired.',
      'invalid-email': "Your email address appears to be malformed.",
      'wrong-password': "Your password is wrong.",
      'user-not-found': "User with this email doesn't exist.",
      'user-disabled': "User with this email has been disabled.",
      'too-many-requests': "Too many requests. Try again later.",
      'operation-not-allowed':
          "Signing in with Email and Password is not enabled.",
      'network-request-failed':
          'A network error (such as timeout, interrupted connection or unreachable host) has occurred.',
    };

    // Get the message corresponding to the error code or use a default message
    String message =
        errorCodeMessages[e.code] ?? "An undefined Error happened.";

    return AppException(
      code: code,
      message: message,
      stackTrace: StackTrace.current,
    );
  }
}
