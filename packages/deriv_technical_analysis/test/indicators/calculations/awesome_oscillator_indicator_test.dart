import 'package:flutter_test/flutter_test.dart';

import 'package:deriv_technical_analysis/src/indicators/calculations/awesome_oscillator_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/helper_indicators/close_value_inidicator.dart';

import '../mock_models.dart';

void main() {
  group('Awesome Oscillator Indicator', () {
    List<MockOHLC> ticks;

    setUpAll(() {
      ticks = const <MockOHLC>[
        MockOHLC.withNames(
            epoch: 1, open: 64.75, close: 64.12, high: 67.5, low: 63),
        MockOHLC.withNames(
            epoch: 2, open: 73.5, close: 74.62, high: 75.65, low: 73.12),
        MockOHLC.withNames(
            epoch: 3, open: 74.2, close: 73.42, high: 76.3, low: 73.33),
        MockOHLC.withNames(
            epoch: 4, open: 70.12, close: 72.2, high: 73.5, low: 70.12),
        MockOHLC.withNames(
            epoch: 5, open: 73.21, close: 73.64, high: 76.3, low: 72.31),
      ];
    });

    test('AO result calculation', () {
      final AwesomeOscillatorIndicator<MockResult> _aoIndicator =
          AwesomeOscillatorIndicator<MockResult>(
              CloseValueIndicator<MockResult>(MockInput(ticks)));
    });
  });
}
