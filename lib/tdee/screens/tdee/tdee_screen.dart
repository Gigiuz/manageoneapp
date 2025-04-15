import 'package:flutter/material.dart';
import 'package:manageoneapp/main.dart';

class TdeePage extends StatefulWidget {
  const TdeePage({super.key});

  @override
  State<TdeePage> createState() => _TdeePageState();
}

class _TdeePageState extends State<TdeePage> {
  String? _gender;
  String? _lifestyle;
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();

  final Map<String, double> activityMultipliers = {
    'Sedentario': 1.3,
    'Leggermente attivo': 1.53,
    'Attivo': 1.76,
    'Molto attivo': 1.9,
  };

  final Map<String, String> activityDescriptions = {
    'Sedentario': 'stile di vita sedentario, senza esercizio fisico regolare',
    'Leggermente attivo': '3 - 5 allenamenti a settimana',
    'Attivo': '5 - 7 allenamenti a settimana',
    'Molto attivo': '10 - 12 allenamenti a settimana',
  };

  // Variabile per tenere traccia dell'errore di validazione del sesso
  String? _genderError;

  void _calculateTDEE() {
    // Verifica se il sesso è stato selezionato
    setState(() {
      _genderError = _gender == null ? 'Seleziona il sesso' : null;
    });
    
    if (_formKey.currentState!.validate() &&
        _gender != null &&
        _lifestyle != null) {
      final double base = _gender == 'maschio' ? 24 : 22;
      final double weight = double.parse(_weightController.text);
      final double multiplier = activityMultipliers[_lifestyle]!;
      final double tdee = weight * base * multiplier;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'TDEE Calcolato',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Il tuo fabbisogno calorico giornaliero è:',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '${tdee.toStringAsFixed(0)} kcal',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Chiudi'),                          
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.amber.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const _SectionTitle(title: 'Sesso biologico'),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _GenderOption(
                                label: 'Maschio',
                                value: 'maschio',
                                groupValue: _gender,
                                color: Colors.blue,
                                icon: Icons.male,
                                onChanged: (value) => setState(() {
                                  _gender = value;
                                  _genderError = null; // Resetta l'errore quando viene fatta una selezione
                                }),
                              ),
                              const SizedBox(width: 16),
                              _GenderOption(
                                label: 'Femmina',
                                value: 'femmina',
                                groupValue: _gender,
                                color: Colors.pink,
                                icon: Icons.female,
                                onChanged: (value) => setState(() {
                                  _gender = value;
                                  _genderError = null; // Resetta l'errore quando viene fatta una selezione
                                }),
                              ),
                            ],
                          ),
                        ),
                        // Mostra il messaggio di errore se presente
                        if (_genderError != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                            child: Text(
                              _genderError!,
                              style: TextStyle(
                                color: Colors.red.shade700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  const _SectionTitle(title: 'Peso corporeo'),
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Peso (kg)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.monitor_weight),
                          suffixText: 'kg',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Inserisci il peso';
                          }
                          final number = double.tryParse(value);
                          if (number == null || number <= 0) {
                            return 'Inserisci un numero valido';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  const _SectionTitle(title: 'Stile di vita'),
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
                          labelText: 'Livello di attività',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.fitness_center),
                        ),
                        value: _lifestyle,
                        items: activityMultipliers.keys.map((label) {
                          return DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => _lifestyle = value),
                        validator: (value) =>
                            value == null ? 'Seleziona uno stile di vita' : null,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  // Lista di elementi puntati
                  Card(
                    elevation: 1,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.amber.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Descrizione livelli di attività:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ...activityMultipliers.keys.map((key) => _ActivityLevel(
                                title: key,
                                description: activityDescriptions[key]!,
                              )),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _calculateTDEE,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text(
                      'CALCOLA IL TUO TDEE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
TextButton.icon(
  onPressed: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const SharedScaffold(
          body: MyHomePageContent(),
          title: 'Manage One',
          currentIndex: 0, // Indice della Home
        ),
      ),
    );
  },
  icon: const Icon(Icons.arrow_back),
  label: const Text('Torna alla Home'),
),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final Function(String?)? onChanged;
  final Color color;
  final IconData icon;

  const _GenderOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onChanged?.call(value),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          decoration: BoxDecoration(
            color: groupValue == value ? color.withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: groupValue == value ? color : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: groupValue == value ? color : Colors.black87,
                  fontWeight: groupValue == value ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityLevel extends StatelessWidget {
  final String title;
  final String description;

  const _ActivityLevel({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}