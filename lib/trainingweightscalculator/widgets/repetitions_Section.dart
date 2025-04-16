import 'package:flutter/material.dart';
// Assicurati di importare il file dove si trova AppConstants
import './section_title.dart';
import './constants.dart';

class RepetitionsSection extends StatefulWidget {
  // Aggiungiamo una callback per notificare il valore selezionato
  final Function(String?) onRmChanged;
  // Aggiungiamo un valore iniziale opzionale
  final String? initialValue;
  // Aggiungiamo un testo di errore opzionale
  final String? errorText;

  const RepetitionsSection({
    super.key,
    required this.onRmChanged,
    this.initialValue,
    this.errorText,
  });

  @override
  State<RepetitionsSection> createState() => _RepetitionsSectionState();
}

class _RepetitionsSectionState extends State<RepetitionsSection> {
  String? _rm;
  String? _rmError;

  @override
  void initState() {
    super.initState();
    _rm = widget.initialValue;
    _rmError = widget.errorText;
  }

  @override
  void didUpdateWidget(RepetitionsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      _rmError = widget.errorText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Per quante ripetizioni hai sollevato il peso che hai scritto sopra?'
        ),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Seleziona il n. di ripetizioni',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.fitness_center),
                errorText: _rmError,
              ),
              value: _rm,
              items: AppConstants.rmOptions.map((rm) {
                return DropdownMenuItem(
                  value: rm,
                  child: Text(rm),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _rm = value;
                  _rmError = null;
                });
                widget.onRmChanged(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}