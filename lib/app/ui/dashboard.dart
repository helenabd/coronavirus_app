// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:io';

import 'package:coronavirus_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dasheboard extends StatefulWidget {
  const Dasheboard({super.key});

  @override
  State<Dasheboard> createState() => _DasheboardState();
}

class _DasheboardState extends State<Dasheboard> {
  EndpointsData _endpointsData = EndpointsData();

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointData();
      setState(() {
        _endpointsData = endpointsData;
      });
    } on SocketException catch (_) {
      showAlertDialog(
        context: context,
        title: 'Connection Error',
        content: 'Could not retrieve data. Please try again later.',
        defaultActionText: 'OK',
      );
    } catch (_) {
      showAlertDialog(
        context: context,
        title: 'Unknown Error',
        content: 'Please contact support or try again later.',
        defaultActionText: 'OK',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_endpointsData.values != null) {
      final date = _endpointsData != null
          ? _endpointsData.values![Endpoint.cases]!.date
          : null;
      final formatter = LastUpdatedDateFormatter(lastUpdated: date!);
      final lastDate = formatter.lastUpdatedStatusText();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Coronavirus Tracker'),
        ),
        body: RefreshIndicator(
          onRefresh: _updateData,
          child: ListView(
            children: [
              LastUpdatedStatusText(text: lastDate),
              if (_endpointsData.values != null)
                for (var endpoint in Endpoint.values)
                  EndpointCard(
                    endpoint: endpoint,
                    value: _endpointsData != null
                        ? _endpointsData.values![endpoint]!.value
                        : null,
                  )
              else
                Container()
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Coronavirus Tracker'),
          ),
          body: Container());
    }
  }
}
