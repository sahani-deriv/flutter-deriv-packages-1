import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';
import 'helper_indicators/close_value_inidicator.dart';
import 'helper_indicators/high_value_indicator.dart';
import 'helper_indicators/low_value_indicator.dart';
import 'highest_value_indicator.dart';
import 'lowest_value_indicator.dart';

/// WilliamsRIndicator
class WilliamsRIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes WilliamsR indicator
  WilliamsRIndicator(
    IndicatorDataInput input,
    int period, {
    double multiplier = -100,
  }) : this._(
          CloseValueIndicator<T>(input),
          period,
          HighValueIndicator<T>(input),
          LowValueIndicator<T>(input),
          multiplier,
        );

  WilliamsRIndicator._(
    this._closePriceIndicator,
    this.period,
    HighValueIndicator<T> highPriceIndicator,
    LowValueIndicator<T> lowPriceIndicator,
    this.multiplier,
  )   : _highestHigh = HighestValueIndicator<T>(highPriceIndicator, period),
        _lowestLow = LowestValueIndicator<T>(lowPriceIndicator, period),
        super.fromIndicator(_closePriceIndicator);

  /// Period.
  final int period;

  /// Multiplier, usually is -100.
  final double multiplier;

  final Indicator<T> _closePriceIndicator;
  final HighestValueIndicator<T> _highestHigh;
  final LowestValueIndicator<T> _lowestLow;

  @override
  T calculate(int index) {
    final double highestHighPrice = _highestHigh.getValue(index).quote;
    final double lowestLowPrice = _lowestLow.getValue(index).quote;

    return createResult(
      index: index,
      quote: ((highestHighPrice - _closePriceIndicator.getValue(index).quote) /
              (highestHighPrice - lowestLowPrice)) *
          multiplier,
    );
  }
}
