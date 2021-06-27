import 'dart:math';

import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/cmo_indicator.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

import '../cached_indicator.dart';
import '../indicator.dart';

/// Variable Moving Average Indicator
class VMAIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  VMAIndicator(this.indicator, this.period)
      : pdmS = PdmS<T>(indicator, 1 / period),
        mdmS = MdmS<T>(indicator, 1 / period),
        pdiS = PdiS<T>(indicator, 1 / period),
        mdiS = MdiS<T>(indicator, 1 / period),
        iS = IS<T>(indicator, 1 / period)..calculateValues(),
        super.fromIndicator(indicator);

  /// Indicator to calculate SMA on
  final Indicator<T> indicator;

  ///
  final CachedIndicator<T> pdmS;

  ///
  final CachedIndicator<T> mdmS;

  ///
  final CachedIndicator<T> pdiS;

  ///
  final CachedIndicator<T> mdiS;

  ///
  final CachedIndicator<T> iS;

  /// Chande Momentum Oscillator indicator
  // final Indicator<T> cmo;

  /// Period
  final int period;

  @override
  T calculate(int index) {
    if(index<1){
      return createResult(
          index: index,
          quote:0);
          }
    final double hhv =
        HighestValueIndicator<T>(iS, period).getValue(index).quote;
    final double llv =
        LowestValueIndicator<T>(iS, period).getValue(index).quote;

    return createResult(
        index: index,
        quote: ((1 - (1 / period)) *
                    (iS.getValue(index).quote - llv) /
                    (hhv - llv)) *
                (index < 1 ? 0 : getValue(index - 1).quote) +
            indicator.getValue(index).quote *
                (1 / period) *
                (iS.getValue(index).quote - llv) /
                (hhv - llv));

    //
    // if (index <= 1) {
    //   return createResult(index: index, quote: indicator.getValue(index).quote);
    // }
    // // final int realBarCount = min(period, index + 1);
    // final double factor = 2 / (period + 1);
    // final double result =
    //     (factor * cmo.getValue(index).quote * indicator.getValue(index).quote) +
    //         ((1 - factor * cmo.getValue(index).quote) * getValue(1).quote);
    //
    // return createResult(index: index, quote: result);
  }
}

/// Variable Moving Average Indicator
class PdmS<T extends IndicatorResult> extends CachedIndicator<T> {
  ///
  PdmS(this.indicator, this.period) : super.fromIndicator(indicator);

  /// Period
  final double period;

  /// Indicator to calculate
  final Indicator<T> indicator;

  @override
  T calculate(int index) {
    print(index);
    if(index<1){
      print("Aaaa");
      return createResult(
          index: index,
          quote:0);
    }
    final double pdm = index < 1
        ? 0
        : max(
            indicator.getValue(index).quote -
                indicator.getValue(index - 1).quote,
            0);
    return createResult(
        index: index,
        quote: (1 - period) *
            ((index < 1 ? 0 : getValue(index - 1).quote) +
                period * (pdm.isNaN ? 0 : pdm)));
  }
}

/// Variable Moving Average Indicator
class MdmS<T extends IndicatorResult> extends CachedIndicator<T> {
  ///
  MdmS(this.indicator, this.period) : super.fromIndicator(indicator);

  /// Period
  final double period;

  /// Indicator to calculate
  final Indicator<T> indicator;

  @override
  T calculate(int index) {
    if(index<1){
      return createResult(
          index: index,
          quote:0);
    }
    final double mdm = index < 1
        ? 0
        : max(
            indicator.getValue(index - 1).quote -
                indicator.getValue(index).quote,
            0);
    return createResult(
        index: index,
        quote: (1 - period) * (index < 1 ? 0 : getValue(index - 1)) +
            period * (mdm.isNaN ? 0 : mdm));
  }
}

/// Variable Moving Average Indicator
class PdiS<T extends IndicatorResult> extends CachedIndicator<T> {
  ///
  PdiS(Indicator<T> indicator, this.period)
      : mdmS = MdmS<T>(indicator, period)..calculateValues(),
        pdmS = PdmS<T>(indicator, period)..calculateValues(),
        super.fromIndicator(indicator);

  /// Period
  final double period;

  /// Indicator to calculate
  final Indicator<T> pdmS;

  ///
  final Indicator<T> mdmS;

  @override
  T calculate(int index) {
    if(index<1){
      return createResult(
          index: index,
          quote:0);
    }
    final double pdi = index < 1
        ? 0
        : pdmS.getValue(index).quote /
            (pdmS.getValue(index).quote + mdmS.getValue(index).quote);
    createResult(
        index: index,
        quote: (1 - period) * (index < 1 ? 0 : getValue(index - 1).quote) +
            period * (pdi.isNaN ? 0 : pdi));
  }
}

/// Variable Moving Average Indicator
class MdiS<T extends IndicatorResult> extends CachedIndicator<T> {
  ///
  MdiS(Indicator<T> indicator, this.period)
      : mdmS = MdmS<T>(indicator, period)..calculateValues(),
        pdmS = PdmS<T>(indicator, period)..calculateValues(),
        super.fromIndicator(indicator);

  /// Period
  final double period;

  /// Indicator to calculate
  final Indicator<T> pdmS;

  ///
  final Indicator<T> mdmS;

  @override
  T calculate(int index) {
    if(index<1){
      return createResult(
          index: index,
          quote:0);
    }
    final double mdi = index < 1
        ? 0
        : mdmS.getValue(index).quote /
            (pdmS.getValue(index).quote + mdmS.getValue(index).quote);
    createResult(
        index: index,
        quote: (1 - period) * (index < 1 ? 0 : getValue(index - 1).quote) +
            period * (mdi.isNaN ? 0 : mdi));
  }
}

/// Variable Moving Average Indicator
class IS<T extends IndicatorResult> extends CachedIndicator<T> {
  ///
  IS(Indicator<T> indicator, this.period)
      : mdiS = MdiS<T>(indicator, period),
        pdiS = PdiS<T>(indicator, period),
        super.fromIndicator(indicator);

  /// Period
  final double period;

  /// Indicator to calculate

  final Indicator<T> pdiS;

  ///
  final Indicator<T> mdiS;

  @override
  T calculate(int index) {
    if(index<1){
      return createResult(
          index: index,
          quote:0);
    }
    return createResult(
      index: index,
      quote: (1 - period) * (index < 1 ? 0 : getValue(index - 1)) +
          period *
              (pdiS.getValue(index).quote - mdiS.getValue(index).quote).abs() /
              (pdiS.getValue(index).quote + mdiS.getValue(index).quote));
  }
}
