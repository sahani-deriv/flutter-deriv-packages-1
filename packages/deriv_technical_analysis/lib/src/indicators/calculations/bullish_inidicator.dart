import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Bullish Indicator
class BullishIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  BullishIndicator(IndicatorDataInput input) : super(input);

  @override
  T calculate(int index) {
    if (index < 4 || index > entries.length - 1) {
      return createResult(index: index, quote: double.nan);
    }
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
    if (results[index] == null) {
      results[index] = calculate(index + 2);
    }
    if (index > lastResultIndex) {
      lastResultIndex = index;
    }
    return results[index];
  }
}
