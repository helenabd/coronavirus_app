// ignore_for_file: unnecessary_null_comparison

import 'package:coronavirus_app/app/app.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int? value;

  const EndpointCard({
    super.key,
    required this.endpoint,
    required this.value,
  });

  static final Map<Endpoint, String> _cardTitles = {
    Endpoint.cases: 'Cases',
    Endpoint.casesSuspected: 'Cases Suspected',
    Endpoint.casesConfirmed: 'Cases Confirmed',
    Endpoint.deaths: 'Deaths',
    Endpoint.recovered: 'Recovered',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _cardTitles[endpoint]!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(value != null ? value.toString() : '',
                  style: Theme.of(context).textTheme.titleLarge)
            ],
          ),
        ),
      ),
    );
  }
}
