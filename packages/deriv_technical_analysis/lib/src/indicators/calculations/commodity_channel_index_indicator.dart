import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import 'helper_indicators/hlc3_indicator.dart';
import 'sma_indicator.dart';
import 'statistics/mean_deviation_indicator.dart';

/// Commodity Channel Index Indicator.
class CommodityChannelIndexIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes
  CommodityChannelIndexIndicator(
    IndicatorDataInput input,
    this.period, {
    this.factor = 0.015,
  })  : _typicalPriceIndicator = HLC3Indicator<T>(input),
        super(input) {
    _smaIndicator = SMAIndicator<T>(_typicalPriceIndicator, period);
    _meanDeviationIndicator =
        MeanDeviationIndicator<T>(_typicalPriceIndicator, period);
  }

  /// Factor. Usually is `0.015`.
  final double factor;

  /// Period.
  final int period;

  final HLC3Indicator<T> _typicalPriceIndicator;

  SMAIndicator<T> _smaIndicator;
  MeanDeviationIndicator<T> _meanDeviationIndicator;

  @override
  T calculate(int index) {
    final double typicalPrice = _typicalPriceIndicator.getValue(index).quote;
    final double typicalPriceAvg = _smaIndicator.getValue(index).quote;
    final double meanDeviation = _meanDeviationIndicator.getValue(index).quote;

    if (meanDeviation == 0) {
      return createResult(index: index, quote: 0);
    }

    return createResult(
      index: index,
      quote: (typicalPrice - typicalPriceAvg) / (meanDeviation * factor),
    );
  }

  @override
  void copyValuesFrom(covariant CommodityChannelIndexIndicator<T> other) {
    super.copyValuesFrom(other);

    _smaIndicator.copyValuesFrom(other._smaIndicator);
    _meanDeviationIndicator.copyValuesFrom(other._meanDeviationIndicator);
  }

  @override
  T refreshValueFor(int index) {
    _smaIndicator.refreshValueFor(index);
    _meanDeviationIndicator.refreshValueFor(index);
    return super.refreshValueFor(index);
  }

  @override
  void invalidate(int index) {
    super.invalidate(index);

    _smaIndicator.invalidate(index);
    _meanDeviationIndicator.invalidate(index);
  }
}
