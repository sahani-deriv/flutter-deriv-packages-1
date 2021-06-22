import 'dart:math';

import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';

/// Welles Wilder Moving Average Indicator
class WWSMAIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  WWSMAIndicator(this.indicator, this.period) : super.fromIndicator(indicator);

  /// Indicator to calculate SMA on
  final Indicator<T> indicator;

  /// Period
  final int period;

  @override
  T calculate(int index) {
    final int realPeriod = min(period, index + 1);
    final double result = index == 0
        ? indicator.getValue(index).quote / realPeriod
        : getValue(index - 1).quote +
            (indicator.getValue(index).quote - getValue(index - 1).quote) /
                realPeriod;
    return createResult(index: index, quote: result / realPeriod);
  }
}
