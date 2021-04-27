import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Bearish Indicator
class BearishIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  BearishIndicator(IndicatorDataInput input) : super(input);

  @override
  T calculate(int index) {
    if (index < 2 || index > entries.length - 3) {
      return createResult(index: index, quote: double.nan);
    }
    if (entries[index].high > entries[index - 1].high &&
        entries[index].high > entries[index - 2].high &&
        entries[index].high > entries[index + 1].high &&
        entries[index].high > entries[index + 2].high) {
      return createResult(index: index, quote: entries[index].high);
    } else {
      return createResult(index: index, quote: double.nan);
    }
  }
}
