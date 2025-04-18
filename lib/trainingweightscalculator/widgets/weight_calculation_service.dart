/// Service class for calculating training weights based on repetition maximums.
class WeightCalculationService {
  /// Calculates training weights based on the provided parameters.
  ///
  /// [weight] is the weight lifted.
  /// [rmType] is the repetition maximum type (e.g., '1RM', '5RM', '10RM').
  ///
  /// Returns a map of percentage labels to calculated weights.
  static Map<String, double> calculateTrainingWeights({
    required double weight,
    required String rmType, 
    required bool isStreetlifting, required double bodyWweight,
  }) {
    final Map<String, double> results = {};
    
    // Calculate based on the RM type
    switch (rmType) {
      case '1RM':
      if(isStreetlifting){
        double streetliftingCalculateFactor = bodyWweight + weight;
        results['60%'] = (((streetliftingCalculateFactor * 0.6) - bodyWweight) + (weight * 0.6)) / 2;
        results['70%'] = (((streetliftingCalculateFactor * 0.7) - bodyWweight) + (weight * 0.7)) / 2;
        results['80%'] = (((streetliftingCalculateFactor * 0.8) - bodyWweight) + (weight * 0.8)) / 2;
        results['90%'] = (((streetliftingCalculateFactor * 0.9) - bodyWweight) + (weight * 0.9)) / 2;
        results['95%'] = (((streetliftingCalculateFactor * 0.95) - bodyWweight) + (weight * 0.95)) / 2;
        break;
      } else {
        results['60%'] = weight * 0.6;
        results['70%'] = weight * 0.7;
        results['80%'] = weight * 0.8;
        results['90%'] = weight * 0.9;
        results['95%'] = weight * 0.95;
        break;
      }
              
      case '5RM':
        // Formula to estimate 1RM from 5RM: weight * 1.15
        final estimated1RM = weight * 1.15;
        results['1RM stimato'] = estimated1RM;
        results['60% (del 1RM)'] = estimated1RM * 0.6;
        results['70% (del 1RM)'] = estimated1RM * 0.7;
        results['80% (del 1RM)'] = estimated1RM * 0.8;
        results['90% (del 1RM)'] = estimated1RM * 0.9;
        break;
        
      case '10RM':
        // Formula to estimate 1RM from 10RM: weight * 1.33
        final estimated1RM = weight * 1.33;
        results['1RM stimato'] = estimated1RM;
        results['60% (del 1RM)'] = estimated1RM * 0.6;
        results['70% (del 1RM)'] = estimated1RM * 0.7;
        results['80% (del 1RM)'] = estimated1RM * 0.8;
        results['90% (del 1RM)'] = estimated1RM * 0.9;
        break;
        
      default:
        // Default case for any other RM type
        results['60%'] = weight * 0.6;
        results['70%'] = weight * 0.7;
        results['80%'] = weight * 0.8;
        results['90%'] = weight * 0.9;
    }
    
    return results;
  }
}