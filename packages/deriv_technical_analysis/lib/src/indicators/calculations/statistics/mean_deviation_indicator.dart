import 'dart:math';

import 'package:deriv_technical_analysis/src/models/models.dart';

import '../../cached_indicator.dart';
import '../../indicator.dart';
import '../sma_indicator.dart';

/// Mean Deviation Indicator.
class MeanDeviationIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes a [MeanDeviationIndicator].
  MeanDeviationIndicator(this.indicator, this.barCount)
      : _sma = SMAIndicator<T>(indicator, barCount),
        super.fromIndicator(indicator);

  /// Indicator to calculate Mean Deviation on.
  final Indicator<T> indicator;

  /// Period.
  final int barCount;

  final SMAIndicator<T> _sma;

  @override
  T calculate(int index) {
    double absoluteDeviations = 0;

    final double average = _sma.getValue(index).quote;
    final int startIndex = max(0, index - barCount + 1);
    final int nbValues = index - startIndex + 1;

    for (int i = startIndex; i <= index; i++) {
      absoluteDeviations =
          absoluteDeviations + ((indicator.getValue(i).quote - average).abs());
    }
    return createResult(index: index, quote: absoluteDeviations / nbValues);
  }
}
