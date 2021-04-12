import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// FractalChaosBand High Indicator
class FractalChaosBandHighIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes
  FractalChaosBandHighIndicator(IndicatorDataInput input) : super(input);

  @override
  T calculate(int index) {
    if (index < 4) {
      return createResult(index: index, quote: double.nan);
    }
    if (entries[index - 3].high > entries[index - 2].high &&
        entries[index - 3].high > entries[index - 1].high &&
        entries[index - 3].high > entries[index - 4].high &&
        entries[index - 3].high > entries[index - 5].high) {
      return createResult(index: index, quote: entries[index - 3].high);
    } else {
      return createResult(index: index, quote: getValue(index - 1).quote);
    }
  }
}
