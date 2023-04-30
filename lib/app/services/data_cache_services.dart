// ignore_for_file: depend_on_referenced_packages

import 'package:coronavirus_app/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheServices {
  DataCacheServices({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  static String endpointValueKey({required Endpoint endpoint}) =>
      '$endpoint/value';
  static String endpointDateKey({required Endpoint endpoint}) =>
      '$endpoint/date';

  EndpointsData getData() {
    Map<Endpoint, EndpointData> values = {};
    for (var endpoint in Endpoint.values) {
      final value =
          sharedPreferences.getInt(endpointValueKey(endpoint: endpoint));
      final dateString =
          sharedPreferences.getString(endpointDateKey(endpoint: endpoint));
      if (value != null && dateString != null) {
        final date = DateTime.tryParse(dateString);
        values[endpoint] = EndpointData(value: value, date: date);
      }
    }
    return EndpointsData(values: values);
  }

  Future<void> setData(EndpointsData endpointsData) async {
    endpointsData.values?.forEach((endpoint, endpointData) async {
      await sharedPreferences.setInt(
        endpointValueKey(endpoint: endpoint),
        endpointData.value,
      );
      await sharedPreferences.setString(
        endpointDateKey(endpoint: endpoint),
        endpointData.date!.toIso8601String(),
      );
    });
  }
}
