import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';
import 'sma_indicator.dart';

///Awesome Oscillator Indicator
class AwesomeOscillatorIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes
  AwesomeOscillatorIndicator(Indicator<T> indicator,
      {int smaPeriodOne = 5, int smaPeriodTwo = 34})
      : _smaIndicatorOne = SMAIndicator<T>(indicator, smaPeriodOne),
        _smaIndicatorTwo = SMAIndicator<T>(indicator, smaPeriodTwo),
        super.fromIndicator(indicator);

  ///34-period simple moving average
  final SMAIndicator<T> _smaIndicatorOne;

  ///5-period simple moving average
  final SMAIndicator<T> _smaIndicatorTwo;

  @override
  T calculate(int index) {
    final IndicatorResult _smaValueOne = _smaIndicatorOne.getValue(index);
    final IndicatorResult _smaValueTwo = _smaIndicatorTwo.getValue(index);

    ///AO = SMA(MEDIAN PRICE, 5)-SMA(MEDIAN PRICE, 34)
    final double _quote = _smaValueOne.quote - _smaValueTwo.quote;

    return createResult(index: index, quote: _quote);
  }
}