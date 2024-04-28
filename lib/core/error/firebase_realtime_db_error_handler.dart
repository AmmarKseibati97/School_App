import 'package:a_school_app/core/enums/enums.dart';
import 'package:a_school_app/core/error/exeption.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseRealtimeDbErrorHandler {
  /*
  I've assumed interpretations based on the error message content, which
  might not always be directly mapped to
  a code property like in Firestore or FirebaseAuth exceptions.
  This approach requires you to potentially parse the error
  message for specific keywords or patterns that indicate the nature of the error.
  */
  static AppException handleFirebaseRealtimeDbException(FirebaseException e) {
    ExceptionCode code = ExceptionCode.firebaseRealTimeDbError;
    String defaultMessage =
        "An unexpected error occurred with Firebase Realtime Database.";
    String message = e.message ?? defaultMessage;

    // Mapping of error message patterns to user friendly messages
    final Map<String, String> errorMessages = {
      'PERMISSION_DENIED':
          "You do not have permission to access this resource in the Realtime Database.",
      'network error':
          "A network error occurred while accessing the Realtime Database.",
      'data exceeds size limit':
          "The operation failed because the data exceeds the size limit.",
      'timeout': "The Realtime Database operation timed out.",
      'too many requests':
          "Too many requests were sent to the Realtime Database in a short amount of time.",
    };

    // Iterate through the map and find a match
    for (var entry in errorMessages.entries) {
      if (e.message?.contains(entry.key) == true) {
        message = entry.value;
        break;
      }
    }

    // If no specific error message is matched, use the default message
    message = message.isEmpty ? defaultMessage : message;

    return AppException(
        code: code, message: message, stackTrace: StackTrace.current);
  }
}
