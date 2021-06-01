import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';

/// %K also known as the Fast Stochastic Indicator.
/// A stochastic oscillator is a popular technical indicator for generating overbought and oversold signals.
class FastStochasticIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes a Fast Stochastic Indicator.
  FastStochasticIndicator(
    IndicatorDataInput input, {
    Indicator<T> indicator,
    int period = 14,
  })  : _indicator = indicator ?? CloseValueIndicator<T>(input),
        _highestValueIndicator =
            HighestValueIndicator<T>(HighValueIndicator<T>(input), period),
        _lowestValueIndicator =
            LowestValueIndicator<T>(LowValueIndicator<T>(input), period),
        super(input);

  final HighestValueIndicator<T> _highestValueIndicator;
  final LowestValueIndicator<T> _lowestValueIndicator;
  final Indicator<T> _indicator;

  @override
  T calculate(int index) {
    final double highestHighQuote =
        _highestValueIndicator.getValue(index).quote;
    final double lowestLowQuote = _lowestValueIndicator.getValue(index).quote;

    final double kPercent =
        ((_indicator.getValue(index).quote - lowestLowQuote) /
                (highestHighQuote - lowestLowQuote)) *
            100;

    return createResult(index: index, quote: kPercent);
  }

  @override
  void copyValuesFrom(covariant FastStochasticIndicator<T> other) {
    super.copyValuesFrom(other);
    _highestValueIndicator.copyValuesFrom(other._highestValueIndicator);
    _lowestValueIndicator.copyValuesFrom(other._lowestValueIndicator);
  }

  @override
  void invalidate(int index) {
    _highestValueIndicator.invalidate(index);
    _lowestValueIndicator.invalidate(index);
    super.invalidate(index);
  }
}
