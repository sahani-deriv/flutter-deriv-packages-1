import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';

/// Signal indicator for Stochastic Momentum index.
class SMISignalIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  SMISignalIndicator.fromIndicator(SMIIndicator<T> smi, {this.period = 3})
      : _signal = EMAIndicator<T>(smi, period),
        super.fromIndicator(smi);

  /// The period.
  final int period;

  final EMAIndicator<T> _signal;

  @override
  T calculate(int index) => _signal.getValue(index);
}
