import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../../../core/models/fact_parameter.dart';

class FactsHistoryViewBody extends StatelessWidget {
  const FactsHistoryViewBody({super.key, required this.factsHistory});

  final List<FactParameter> factsHistory;

  @override
  Widget build(BuildContext context) {
    return factsHistory.isEmpty
        ? const Center(child: Text('No facts yet.'))
        : ListView.separated(
            itemCount: factsHistory.length,
            padding: EdgeInsets.all(12),
            separatorBuilder: (context, index) => SizedBox(height: 16),
            itemBuilder: (context, index) {
              final fact = factsHistory[index];
              return ListTile(
                leading: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                title: fact.image.startsWith('http')
                    ? Image.network(fact.image, height: 100, fit: BoxFit.cover)
                    : Image.file(
                        File(fact.image),
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                subtitle: Text(
                  fact.fact,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              );
            },
          );
  }
}
