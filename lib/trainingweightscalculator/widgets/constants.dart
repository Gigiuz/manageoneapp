/// Constants used throughout the application.
class AppConstants {
  /// Private constructor to prevent instantiation.
  AppConstants._();
  
  /// Repetition maximum options available for selection.
  static const Set<String> rmOptions = {
    '1RM',
    '5RM',
    '10RM',
  };
  
  /// Training types available.
  static const Map<String, String> trainingTypes = {
    'streetlifting': 'Streetlifting',
    'external_weights': 'Bilanciere/Pesi',
  };
  
  /// Form error messages.
  static const String errorSelectTrainingType = 'Seleziona un tipo di allenamento';
  static const String errorEnterWeight = 'Inserisci il peso';
   static const String errorEnterBodyWeight = 'Inserisci il peso corporeo';
  static const String errorEnterValidNumber = 'Inserisci un numero valido';
  static const String errorSelectRepetitions = 'Seleziona il numero di ripetizioni';
}