import 'dart:convert';
import 'package:http/http.dart';
import 'package:omwaytech/utils/request_enum.dart';
import 'package:omwaytech/utils/string_to_url.dart';
import 'package:omwaytech/utils/token.dart';

class OmWaysRepo {
  final Client _client;

  OmWaysRepo(this._client);

  Future<Response> request({
    required RequestEnum requestType,
    // dynamic heading = Nothing,
    required String url,
    dynamic parameter,
  }) async {
    Map<String, String> heading = {
      //'Content-Type': 'application/json',
    };
    Map<String, String> headingWithToken = {
      'Authorization': 'Bearer ${AccessToken.token}',
    };
    Map<String, String> acceptToken = {
      'Authorization': 'Bearer ${AccessToken.token}',
    };

    switch (requestType) {
      case RequestEnum.get:
        return _client.get(
          stringToUrl(url),
          headers: heading,
        );
      case RequestEnum.post:
        return _client.post(
          stringToUrl(url),
          body: parameter,
          headers: heading,
        );

      default:
        return throw Exception("The HTTP request method is not found");
    }
  }
}
