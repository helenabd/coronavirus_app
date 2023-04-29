import 'package:coronavirus_app/app/app.dart';

class EndpointsData {
  EndpointsData({required this.values});

  final Map<Endpoint, int> values;
  int? get cases => values[Endpoint.cases];
  int? get casesSuspected => values[Endpoint.casesSuspected];
  int? get casesConfirmed => values[Endpoint.casesConfirmed];
  int? get deaths => values[Endpoint.deaths];
  int? get recovered => values[Endpoint.recovered];

  @override
  String toString() => 'EndpointsData(values: $values)';
}
