import 'package:deriv_technical_analysis/src/helpers/functions.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/dpo_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/helper_indicators/close_value_inidicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_models.dart';

void main() {
  group('Detrended Price Oscillator', () {
    List<MockTick> ticks;
    DPOIndicator<MockResult> dpoIndicator;
    setUpAll(() {
      ticks = <MockTick>[
        const MockTick(epoch: 0, quote: 22.27),
        const MockTick(epoch: 1, quote: 22.19),
        const MockTick(epoch: 2, quote: 22.08),
        const MockTick(epoch: 3, quote: 22.17),
        const MockTick(epoch: 4, quote: 22.18),
        const MockTick(epoch: 5, quote: 22.13),
        const MockTick(epoch: 6, quote: 22.23),
        const MockTick(epoch: 7, quote: 22.43),
        const MockTick(epoch: 8, quote: 22.24),
        const MockTick(epoch: 9, quote: 22.29),
        const MockTick(epoch: 10, quote: 22.15),
        const MockTick(epoch: 11, quote: 22.39),
        const MockTick(epoch: 12, quote: 22.38),
        const MockTick(epoch: 13, quote: 22.61),
        const MockTick(epoch: 14, quote: 23.36),
        const MockTick(epoch: 15, quote: 24.05),
        const MockTick(epoch: 16, quote: 23.75),
        const MockTick(epoch: 17, quote: 23.83),
        const MockTick(epoch: 18, quote: 23.95),
        const MockTick(epoch: 19, quote: 23.63),
        const MockTick(epoch: 20, quote: 23.82),
        const MockTick(epoch: 21, quote: 23.87),
        const MockTick(epoch: 22, quote: 23.65),
        const MockTick(epoch: 23, quote: 23.19),
        const MockTick(epoch: 24, quote: 23.10),
        const MockTick(epoch: 25, quote: 23.33),
        const MockTick(epoch: 26, quote: 22.68),
        const MockTick(epoch: 27, quote: 23.10),
        const MockTick(epoch: 28, quote: 22.40),
        const MockTick(epoch: 29, quote: 22.17),
        const MockTick(epoch: 30, quote: 22.27),
        const MockTick(epoch: 31, quote: 22.19),
        const MockTick(epoch: 32, quote: 22.08),
        const MockTick(epoch: 33, quote: 22.17),
        const MockTick(epoch: 34, quote: 22.18),
        const MockTick(epoch: 35, quote: 22.13),
        const MockTick(epoch: 36, quote: 22.23),
        const MockTick(epoch: 37, quote: 22.43),
        const MockTick(epoch: 38, quote: 22.24),
        const MockTick(epoch: 39, quote: 22.29),
        const MockTick(epoch: 40, quote: 22.15),
        const MockTick(epoch: 41, quote: 22.39),
        const MockTick(epoch: 42, quote: 22.38),
        const MockTick(epoch: 43, quote: 22.61),
        const MockTick(epoch: 44, quote: 23.36),
        const MockTick(epoch: 45, quote: 24.05),
        const MockTick(epoch: 46, quote: 23.75),
        const MockTick(epoch: 47, quote: 23.83),
        const MockTick(epoch: 48, quote: 23.95),
        const MockTick(epoch: 49, quote: 23.63),
        const MockTick(epoch: 50, quote: 23.82),
        const MockTick(epoch: 51, quote: 23.87),
        const MockTick(epoch: 52, quote: 23.65),
        const MockTick(epoch: 53, quote: 23.19),
        const MockTick(epoch: 54, quote: 23.10),
        const MockTick(epoch: 55, quote: 23.33),
        const MockTick(epoch: 56, quote: 22.68),
        const MockTick(epoch: 57, quote: 23.10),
        const MockTick(epoch: 58, quote: 22.40),
        const MockTick(epoch: 59, quote: 22.17),
        const MockTick(epoch: 60, quote: 22.27),
        const MockTick(epoch: 61, quote: 22.19),
        const MockTick(epoch: 62, quote: 22.08),
        const MockTick(epoch: 63, quote: 22.17),
        const MockTick(epoch: 64, quote: 22.18),
        const MockTick(epoch: 65, quote: 22.13),
        const MockTick(epoch: 66, quote: 22.23),
        const MockTick(epoch: 67, quote: 22.43),
        const MockTick(epoch: 68, quote: 22.24),
        const MockTick(epoch: 69, quote: 22.29),
        const MockTick(epoch: 70, quote: 22.15),
        const MockTick(epoch: 71, quote: 22.39),
        const MockTick(epoch: 72, quote: 22.38),
        const MockTick(epoch: 73, quote: 22.61),
        const MockTick(epoch: 74, quote: 23.36),
        const MockTick(epoch: 75, quote: 24.05),
        const MockTick(epoch: 76, quote: 23.75),
        const MockTick(epoch: 77, quote: 23.83),
        const MockTick(epoch: 78, quote: 23.95),
        const MockTick(epoch: 79, quote: 23.63),
        const MockTick(epoch: 80, quote: 23.82),
        const MockTick(epoch: 81, quote: 23.87),
        const MockTick(epoch: 82, quote: 23.65),
        const MockTick(epoch: 83, quote: 23.19),
        const MockTick(epoch: 84, quote: 23.10),
        const MockTick(epoch: 85, quote: 23.33),
        const MockTick(epoch: 86, quote: 22.68),
        const MockTick(epoch: 87, quote: 23.10),
        const MockTick(epoch: 88, quote: 22.40),
        const MockTick(epoch: 89, quote: 22.17),
      ];
      dpoIndicator = DPOIndicator<MockResult>(
          CloseValueIndicator<MockResult>(MockInput(ticks)),
          period: 9);
    });

    test('Detrended Price Oscillator should calculates the correct results',
        () {
      expect(roundDouble(dpoIndicator.getValue(9).quote, 4), 0.112);
      expect(roundDouble(dpoIndicator.getValue(10).quote, 4), -0.02);
      expect(roundDouble(dpoIndicator.getValue(11).quote, 4), 0.2114);
      expect(roundDouble(dpoIndicator.getValue(12).quote, 4), 0.17);
    });

    test(
        'Detrended Price Oscillator copyValuesFrom and refreshValueFor should works fine',
        () {
      final DPOIndicator<MockResult> dpoIndicatorWithNewData =
          DPOIndicator<MockResult>(
              CloseValueIndicator<MockResult>(MockInput(ticks)),
              period: 9);

      expect(
          roundDouble(dpoIndicatorWithNewData.getValue(89).quote, 4), -1.4733);
      ticks.add(const MockTick(epoch: 90, quote: 21.37));
      dpoIndicatorWithNewData.refreshValueFor(90);
      expect(
          roundDouble(dpoIndicatorWithNewData.getValue(90).quote, 4), -2.2267);
      dpoIndicator.copyValuesFrom(dpoIndicatorWithNewData);
      expect(roundDouble(dpoIndicator.getValue(90).quote, 4), -2.2267);
    });
  });
}
