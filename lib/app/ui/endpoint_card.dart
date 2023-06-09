// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages

import 'package:coronavirus_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCardData {
  final String title;
  final String assetName;
  final Color color;

  EndpointCardData({
    required this.title,
    required this.assetName,
    required this.color,
  });
}

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int? value;

  const EndpointCard({
    super.key,
    required this.endpoint,
    required this.value,
  });

  static final Map<Endpoint, EndpointCardData> _cardsData = {
    Endpoint.cases: EndpointCardData(
        title: 'Cases',
        assetName: 'assets/count.png',
        color: const Color(0xFFFFF492)),
    Endpoint.casesSuspected: EndpointCardData(
        title: 'Suspected Cases',
        assetName: 'assets/suspect.png',
        color: const Color(0xFFEEDA28)),
    Endpoint.casesConfirmed: EndpointCardData(
        title: 'Confirmed Cases',
        assetName: 'assets/fever.png',
        color: const Color(0xFFE99600)),
    Endpoint.deaths: EndpointCardData(
        title: 'Deaths',
        assetName: 'assets/death.png',
        color: const Color(0xFFE40000)),
    Endpoint.recovered: EndpointCardData(
        title: 'Recovered',
        assetName: 'assets/patient.png',
        color: const Color(0xFF70A901)),
  };

  String get formattedValue {
    if (value == null) {
      return '';
    }
    return NumberFormat('#,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cardData!.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: cardData.color),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 52,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(cardData.assetName, color: cardData.color),
                    Text(formattedValue,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: cardData.color,
                                fontWeight: FontWeight.w500))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
