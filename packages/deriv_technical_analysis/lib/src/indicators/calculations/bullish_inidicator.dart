import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Bullish Indicator
class BullishIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  BullishIndicator(IndicatorDataInput input) : super(input);

  @override
  T calculate(int index) {
    if (index < 4) {
      return createResult(index: index, quote: double.nan);
    }
    //In every index, we calculed
    final int i = index - 2;
    if (entries[i].low < entries[i - 1].low &&
        entries[i].low < entries[i - 2].low &&
        entries[i].low < entries[i + 1].low &&
        entries[i].low < entries[i + 2].low) {
      return createResult(index: i, quote: entries[i].low);
    } else {
      return createResult(index: i, quote: double.nan);
    }
  }

  @override
  T getValue(int index) {
    growResultsForIndex(index);
    results[index] = createResult(index: index, quote: double.nan);
    if (index < entries.length - 2) {
      growResultsForIndex(index);
      growResultsForIndex(index);
      if (results[index + 1] == null || results[index + 1] == double.nan) {
        results[index + 1] = createResult(index: index + 1, quote: double.nan);
      }
      results[index + 2] = calculate(index + 2);
      if (index > lastResultIndex) {
        lastResultIndex = index;
      }

      return results[index + 2];
    }
  }
}
