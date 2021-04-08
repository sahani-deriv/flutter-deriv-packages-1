import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Bearish Indicator
class BearishIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  BearishIndicator(IndicatorDataInput input) : super(input);

  @override
  T calculate(int index) {
    if (index < 4) {
      return createResult(index: index, quote: double.nan);
    }
    int i = index - 2;
    if (entries[i].high > entries[i - 1].high &&
        entries[i].high > entries[i - 2].high &&
        entries[i].high > entries[i + 1].high &&
        entries[i].high > entries[i + 2].high) {
      return createResult(index: i, quote: entries[i].high);
    } else {
      return createResult(index: i, quote: double.nan);
    }
  }

  @override
  T getValue(int index) {
    if (index < entries.length - 1) {
      growResultsForIndex(index);

      if (results[index] == null) {
        results[index] = calculate(index + 2);
      }

      if (index > lastResultIndex) {
        lastResultIndex = index;
      }

      return results[index];
    }
    else{
      return results.last;
    }
  }
}
