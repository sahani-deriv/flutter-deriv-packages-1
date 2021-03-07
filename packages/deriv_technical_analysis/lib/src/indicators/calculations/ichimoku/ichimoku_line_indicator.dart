import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';

/// An abstract class for calculating (`Highest High` + `Lowest Low`) / 2 in the given passed `period`s.
abstract class IchimokuLineIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes an [IchimokuLineIndicator].
  IchimokuLineIndicator(
    IndicatorDataInput input, {
    int period,
  })  : _lowestValueIndicator =
            LowestValueIndicator<T>(LowValueIndicator<T>(input), period),
        _highestValueIndicator =
            HighestValueIndicator<T>(HighValueIndicator<T>(input), period),
        super(input);

  @override
  T calculate(int index) {
    final double lineQuote = (_highestValueIndicator.getValue(index).quote +
            _lowestValueIndicator.getValue(index).quote) /
        2;
    return createResult(index: index, quote: lineQuote);
  }

  final LowestValueIndicator<T> _lowestValueIndicator;

  final HighestValueIndicator<T> _highestValueIndicator;
}
