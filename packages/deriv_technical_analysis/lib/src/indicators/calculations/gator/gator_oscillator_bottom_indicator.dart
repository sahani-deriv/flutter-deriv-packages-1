import 'dart:math';

import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/mma_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/indicator.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Gator Oscillator Indicator Bottom bar
class GatorOscillatorIndicatorBottomBar<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes
  GatorOscillatorIndicatorBottomBar(Indicator<T> indicator,
      {MMAIndicator<T> lipsIndicator,
      int lipsPeriod = 5,
      this.lipsOffset = 3,
      MMAIndicator<T> teethIndicator,
      int teethPeriod = 8,
      this.teethOffset = 5})
      : _lipsIndicator =
            lipsIndicator ?? MMAIndicator<T>(indicator, lipsPeriod),
        _teethIndicator =
            teethIndicator ?? MMAIndicator<T>(indicator, teethPeriod),
        super.fromIndicator(indicator);

  /// Offset of lips
  final int lipsOffset;

  /// Offset of teeth
  final int teethOffset;

  /// Lips (middle smoothed moving average) indicator
  final MMAIndicator<T> _lipsIndicator;

  /// Teeth (upper smoothed moving average) indicator
  final MMAIndicator<T> _teethIndicator;

  @override
  T calculate(int index) {
    final int maxOffset = max(lipsOffset, teethOffset);

    if (index < maxOffset) {
      return createResult(index: index, quote: double.nan);
    }

    final T lipsIndicator = _lipsIndicator.getValue(index - lipsOffset);
    final T teethIndicator = _teethIndicator.getValue(index - teethOffset);

    // GatorBottomBar = – (Absolute value of (Teeth – Lips))
    final double quote = -(teethIndicator.quote - lipsIndicator.quote).abs();

    return createResult(index: index, quote: quote);
  }
}
