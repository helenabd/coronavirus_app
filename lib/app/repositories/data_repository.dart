import 'package:coronavirus_app/app/app.dart';

class DataRepository {
  DataRepository({required this.apiService});

  final APIService apiService;

  Future<int> getEndpointData({required Endpoint endpoint}) async {
    final accessToken = await apiService.getAccessToken();
    return await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: endpoint,
    );
  }
}
