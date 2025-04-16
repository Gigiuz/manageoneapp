import 'package:flutter/material.dart';

/// A dialog to display training weight calculation results.
class WeightCalculatorResultsDialog extends StatelessWidget {
  final Map<String, double> results;
  final String rmType;
  final String weight;

  /// Creates a dialog to display training weight calculation results.
  ///
  /// The [results] map contains percentage labels and corresponding weight values.
  /// The [rmType] is the repetition maximum type (e.g., '1RM', '5RM').
  /// The [weight] is the weight lifted by the user.
  const WeightCalculatorResultsDialog({
    super.key,
    required this.results,
    required this.rmType,
    required this.weight,
  });

  /// Shows the weight calculator results dialog.
  static Future<void> show({
    required BuildContext context,
    required Map<String, double> results,
    required String rmType,
    required String weight,
  }) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return WeightCalculatorResultsDialog(
          results: results,
          rmType: rmType,
          weight: weight,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Risultati Calcolo Pesi',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'In base al tuo $rmType di $weight kg:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...results.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(entry.key),
                    Text(
                      '${entry.value.toStringAsFixed(1)} kg',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Chiudi'),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}