import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:deriv_technical_analysis/src/indicators/calculations/awesome_oscillator_indicator.dart';

import '../mock_models.dart';

void main() {
  group('Awesome Oscillator Indicator', () {
    List<MockOHLC> ticks;

    setUpAll(() {
      ticks = const <MockOHLC>[
        MockOHLC.withNames(epoch: 1, open: 0, close: 0, high: 16, low: 8),
        MockOHLC.withNames(epoch: 2, open: 0, close: 0, high: 12, low: 6),
        MockOHLC.withNames(epoch: 3, open: 0, close: 0, high: 18, low: 14),
        MockOHLC.withNames(epoch: 4, open: 0, close: 0, high: 10, low: 6),
        MockOHLC.withNames(epoch: 5, open: 0, close: 0, high: 8, low: 4)
      ];
    });

    test('AwesomeOscillator calculates the correct result from HL2Indicator.',
        () {
      final AwesomeOscillatorIndicator<MockResult> _aoIndicator =
          AwesomeOscillatorIndicator<MockResult>(
              HL2Indicator<MockResult>(MockInput(ticks)));

      expect(_aoIndicator.getValue(0).quote, 0.0);
      expect(_aoIndicator.getValue(1).quote, 0.0);
      expect(_aoIndicator.getValue(2).quote, 0.0);
      expect(_aoIndicator.getValue(3).quote, 0.0);
      expect(_aoIndicator.getValue(4).quote, 0.0);
    });

    test('Calculating using custom Period for SMA', () {
      final AwesomeOscillatorIndicator<MockResult> _aoIndicator =
          AwesomeOscillatorIndicator<MockResult>(
              HL2Indicator<MockResult>(MockInput(ticks)),
              smaPeriodOne: 2,
              smaPeriodTwo: 3);

      expect(_aoIndicator.getValue(0).quote, 0.0);
      expect(_aoIndicator.getValue(1).quote, 0.0);
      expect(_aoIndicator.getValue(2).quote, 0.16666666666666607);
      expect(_aoIndicator.getValue(3).quote, 1);
      expect(_aoIndicator.getValue(4).quote, -3);
    });
  });
}
