//Checking for internet
import 'dart:io';

import '../error/exception.dart';

abstract class NetworkInfo {
  Future<bool> hasInternet();
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> hasInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return true;
      throw DeviceException(
        'No internet access\nConnect your device to the internet.',
        statusCode: 500,
      );
    } on SocketException catch (_) {
      throw DeviceException(
        'No internet access\nConnect your device to the internet.',
        statusCode: 500,
      );
    }
  }
}
