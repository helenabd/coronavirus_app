import 'package:coronavirus_app/app/app.dart';

class EndpointsData {
  EndpointsData({this.values});

  final Map<Endpoint, EndpointData>? values;
  EndpointData? get cases => values![Endpoint.cases];
  EndpointData? get casesSuspected => values![Endpoint.casesSuspected];
  EndpointData? get casesConfirmed => values![Endpoint.casesConfirmed];
  EndpointData? get deaths => values![Endpoint.deaths];
  EndpointData? get recovered => values![Endpoint.recovered];

  @override
  String toString() => 'EndpointsData(values: $values)';
}
