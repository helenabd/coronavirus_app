import 'package:coronavirus_app/app/services/api_keys.dart';

enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

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

// Define the endpoint uri based on the endpoint
  Uri endpointUri(Endpoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        path: _paths[endpoint],
      );

// Create a map that associate each endpoint to the relative path
  static final Map<Endpoint, String> _paths = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };
}
