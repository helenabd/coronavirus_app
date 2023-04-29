// ignore_for_file: depend_on_referenced_packages

import 'package:coronavirus_app/app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dasheboard extends StatefulWidget {
  const Dasheboard({super.key});

  @override
  State<Dasheboard> createState() => _DasheboardState();
}

class _DasheboardState extends State<Dasheboard> {
  int _cases = 0;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases =
        await dataRepository.getEndpointData(endpoint: Endpoint.cases);
    setState(() {
      _cases = cases;
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
            EndpointCard(
              endpoint: Endpoint.cases,
              value: (_cases != 0) ? _cases : 0,
            )
          ],
        ),
      ),
    );
  }
}
