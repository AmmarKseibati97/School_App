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
