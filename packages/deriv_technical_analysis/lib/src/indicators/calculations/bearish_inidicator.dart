import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Bearish Indicator
class BearishIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  BearishIndicator(this.indicator) : super.fromIndicator(indicator);

  /// Indicator to calculate SMA on
  final Indicator<T> indicator;

  @override
  T calculate(int index) {
    if (index < 2 || index > indicator.entries.length - 3) {
      return createResult(index: index, quote: double.nan);
    }
    if (indicator.entries[index].high > indicator.entries[index - 1].high &&
        indicator.entries[index].high > indicator.entries[index - 2].high &&
        indicator.entries[index].high > indicator.entries[index + 1].high &&
        indicator.entries[index].high > indicator.entries[index + 2].high) {
      return createResult(index: index, quote: indicator.entries[index].high);
    } else {
      return createResult(index: index, quote: double.nan);
    }
  }
}
