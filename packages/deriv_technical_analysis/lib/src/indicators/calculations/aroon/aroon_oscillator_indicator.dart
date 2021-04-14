import 'package:deriv_technical_analysis/src/indicators/calculations/aroon/aroon_down_indicator.dart';

import '../../../../deriv_technical_analysis.dart';
import 'aroon_up_indicator.dart';

/// Calculates the value for Aroon Oscillator Indicator.
class AroonOscillatorIndicator<T extends IndicatorResult>
    extends CachedIndicator<T> {
  /// Initializes
  AroonOscillatorIndicator.fromIndicator(IndicatorDataInput indicatorDataInput,
      {int period = 14})
      : _upChannel = AroonUpIndicator<T>.fromIndicator(
            LowValueIndicator<T>(indicatorDataInput),
            period: period),
        _downChannel = AroonDownIndicator<T>.fromIndicator(
          HighValueIndicator<T>(indicatorDataInput),
          period: period,
        ),
        super(indicatorDataInput);

  /// Aroon up channel indicator.
  final AroonUpIndicator<T> _upChannel;

  /// Aroon down channel indicator.
  final AroonDownIndicator<T> _downChannel;

  @override
  T calculate(int index) => createResult(
      index: index,
      quote: _upChannel.getValue(index).quote -
          _downChannel.getValue(index).quote);

  @override
  void copyValuesFrom(covariant AroonOscillatorIndicator<T> other) {
    super.copyValuesFrom(other);
    _downChannel.copyValuesFrom(other._downChannel);
    _upChannel.copyValuesFrom(other._upChannel);
  }

  @override
  void invalidate(int index) {
    super.invalidate(index);
    _downChannel.invalidate(index);
    _upChannel.invalidate(index);
  }

  @override
  T refreshValueFor(int index) {
    super.refreshValueFor(index);
    _downChannel.getValue(index);
    _upChannel.getValue(index);
  }
}
