// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

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
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsData = await dataRepository.getAllEndpointData();
    setState(() {
      _endpointsData = endpointsData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            if (_endpointsData.values != null)
              for (var endpoint in Endpoint.values)
                EndpointCard(
                  endpoint: endpoint,
                  value: _endpointsData != null
                      ? _endpointsData.values![endpoint]!
                      : null,
                )
            else
              Container()
          ],
        ),
      ),
    );
  }
}
