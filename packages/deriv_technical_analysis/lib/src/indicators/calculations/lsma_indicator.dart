import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';

/// Least Square Moving Average indicator
class LSMAIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  LSMAIndicator(this.indicator, this.period)
      : wma = WMAIndicator<T>(indicator, period),
        sma = SMAIndicator<T>(indicator, period),
        super.fromIndicator(indicator);

  /// Period
  final int period;

  /// Indicator
  final Indicator<T> indicator;

  /// Weighted Moving Average
  final Indicator<T> wma;

  /// Simple Moving Average
  final Indicator<T> sma;

  @override
  T calculate(int index) {
    final double result =
        3 * wma
            .getValue(index)
            .quote - 2 * sma
            .getValue(index)
            .quote;
    return createResult(
      index: index,
      quote: result,
    );
  }
}
