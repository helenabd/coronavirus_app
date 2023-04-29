// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:coronavirus_app/app/services/services.dart';

class APIService {
  APIService(this.api);

  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    log('Request ${api.tokenUri()} failed \nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }
}
