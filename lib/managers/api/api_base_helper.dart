import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config/app/app_config.dart';
import 'api_exceptions.dart';

class ApiBaseHelper {
  final String _baseUrl =
      "${QTAppConfigManager.config.httpScheme}://${QTAppConfigManager.config.backendBaseURL}/${QTAppConfigManager.config.serviceUrl}/";

  final Map<String, String> _headers = {'Content-Type': 'application/json'};

  final Map<String, String> _base64Headers = {
    'content-type': 'application/text'
  };

  Future<dynamic> get(
      {required String endpoint,
      required Map<String, String> params,
      Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      String completeUrl = "";

      if (params == {}) {
        completeUrl = '$_baseUrl$endpoint';
      } else {
        String queryString = params.entries
            .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
            .join('&');
        completeUrl = '$_baseUrl$endpoint?$queryString';
      }

      var response = await http.get(Uri.parse(completeUrl), headers: headers);
      debugPrint(response.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw NoNetworkException();
    }
    return responseJson;
  }

  // Future<dynamic> post(
  //     {required String endpoint,
  //     required Map<String, dynamic> params,
  //     Map<String, String>? headers}) async {
  //   dynamic responseJson;
  //   try {
  //     debugPrint(jsonEncode(params));
  //     var url = Uri.https(_baseUrl, endpoint);
  //     var response = await http.post(url,
  //         headers: headers ?? _headers, body: jsonEncode(params));
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     throw NoNetworkException();
  //   }
  //   return responseJson;
  // }

  Future<dynamic> getWithId(
      {required String endpoint,
      required dynamic id,
      Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      String completeUrl = "";
      completeUrl = '$_baseUrl$endpoint/$id';
      var response = await http.get(Uri.parse(completeUrl),
          headers: headers);
          // ?? await JBAuthTokenHeader.to.getAuthTokenHeader());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw NoNetworkException();
    }
    return responseJson;
  }

  Future<dynamic> postWithBody(
      {required String endpoint,
      required Map<String, String> params,
      required dynamic body,
      Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      debugPrint(jsonEncode(body));
      debugPrint(jsonEncode(params));

      String completeUrl = "";

      if (params == {}) {
        completeUrl = '$_baseUrl$endpoint';
      } else {
        String queryString = params.entries
            .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}')
            .join('&');
        completeUrl = '$_baseUrl$endpoint?$queryString';
      }

      var url = Uri.parse(completeUrl);

      var response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      responseJson = _returnResponse(response);
    } on SocketException {
      throw NoNetworkException();
    }
    return responseJson;
  }

  // Future<dynamic> postWithBodyWithoutJsonEncode(
  //     {required String endpoint,
  //     required Map<String, String> params,
  //     required dynamic body,
  //     Map<String, String>? headers}) async {
  //   dynamic responseJson;
  //   try {
  //     debugPrint(jsonEncode(body));
  //     debugPrint(jsonEncode(params));
  //     var url = Uri.https(_baseUrl, endpoint, params);
  //     var response =
  //         await http.post(url, headers: headers ?? _headers, body: body);
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     throw NoNetworkException();
  //   }
  //   return responseJson;
  // }

  // Future<dynamic> getBase64({required String path}) async {
  //   dynamic responseJson;
  //   try {
  //     var url = Uri.parse(path);
  //     var response = await http.get(url, headers: _base64Headers);
  //     responseJson = response.body;
  //   } on SocketException {
  //     throw NoNetworkException();
  //   }
  //   return responseJson;
  // }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        debugPrint(responseJson.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        debugPrint(responseJson.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 409:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500: throw BadRequestException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
