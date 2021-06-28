import 'dart:math';

import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';
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

  /// Indicator to calculate VMAA on
  final Indicator<T> indicator;

  /// Chande Momentum Oscillator indicator
  final Indicator<T> cmo;

  /// Period
  final int period;

  @override
  T calculate(int index) {

    final double a = 2 / (period + 1);
    final double b = (cmo.getValue(index).quote / 100).abs();

    if (index == 0) {
      return createResult(index: index, quote: indicator.getValue(index).quote);
    }

    final double k = 1 - pow(a * b, index - 2) / 1 - (a * b);
    final double sum = (getValue(index - 1).quote * k) +
        indicator.getValue(index).quote * pow(a * b, index);

    return createResult(index: index, quote: sum / (k + pow(a * b, index)));
    //
    // for (int i = max(0, index - period + 1); i <= index; i++) {
    //   sum += indicator.getValue(i).quote * pow(a * b, i);
    //   k += pow(a * b, i);
    // }
    // return createResult(index: index, quote: sum / k);
  }
}
