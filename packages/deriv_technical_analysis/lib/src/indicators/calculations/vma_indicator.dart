import 'dart:math';

import 'package:deriv_technical_analysis/src/indicators/calculations/cmo_indicator.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';

/// Variable Moving Average Indicator
class VMAIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  VMAIndicator(this.indicator, this.period)
      : cmo = CMOIndicator<T>(indicator, 9),
        super.fromIndicator(indicator);

  /// Indicator to calculate SMA on
  final Indicator<T> indicator;
  /// Chande Momentum Oscillator indicator
  final Indicator<T> cmo;

  /// Period
  final int period;

  @override
  T calculate(int index) {
    if (index < 1) {
      return createResult(index: index, quote: indicator.getValue(index).quote);
    }
    final int realBarCount = min(period, index + 1);
    final double factor = 2 / (realBarCount + 1);
    final double result =
        (factor * cmo.getValue(index).quote * indicator.getValue(index).quote) +
            ((1 - factor * cmo.getValue(index).quote) * getValue(1).quote);

    return createResult(index: index, quote: result);
  }
}
