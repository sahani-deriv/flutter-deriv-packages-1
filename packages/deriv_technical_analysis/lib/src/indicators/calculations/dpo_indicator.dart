import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';

/// Detrended Price Oscillator Indicator
class DPOIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  DPOIndicator(this.indicator, CachedIndicator<T> maIndicator,
      {int period = 14})
      : _maIndicator = maIndicator,
        _timeShift = (period ~/ 2) + 1,
        super.fromIndicator(indicator);

  /// Indicator to calculate the MA on
  final Indicator<T> indicator;

  /// Moving Average Indicator
  final CachedIndicator<T> _maIndicator;

  /// time shift of sma
  final int _timeShift;

  @override
  T calculate(int index) => createResult(
      index: index,
      quote: indicator.getValue(index).quote -
          _maIndicator.getValue(index - _timeShift).quote);

  @override
  void copyValuesFrom(covariant DPOIndicator<T> other) {
    super.copyValuesFrom(other);
    _maIndicator.copyValuesFrom(other._maIndicator);
  }

  @override
  void invalidate(int index) {
    _maIndicator.invalidate(index);
    super.invalidate(index);
  }
}
