import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  final String uri;
  final Map<String, String> headers;

  ApiService({
    String? uri, 
    Map<String, String>? headers, 
  }) : 
    uri = uri ?? "http://10.0.2.2:8080", 
    headers = headers ?? {"content-type": "application/json; charset=UTF-8"};

  Future<http.Response?> post(String endpoint, Map<String, String> requestBody) async {
    try {
      return await http
          .post(Uri.parse(uri + endpoint), headers: headers, body: jsonEncode(requestBody))
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              return http.Response(
                jsonEncode({"message": "타임아웃", "data": null}),
                HttpStatus.requestTimeout,
                headers: {"content-type": "application/json;charset=UTF-8"},
              );
            },
          );
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
