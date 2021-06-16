import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/helper_indicators/difference_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/helper_indicators/median_indicator.dart';

/// Stochastic Momentum Index indicator
///
/// C = (High MAX + Low MIN) / 2
/// H = CLOSE – C
///
/// HS1 = EMA(H, 3)
/// HS2 = EMA(HS1, 3)
///
/// DHL1 = EMA(High MAX – Low MIN, 3)
/// DHL2 = EMA(High MAX – Low MIN, 3)
///
/// SMI = (HS2 / DHL2) * 100
class SMIIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  SMIIndicator(
    IndicatorDataInput input, {
    int period = 10,
    int smoothingPeriod = 3,
    int doubleSmoothingPeriod = 3,
  }) : this._(
          input,
          EMAIndicator<T>(
            DifferenceIndicator<T>(
              CloseValueIndicator<T>(input),
              MedianIndicator<T>(
                HighestValueIndicator<T>(HighValueIndicator<T>(input), period),
                LowestValueIndicator<T>(LowValueIndicator<T>(input), period),
              ),
            ),
            smoothingPeriod,
          ),
          period: period,
          smoothingPeriod: smoothingPeriod,
          doubleSmoothingPeriod: doubleSmoothingPeriod,
        );

  SMIIndicator._(
    IndicatorDataInput input,
    EMAIndicator<T> hs1, {
    this.period,
    this.smoothingPeriod,
    this.doubleSmoothingPeriod,
  })  : _hs2 = EMAIndicator<T>(hs1, doubleSmoothingPeriod),
        _dhl1 = EMAIndicator<T>(
          DifferenceIndicator<T>(
            HighestValueIndicator<T>(HighValueIndicator<T>(input), period),
            LowestValueIndicator<T>(LowValueIndicator<T>(input), period),
          ),
          period,
        ),
        super(input);

  /// The SMI period.
  final int period;

  /// Smoothing period
  final int smoothingPeriod;

  /// Double Smoothing period
  final int doubleSmoothingPeriod;

  final EMAIndicator<T> _hs2;
  final EMAIndicator<T> _dhl1;

  @override
  T calculate(int index) {
    final double _dhl2 = _dhl1.getValue(index).quote / 2;
    return createResult(
      index: index,
      quote: (_hs2.getValue(index).quote / _dhl2) * 100,
    );
  }
}
