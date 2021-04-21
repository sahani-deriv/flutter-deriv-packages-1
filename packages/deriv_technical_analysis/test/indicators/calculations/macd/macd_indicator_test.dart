import 'package:deriv_technical_analysis/src/helpers/functions.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/helper_indicators/close_value_inidicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/macd/macd_histogram_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/macd/macd_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/macd/signal_macd_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_models.dart';

void main() {
  List<MockTick> ticks;
  CloseValueIndicator<MockResult> closeValueIndicator;

  MACDIndicator<MockResult> macdIndicator;

  SignalMACDIndicator<MockResult> signalMACDIndicator;

  setUpAll(() {
    ticks = <MockTick>[
      MockTick(epoch: 00, quote: 82.201),
      MockTick(epoch: 02, quote: 82.200),
      MockTick(epoch: 03, quote: 82.200),
      MockTick(epoch: 04, quote: 82.200),
      MockTick(epoch: 05, quote: 82.200),
      MockTick(epoch: 06, quote: 82.201),
      MockTick(epoch: 07, quote: 82.198),
      MockTick(epoch: 08, quote: 82.198),
      MockTick(epoch: 09, quote: 82.199),
      MockTick(epoch: 10, quote: 82.199),
      MockTick(epoch: 11, quote: 82.199),
      MockTick(epoch: 12, quote: 82.198),
      MockTick(epoch: 13, quote: 82.196),
      MockTick(epoch: 14, quote: 82.197),
      MockTick(epoch: 15, quote: 82.194),
      MockTick(epoch: 16, quote: 82.195),
      MockTick(epoch: 17, quote: 82.194),
      MockTick(epoch: 18, quote: 82.194),
      MockTick(epoch: 19, quote: 82.194),
      MockTick(epoch: 20, quote: 82.195),
      MockTick(epoch: 21, quote: 82.195),
      MockTick(epoch: 22, quote: 82.195),
      MockTick(epoch: 23, quote: 82.194),
      MockTick(epoch: 24, quote: 82.194),
      MockTick(epoch: 25, quote: 82.192),
      MockTick(epoch: 26, quote: 82.192),
      MockTick(epoch: 27, quote: 82.192),
      MockTick(epoch: 28, quote: 82.191),
      MockTick(epoch: 29, quote: 82.188),
      MockTick(epoch: 30, quote: 82.189),
      MockTick(epoch: 31, quote: 82.192),
      MockTick(epoch: 32, quote: 82.192),
      MockTick(epoch: 33, quote: 82.193),
      MockTick(epoch: 34, quote: 82.193),
      MockTick(epoch: 35, quote: 82.192),
      MockTick(epoch: 36, quote: 82.193),
      MockTick(epoch: 37, quote: 82.193),
      MockTick(epoch: 38, quote: 82.192),
      MockTick(epoch: 39, quote: 82.192),
    ];

    closeValueIndicator = CloseValueIndicator<MockResult>(MockInput(ticks));

    macdIndicator =
        MACDIndicator<MockResult>.fromIndicator(closeValueIndicator);

    signalMACDIndicator =
        SignalMACDIndicator<MockResult>.fromIndicator(macdIndicator);
  });

  group(' Moving Average Convergance Divergence Indicator tests', () {
    test(
        ' Moving Average Convergance Divergence Indicator should calculate the correct result from the given closed value indicator ticks.',
        () {
      expect(roundDouble(macdIndicator.getValue(36).quote, 4), -0.0012);
      expect(roundDouble(macdIndicator.getValue(37).quote, 4), -0.0011);
      expect(roundDouble(macdIndicator.getValue(38).quote, 4), -0.0011);
    });

    test(
        'Signal Moving Average Convergance Divergence Indicator should calculate the correct result from the given closed value indicator ticks.',
        () {
      expect(roundDouble(signalMACDIndicator.getValue(36).quote, 4), -0.0016);
      expect(roundDouble(signalMACDIndicator.getValue(37).quote, 4), -0.0015);
      expect(roundDouble(signalMACDIndicator.getValue(38).quote, 4), -0.0014);
    });
    test(
        ' Moving Average Convergance Divergence Indicator copyValuesFrom and refreshValueFor should works fine',
        () {
      final MACDIndicator<MockResult> macdIndicatorWithNewData =
          MACDIndicator<MockResult>.fromIndicator(closeValueIndicator);

      expect(
          roundDouble(macdIndicatorWithNewData.getValue(36).quote, 4), -0.0012);
      ticks.add(const MockTick(epoch: 40, quote: 82.152));

      macdIndicatorWithNewData.refreshValueFor(39);

      expect(
          roundDouble(macdIndicatorWithNewData.getValue(39).quote, 4), -0.0042);

      macdIndicator.copyValuesFrom(macdIndicatorWithNewData);
      expect(roundDouble(macdIndicator.getValue(39).quote, 4), -0.0042);
    });

    test(
        'Signal Moving Average Convergance Divergence Indicator copyValuesFrom and refreshValueFor should work fine.',
        () {
      final SignalMACDIndicator<MockResult> signalMACDIndicatorrWithNewData =
          SignalMACDIndicator<MockResult>.fromIndicator(macdIndicator);

      expect(roundDouble(signalMACDIndicatorrWithNewData.getValue(38).quote, 4),
          -0.0014);
      ticks.add(const MockTick(epoch: 40, quote: 82.152));

      signalMACDIndicatorrWithNewData.refreshValueFor(39);

      expect(roundDouble(signalMACDIndicatorrWithNewData.getValue(39).quote, 4),
          -0.002);

      signalMACDIndicator.copyValuesFrom(signalMACDIndicatorrWithNewData);
      expect(roundDouble(signalMACDIndicator.getValue(39).quote, 4), -0.002);
    });

    test(
        'Signal Moving Average Convergance Divergence Histogram Indicator shoud calculate the correct result from the given closed value indicator ticks.',
        () {
      final MACDHistogramIndicator<MockResult> macdHistogramIndicator =
          MACDHistogramIndicator<MockResult>.fromIndicator(
              macdIndicator, signalMACDIndicator);

      expect(roundDouble(macdHistogramIndicator.getValue(36).quote, 4), 0.0004);
      expect(roundDouble(macdHistogramIndicator.getValue(37).quote, 4), 0.0004);
      expect(roundDouble(macdHistogramIndicator.getValue(38).quote, 4), 0.0003);
    });
  });
}
