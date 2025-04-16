import 'package:flutter/material.dart';

import 'section_title.dart';

/// Una classe stateless per creare sezioni di input personalizzabili.
class InputSection extends StatelessWidget {
  /// Il titolo della sezione di input.
  final String sectionTitle;
  
  /// Il testo dell'etichetta per il campo di input.
  final String labelText;
  
  /// Il controller per gestire il valore del campo di input.
  final TextEditingController controller;
  
  /// Il tipo di tastiera da mostrare.
  final TextInputType keyboardType;
  
  /// L'icona da mostrare all'inizio del campo di input.
  final IconData? prefixIcon;
  
  /// Il testo da mostrare alla fine del campo di input.
  final String? suffixText;
  
  /// Il messaggio di errore da mostrare, se presente.
  final String? errorText;
  
  /// Funzione chiamata quando il valore del campo cambia.
  final Function(String)? onChanged;

  /// Costruttore per creare una nuova sezione di input.
  const InputSection({
    super.key,
    required this.sectionTitle,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.number,
    this.prefixIcon,
    this.suffixText,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: sectionTitle),
        Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                suffixText: suffixText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                errorText: errorText,
              ),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
