//Exception
class DeviceException implements Exception {
  final String message;
  final int statusCode;
  DeviceException(this.message, {this.statusCode = 404});

  factory DeviceException.fromJson(Map<String, dynamic> json,
          {int code = 404}) =>
      DeviceException(json['detail'] as String, statusCode: code);

  @override
  String toString() => message;
}
