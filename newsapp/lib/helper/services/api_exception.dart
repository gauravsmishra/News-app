class AppException implements Exception {
  final _message;
  String? _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    if (_prefix == null) {
      return "Error: $_message";
    }
    return "$_prefix $_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication:");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request:");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised:");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input:");
}
