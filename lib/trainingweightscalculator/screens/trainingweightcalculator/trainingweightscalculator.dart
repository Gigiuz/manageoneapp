import 'package:flutter/material.dart';
import 'package:manageoneapp/utils/assets.dart';
import 'package:manageoneapp/main.dart';

// Import the extracted components
import '../../widgets/WeightInputSection.dart';
import '../../widgets/repetitions_Section.dart';
import '../../widgets/section_title.dart';
import '../../widgets/training_option.dart';
import '../../widgets/weight_calculation_service.dart';
import '../../widgets/weight_calculator_dialog.dart';
import '../../widgets/constants.dart';

/// A widget that calculates training weights based on user input.
class TrainingWeightCalculator extends StatefulWidget {
  const TrainingWeightCalculator({super.key});

  @override
  State<TrainingWeightCalculator> createState() =>
      _TrainingWeightCalculatorState();
}

class _TrainingWeightCalculatorState extends State<TrainingWeightCalculator> {
  // Form state
  String? _typeTraining;
  String? _typeTrainingError;
  String? _rm;
  String? _rmError;
  bool _isStreetlifting = false;
  
  // Controller for the weight input field
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bodyWeightController = TextEditingController();
  String? _weightError;
    String? _bodyWeightError;
  
  // Global key for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _weightController.dispose();
    _bodyWeightController.dispose();
    super.dispose();
  }

  /// Validates all form fields and returns true if all are valid.
  bool _validateFields() {
    bool isValid = true;
    
    // Validate training type
    if (_typeTraining == null) {
      setState(() {
        _typeTrainingError = AppConstants.errorSelectTrainingType;
      });
      isValid = false;
    }
    
    // Validate weight
    if (_weightController.text.isEmpty) {
      setState(() {
        _weightError = AppConstants.errorEnterWeight;
      });
      isValid = false;
    } else {
      final number = double.tryParse(_weightController.text);
      if (number == null || number <= 0) {
        setState(() {
          _weightError = AppConstants.errorEnterValidNumber;
        });
        isValid = false;
      }
    }

        // Validate bodyWweight
    if (_bodyWeightController.text.isEmpty && _isStreetlifting) {
      setState(() {
        _bodyWeightError = AppConstants.errorEnterBodyWeight;
      });
      isValid = false;
    } else if(_isStreetlifting){
      final number = double.tryParse(_bodyWeightController.text);
      if (number == null || number <= 0) {
        setState(() {
          _bodyWeightError = AppConstants.errorEnterValidNumber;
        });
        isValid = false;
      }
    }
    
    // Validate RM selection
    if (_rm == null) {
      setState(() {
        _rmError = AppConstants.errorSelectRepetitions;
      });
      isValid = false;
    }
    
    return isValid;
  }
  
  /// Calculates training weights and shows results dialog.
  void _calculateAndShowResults() {
    if (_validateFields()) {
      final weight = double.parse(_weightController.text);
      
      //calculate training weights based on input
      final results = WeightCalculationService.calculateTrainingWeights(
        weight: weight,
        rmType: _rm!,
      );
      
      // Show results dialog
      WeightCalculatorResultsDialog.show(
        context: context,
        results: results,
        rmType: _rm!,
        weight: _weightController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),     
                 _buildTrainingTypeSection(),           
                const SizedBox(height: 24),
                InputSection(sectionTitle: 'Peso sollevato', labelText: 'Peso sollevato (kg)', controller: _weightController, errorText: _weightError, onChanged: (value) {
                if (_weightError != null) {
                  setState(() {
                    _weightError = null;
                  });
                }}),
                // _buildWeightInputSection(),
                const SizedBox(height: 24),
                RepetitionsSection(
                  initialValue: _rm,
                  errorText: _rmError,
                  onRmChanged: (value) {
                    setState(() {
                      _rm = value;
                      _rmError = null;
                    });
                  },
                ),
                const SizedBox(height: 24),               
                if(_isStreetlifting)
                  InputSection(sectionTitle: 'Peso corporeo', labelText: 'Peso corporeo (kg)', controller: _bodyWeightController, errorText: _bodyWeightError, onChanged: (value) {
                if (_bodyWeightError != null) {
                  setState(() {
                    _bodyWeightError = null;
                  });
                }}),
                if(_isStreetlifting)
                  const SizedBox(height: 24),
                const SizedBox(height: 32),
                _buildCalculateButton(),
                const SizedBox(height: 24),
                _buildHomeButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the header section with title and icon.
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Builds the training type selection section.
  Widget _buildTrainingTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Tipo di allenamento'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TrainingOption(
              label: 'Streetlifting',
              value: 'streetlifting',
              groupValue: _typeTraining,
              color: Colors.black,
              iconImage: Image(image: Assets.logo, width: 80, height: 80),
              onChanged: (value) => setState(() {
                _typeTraining = value;
                _typeTrainingError = null;
                _isStreetlifting = true;
              }),
            ),
            const SizedBox(width: 16),
            TrainingOption(
              label: 'Bilanciere/Pesi',
              value: 'external_weights',
              groupValue: _typeTraining,
              color: Colors.black,
              icon: Icons.fitness_center,
              onChanged: (value) => setState(() {
                _typeTraining = value;
                _typeTrainingError = null;
                 _isStreetlifting = false;
              }),
            ),
          ],
        ),
        if (_typeTrainingError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 12.0),
            child: Text(
              _typeTrainingError!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  /// Builds the weight input section.
  Widget _buildWeightInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Peso sollevato'),
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
                labelText: 'Peso sollevato (kg)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.monitor_weight),
                suffixText: 'kg',
                floatingLabelBehavior: FloatingLabelBehavior.always,
                errorText: _weightError,
              ),
              onChanged: (value) {
                if (_weightError != null) {
                  setState(() {
                    _weightError = null;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the calculate button.
  Widget _buildCalculateButton() {
    return ElevatedButton.icon(
      onPressed: _calculateAndShowResults,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: const Icon(Icons.calculate),
      label: const Text(
        'Calcola Pesi di Allenamento',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  /// Builds the button to return to the home screen.
  Widget _buildHomeButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SharedScaffold(
              body: MyHomePageContent(),
              title: 'Manage One',
              currentIndex: 0,
            ),
          ),
        );
      },
      icon: const Icon(Icons.arrow_back),
      label: const Text('Torna alla Home'),
    );
  }
}