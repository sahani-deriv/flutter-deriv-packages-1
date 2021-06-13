import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';
import 'ema_indicator.dart';

/// Triple EMA indicator.
class TEMAIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  TEMAIndicator(Indicator<T> indicator, {int period = 10})
      : this._first(indicator, EMAIndicator<T>(indicator, period), period);

  TEMAIndicator._first(Indicator<T> indicator, EMAIndicator<T> ema, int period)
      : this._second(indicator, ema, EMAIndicator<T>(ema, period), period);

  TEMAIndicator._second(
    Indicator<T> indicator,
    EMAIndicator<T> ema,
    EMAIndicator<T> emaEma,
    this.period,
  )   : _ema = ema,
        _emaEma = emaEma,
        _emaEmaEma = EMAIndicator<T>(emaEma, period),
        super.fromIndicator(indicator);

  /// The period.
  final int period;

  final EMAIndicator<T> _ema;
  final EMAIndicator<T> _emaEma;
  final EMAIndicator<T> _emaEmaEma;

  @override
  T calculate(int index) => createResult(
        index: index,
        quote:
            3 * (_ema.getValue(index).quote - _emaEma.getValue(index).quote) +
                _emaEmaEma.getValue(index).quote,
      );

  @override
  void copyValuesFrom(covariant TEMAIndicator<T> other) {
    super.copyValuesFrom(other);

    _ema.copyValuesFrom(other._ema);
    _emaEma.copyValuesFrom(other._emaEma);
    _emaEmaEma.copyValuesFrom(other._emaEmaEma);
  }

  @override
  void invalidate(int index) {
    super.invalidate(index);

    _ema.invalidate(index);
    _emaEma.invalidate(index);
    _emaEmaEma.invalidate(index);
  }
}
