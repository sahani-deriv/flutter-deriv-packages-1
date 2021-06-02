import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

import '../../cached_indicator.dart';

/// A stochastic oscillator is a popular technical indicator for generating overbought and oversold signals.
class FastPercentDStochasticIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes a Fast Stochastic Indicator.
  FastPercentDStochasticIndicator(
    FastPercentKStochasticIndicator<T> fastPercentKStochasticIndicator, {
    int period = 2,
  })  : _smaIndicator =
            EMAIndicator<T>(fastPercentKStochasticIndicator, period),
        super.fromIndicator(fastPercentKStochasticIndicator);

  final EMAIndicator<T> _smaIndicator;

  @override
  T calculate(int index) =>
      createResult(index: index, quote: _smaIndicator.getValue(index).quote);

  @override
  void copyValuesFrom(covariant FastPercentDStochasticIndicator<T> other) {
    super.copyValuesFrom(other);
    _smaIndicator.copyValuesFrom(other._smaIndicator);
  }

  @override
  void invalidate(int index) {
    _smaIndicator.invalidate(index);
    super.invalidate(index);
  }
}
