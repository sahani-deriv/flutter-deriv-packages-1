import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';
import 'sma_indicator.dart';

///Awesome Oscillator Indicator
class AwesomeOscillatorIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {

  /// Initializes
  AwesomeOscillatorIndicator(this.indicator)
      : _smaIndicatorOne = SMAIndicator<T>(indicator, 34),
        _smaIndicatorTwo = SMAIndicator<T>(indicator, 5),
        super.fromIndicator(indicator);

  /// Indicator to calculate AwesomeOscillatorIndicator
  final Indicator<T> indicator;
  ///34-period simple moving average
  final SMAIndicator<T> _smaIndicatorOne;
  ///5-period simple moving average
  final SMAIndicator<T> _smaIndicatorTwo;

  @override
  T calculate(int index) {
    final IndicatorResult _smaValueOne = _smaIndicatorOne.getValue(index);
    final IndicatorResult _smaValueTwo = _smaIndicatorTwo.getValue(index);

    ///AO = SMA(MEDIAN PRICE, 5)-SMA(MEDIAN PRICE, 34)
    final double _quote = _smaValueTwo.quote - _smaValueOne.quote;

    return createResult(index: index, quote: _quote);
  }
}
