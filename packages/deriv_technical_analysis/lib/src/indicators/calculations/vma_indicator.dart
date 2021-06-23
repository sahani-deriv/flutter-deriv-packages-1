import 'dart:math';

import 'package:deriv_technical_analysis/src/indicators/calculations/cmo_indicator.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';

/// Variable Moving Average Indicator
class VMAIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  VMAIndicator(this.indicator, this.period)
      : cmo = CMOIndicator<T>(indicator, period),
        super.fromIndicator(indicator);

  /// Indicator to calculate SMA on
  final Indicator<T> indicator;
  final Indicator<T> cmo;

  /// Period
  final int period;

  @override
  T calculate(int index) {
    final int realBarCount = min(period, index + 1);
    double value = 0;
    if (index > 0) {
      value = getValue(index - 1).quote;
    }
    final double result = 2 /
            (1 + realBarCount) *
            indicator.getValue(index).quote *
            (indicator.getValue(index).quote - value) +
        getValue(index - 1).quote;
    return createResult(index: index, quote: result);
  }
}
