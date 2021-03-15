import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Bullish Indicator
class BullishIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  BullishIndicator(this.indicator) : super.fromIndicator(indicator);

  /// Indicator to calculate SMA on
  final Indicator<T> indicator;

  @override
  T calculate(int index) {
    if (index < 2 || index > indicator.entries.length - 3) {
      return createResult(index: index, quote: double.nan);
    }
    if (indicator.entries[index].low < indicator.entries[index - 1].low &&
        indicator.entries[index].low < indicator.entries[index - 2].low &&
        indicator.entries[index].low < indicator.entries[index + 1].low &&
        indicator.entries[index].low < indicator.entries[index + 2].low) {
      return createResult(index: index, quote: indicator.entries[index].low);
    } else {
      return createResult(index: index, quote: double.nan);
    }
  }
}
