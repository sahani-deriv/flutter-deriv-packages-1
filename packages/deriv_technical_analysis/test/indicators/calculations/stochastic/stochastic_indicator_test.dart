import 'package:deriv_technical_analysis/src/helpers/functions.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/stochastic/fast_stochastic_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/stochastic/slow_stochastic_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_models.dart';

void main() {
  List<MockTick> ticks;

  setUpAll(() {
    ticks = <MockTick>[
      const MockOHLC(01, 127.01, 127.01, 127.01, 125.36),
      const MockOHLC(02, 127.62, 127.62, 127.62, 126.16),
      const MockOHLC(03, 126.59, 126.59, 126.59, 124.93),
      const MockOHLC(04, 127.35, 127.35, 127.35, 126.09),
      const MockOHLC(05, 128.17, 128.17, 128.17, 126.82),
      const MockOHLC(06, 128.43, 128.43, 128.43, 126.48),
      const MockOHLC(07, 127.37, 127.37, 127.37, 126.03),
      const MockOHLC(08, 126.42, 126.42, 126.42, 124.83),
      const MockOHLC(09, 126.90, 126.90, 126.90, 126.39),
      const MockOHLC(10, 126.85, 126.85, 126.85, 125.72),
      const MockOHLC(11, 125.65, 125.65, 125.65, 124.56),
      const MockOHLC(12, 125.72, 125.72, 125.72, 124.57),
      const MockOHLC(13, 127.16, 127.16, 127.16, 125.07),
      const MockOHLC(14, 127.29, 127.29, 127.72, 126.86),
      const MockOHLC(15, 127.18, 127.18, 127.69, 126.63),
      const MockOHLC(16, 128.01, 128.01, 128.22, 126.80),
      const MockOHLC(17, 127.11, 127.11, 128.27, 126.71),
      const MockOHLC(18, 127.73, 127.73, 128.09, 126.80),
      const MockOHLC(19, 127.06, 127.06, 128.27, 126.13),
      const MockOHLC(20, 127.33, 127.33, 127.74, 125.92),
      const MockOHLC(21, 128.71, 128.71, 128.77, 126.99),
      const MockOHLC(22, 127.87, 127.87, 129.29, 127.81),
      const MockOHLC(23, 128.58, 128.58, 130.06, 128.47),
      const MockOHLC(24, 128.60, 128.60, 129.12, 128.06),
      const MockOHLC(25, 127.93, 127.93, 129.29, 127.61),
      const MockOHLC(26, 128.11, 128.11, 128.47, 127.60),
      const MockOHLC(27, 127.60, 127.60, 128.09, 127),
      const MockOHLC(28, 127.60, 127.60, 128.65, 126.90),
      const MockOHLC(29, 128.69, 128.69, 129.14, 127.49),
    ];
  });

  group('Stochastic Indicator test.', () {
    test(
        'Fast Stochastic Indicator should caclulate the correct results from the given ticks.',
        () {
      final FastStochasticIndicator<MockResult> fastStochasticIndicator =
          FastStochasticIndicator<MockResult>(MockInput(ticks));

      expect(roundDouble(fastStochasticIndicator.getValue(21).quote, 2), 69.98);
      expect(roundDouble(fastStochasticIndicator.getValue(22).quote, 2), 73.09);
      expect(roundDouble(fastStochasticIndicator.getValue(23).quote, 2), 73.45);
      expect(roundDouble(fastStochasticIndicator.getValue(24).quote, 2), 61.2);
      expect(roundDouble(fastStochasticIndicator.getValue(25).quote, 2), 60.92);
      expect(roundDouble(fastStochasticIndicator.getValue(26).quote, 2), 40.58);
      expect(roundDouble(fastStochasticIndicator.getValue(27).quote, 2), 40.58);
      expect(roundDouble(fastStochasticIndicator.getValue(28).quote, 2), 66.91);
    });

    test(
        'Slow Stochastic Indicator should caclulate the correct results from the given ticks.',
        () {
      final SlowStochasticIndicator<MockResult> slowStochasticIndicator =
          SlowStochasticIndicator<MockResult>(
        MockInput(ticks),
      );

      expect(roundDouble(slowStochasticIndicator.getValue(24).quote, 2), 69.25);
      expect(roundDouble(slowStochasticIndicator.getValue(25).quote, 2), 65.19);
      expect(roundDouble(slowStochasticIndicator.getValue(26).quote, 2), 54.23);
      expect(roundDouble(slowStochasticIndicator.getValue(27).quote, 2), 47.36);
      expect(roundDouble(slowStochasticIndicator.getValue(28).quote, 2), 49.36);
    });

    test(
        'Fast Stochastic Indicator copyValuesFrom and refreshValueFor should works fine.',
        () {
      final FastStochasticIndicator<MockResult> fastStochasticIndicator =
          FastStochasticIndicator<MockResult>(MockInput(ticks));

      final FastStochasticIndicator<MockResult>
          fastStochasticIndicatorWithNewData =
          FastStochasticIndicator<MockResult>(MockInput(ticks));

      expect(
          roundDouble(fastStochasticIndicatorWithNewData.getValue(28).quote, 2),
          66.91);

      ticks.add(const MockOHLC(30, 125.69, 126.69, 127.14, 125.49));
      fastStochasticIndicatorWithNewData.refreshValueFor(29);
      expect(
          roundDouble(fastStochasticIndicatorWithNewData.getValue(29).quote, 2),
          26.26);
      fastStochasticIndicator
          .copyValuesFrom(fastStochasticIndicatorWithNewData);
      expect(roundDouble(fastStochasticIndicator.getValue(29).quote, 2), 26.26);
    });

    test(
        'Slow Stochastic Indicator copyValuesFrom and refreshValueFor should works fine.',
        () {
      final SlowStochasticIndicator<MockResult> slowStochasticIndicator =
          SlowStochasticIndicator<MockResult>(
        MockInput(ticks),
      );

      final SlowStochasticIndicator<MockResult>
          slowStochasticIndicatorWithNewData =
          SlowStochasticIndicator<MockResult>(MockInput(ticks));

      expect(
          roundDouble(slowStochasticIndicatorWithNewData.getValue(28).quote, 2),
          49.36);

      ticks.add(const MockOHLC(30, 125.69, 126.69, 127.14, 125.49));
      slowStochasticIndicatorWithNewData.refreshValueFor(29);
      expect(
          roundDouble(slowStochasticIndicatorWithNewData.getValue(29).quote, 2),
          44.58);
      slowStochasticIndicator
          .copyValuesFrom(slowStochasticIndicatorWithNewData);
      expect(roundDouble(slowStochasticIndicator.getValue(29).quote, 2), 44.58);
    });
  });
}
