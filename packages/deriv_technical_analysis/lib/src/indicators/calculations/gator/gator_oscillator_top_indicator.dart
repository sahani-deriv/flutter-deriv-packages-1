import 'dart:math';

import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/mma_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/indicator.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Gator Oscillator Indicator Top bar
class GatorOscillatorIndicatorTopBar<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes
  GatorOscillatorIndicatorTopBar(Indicator<T> indicator,
      {MMAIndicator<T> jawIndicator,
      int jawPeriod = 13,
      this.jawOffset = 8,
      MMAIndicator<T> teethIndicator,
      int teethPeriod = 8,
      this.teethOffset = 5})
      : _jawIndicator = jawIndicator ?? MMAIndicator<T>(indicator, jawPeriod),
        _teethIndicator =
            teethIndicator ?? MMAIndicator<T>(indicator, teethPeriod),
        super.fromIndicator(indicator);

  /// Jaw (lower smoothed moving average) indicator
  final MMAIndicator<T> _jawIndicator;

  /// Offset of jaw
  final int jawOffset;

  /// Offset of teeth
  final int teethOffset;

  /// Teeth (upper smoothed moving average) indicator
  final MMAIndicator<T> _teethIndicator;

  @override
  T calculate(int index) {
    final int maxOffset = max(jawOffset, teethOffset);

    if (index < maxOffset) {
      return createResult(index: index, quote: double.nan);
    }

    final T jawIndicator = _jawIndicator.getValue(index - jawOffset);
    final T teethIndicator = _teethIndicator.getValue(index - teethOffset);

    // GatorTopBar = Absolute value of(Jaw - Teeth)
    final double quote = (jawIndicator.quote - teethIndicator.quote).abs();

    return createResult(index: index, quote: quote);
  }
}
