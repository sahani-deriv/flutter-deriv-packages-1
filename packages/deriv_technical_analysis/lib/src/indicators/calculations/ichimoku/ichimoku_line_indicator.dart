import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';

/// An abstract class for calculating (`Highest High` + `Lowest Low`) / 2 in the given passed `period`s.
abstract class IchimokuLineIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes an [IchimokuLineIndicator].
  IchimokuLineIndicator(
    IndicatorDataInput input, {
    int period,
  })  : lowestValueIndicator =
            LowestValueIndicator<T>(LowValueIndicator<T>(input), period),
        highestValueIndicator =
            HighestValueIndicator<T>(HighValueIndicator<T>(input), period),
        super(input);

  final LowestValueIndicator<T> lowestValueIndicator;
  final HighestValueIndicator<T> highestValueIndicator;

  @override
  T calculate(int index) {
    final double lineQuote = (highestValueIndicator.getValue(index).quote +
            lowestValueIndicator.getValue(index).quote) /
        2;
    return createResult(index: index, quote: lineQuote);
  }

  @override
  void copyValuesFrom(covariant IchimokuLineIndicator<T> other) {
    super.copyValuesFrom(other);
    highestValueIndicator.copyValuesFrom(other.highestValueIndicator);
    lowestValueIndicator.copyValuesFrom(other.lowestValueIndicator);
  }

  @override
  void invalidate(int index) {
    highestValueIndicator.invalidate(index);
    lowestValueIndicator.invalidate(index);
    super.invalidate(index);
  }
}
