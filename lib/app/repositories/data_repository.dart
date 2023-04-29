// ignore_for_file: unnecessary_null_comparison, prefer_conditional_assignment, depend_on_referenced_packages

import 'package:coronavirus_app/app/app.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({required this.apiService});

  final APIService apiService;

  Future<T> getDataRefreshingToken<T>(
      {required Future<T> Function() onGetData}) async {
    try {
      return await onGetData();
    } on Response {
      rethrow;
    }
  }

  Future<int> getEndpointData({required Endpoint endpoint}) async {
    String accessToken = await apiService.getAccessToken();
    return await getDataRefreshingToken<int>(
        onGetData: () => apiService.getEndpointData(
              accessToken: accessToken,
              endpoint: endpoint,
            ));
  }

  Future<EndpointsData> getAllEndpointData() async =>
      await getDataRefreshingToken<EndpointsData>(
          onGetData: _getAllEndpointsData);

  Future<EndpointsData> _getAllEndpointsData() async {
    String accessToken = await apiService.getAccessToken();
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(
          accessToken: accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(
          accessToken: accessToken, endpoint: Endpoint.recovered),
    ]);

    return EndpointsData(values: {
      Endpoint.cases: values[0],
      Endpoint.casesSuspected: values[1],
      Endpoint.casesConfirmed: values[2],
      Endpoint.deaths: values[3],
      Endpoint.recovered: values[4],
    });
  }
}
