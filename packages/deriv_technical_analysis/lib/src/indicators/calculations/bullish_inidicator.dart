import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Bullish Indicator
class BullishIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  BullishIndicator(IndicatorDataInput input) : super(input);

  @override
  T calculate(int index) {
    if (index < 2 || index > entries.length - 3) {
      return createResult(index: index, quote: double.nan);
    }
    if (entries[index].low < entries[index - 1].low &&
        entries[index].low < entries[index - 2].low &&
        entries[index].low < entries[index + 1].low &&
        entries[index].low < entries[index + 2].low) {
      return createResult(index: index, quote: entries[index].low);
    } else {
      return createResult(index: index, quote: double.nan);
    }
  }
}
