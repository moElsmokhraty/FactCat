import 'package:flutter/material.dart';
import 'widgets/facts_history_view_body.dart';
import '../../../../../core/models/fact_parameter.dart';

class FactsHistoryView extends StatelessWidget {
  const FactsHistoryView({super.key, required this.factsHistory});

  final List<FactParameter> factsHistory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          'Facts History',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: FactsHistoryViewBody(factsHistory: factsHistory)),
    );
  }
}
