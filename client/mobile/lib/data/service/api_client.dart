import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final String _host;
  final int _port;
  final Map<String, String> _baseHeaders;
  final FlutterSecureStorage _flutterSecureStorage;

  ApiClient({
    required String host,
    required int port,
    required Map<String, String> baseHeaders,
    required FlutterSecureStorage flutterSecureStorage,
  }) : _host = host,
       _port = port,
       _baseHeaders = baseHeaders,
       _flutterSecureStorage = flutterSecureStorage;
}
