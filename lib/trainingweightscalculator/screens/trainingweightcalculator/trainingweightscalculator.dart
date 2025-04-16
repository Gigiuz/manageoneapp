import 'package:flutter/material.dart';
import 'package:manageoneapp/utils/assets.dart';
import 'package:manageoneapp/main.dart';

  final Set<String> rms = {
    '1RM',
    '5RM',
    '10RM',
  };

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

class TrainingWeightCalculator extends StatefulWidget {
  const TrainingWeightCalculator({super.key});

  @override
  State<TrainingWeightCalculator> createState() =>
      _TrainingWeightCalculatorState();
}

class _TrainingWeightCalculatorState extends State<TrainingWeightCalculator> {
  String? _typeTraining;
  String? _typeTrainingError;
  String? _rm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.fitness_center,
                        size: 80,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Calcolatore Pesi Allenamento',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _TrainingOption(
                            label: 'Streetlifting',
                            value: 'streetlifting',
                            groupValue: _typeTraining,
                            color: Colors.black,
                            // icon: Icons.fitness_center, //qui voglio usarla
                            iconImage: Image(image: Assets.logo,
                        width: 80, height: 80),
                            onChanged: (value) => setState(() {
                              _typeTraining = value;
                              _typeTrainingError = null;
                            }),
                          ),
                          const SizedBox(width: 16),
                          _TrainingOption(
                            label: 'Bilanciere/Pesi',
                            value: 'external_weights',
                            groupValue: _typeTraining,
                            color: Colors.black,
                            
                            icon: Icons.fitness_center,
                            onChanged: (value) => setState(() {
                              _typeTraining = value;
                              _typeTrainingError = null;
                            }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                  const _SectionTitle(title: 'Peso sollevato'),
                  //MARK: - WeightInput
                  Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        // controller: _weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Peso sollevato (kg)',
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

                  const _SectionTitle(title: 'Per quante ripetizioni hai sollevato il peso che hai scritto sopra?'),
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
                        ),
                        // value: _lifestyle,
                        items: rms.map((rm) {
                          return DropdownMenuItem(
                            value: rm,
                            child: Text(rm),
                          );
                        }).toList(),
                        onChanged: (value) => setState(() => _rm = value),
                        validator: (value) =>
                            value == null ? 'Seleziona uno stile di vita' : null,
                      ),
                    ),
                  ),


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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

//MARK: - TrainingOption
class _TrainingOption extends StatelessWidget {
  final String label;
  final String value;
  final String? groupValue;
  final Function(String?)? onChanged;
  final Color color;
  final IconData? icon; // può essere null
  final Image? iconImage; // aggiunto per icone personalizzate
  final String? assetImagePath; // aggiunto per asset personalizzati

  const _TrainingOption({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.color,
    this.icon,
    this.iconImage,
    this.assetImagePath,
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
            color: groupValue == value
                ? color.withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: groupValue == value ? color : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              if (iconImage != null)
                SizedBox(width: 32, height: 32, child: iconImage!)
              else if (assetImagePath != null)
                Image.asset(assetImagePath!, width: 32, height: 32, color: Colors.black)
              else if (icon != null)
              Icon(icon, color: color, size: 32),
              // Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: groupValue == value ? color : Colors.black87,
                  fontWeight:
                      groupValue == value ? FontWeight.bold : FontWeight.normal,
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
