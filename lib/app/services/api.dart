import 'package:coronavirus_app/app/services/api_keys.dart';

class API {
  final String apiKey;

  API({required this.apiKey});

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static const String host = "ncov2019-admin.firebaseapp.com";

// Define a resource identifier that is used to get the access token
  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );
}
