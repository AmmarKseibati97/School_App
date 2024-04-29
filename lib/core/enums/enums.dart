import 'package:a_school_app/core/extensions/string_extension.dart';
import 'package:flutter/material.dart';

enum Flavor {
  development,
  staging,
  production,
}

///Contain all exception codes in the app  .
enum ExceptionCode {
  unknown,
  invalidData,
  invalidReference,
  dataNotFound,
  mappingError,
  invalidLocale,
  firebaseError,
  authError,
  fireStoreError,
  firebaseRealTimeDbError,
  fileSizeExceedsLimit,
  verificationFailed,
  urlLaunchFailed,
}

enum ValidationType {
  email,
  password,
}

enum ChecksType {
  absences,
  present,
  leave,
}

String? validateInput(
  String? value,
  BuildContext context,
  ValidationType validationType, {
  String? password,
}) {
  if (value == null || value.isEmpty) {
    return "empty";
  }
  switch (validationType) {
    case ValidationType.email:
      if (!value.isValidEmail()) {
        return "email empty";
      }
      return null;
    case ValidationType.password:
      if (!value.isPasswordValid()) {
        return "password empty";
      }
      return null;
  }
}
