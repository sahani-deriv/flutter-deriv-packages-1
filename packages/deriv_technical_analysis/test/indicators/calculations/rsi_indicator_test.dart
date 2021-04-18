import 'package:deriv_technical_analysis/src/helpers/functions.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/helper_indicators/close_value_inidicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/helper_indicators/open_value_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/rsi_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_models.dart';

void main() {
  List<MockTick> ticks;

  setUpAll(() {
    ticks = <MockTick>[
      const MockOHLC(00, 79.537, 79.532, 79.540, 79.529),
      const MockOHLC(01, 79.532, 79.524, 79.536, 79.522),
      const MockOHLC(02, 79.523, 79.526, 79.536, 79.522),
      const MockOHLC(03, 79.525, 79.529, 79.534, 79.522),
      const MockOHLC(04, 79.528, 79.532, 79.532, 79.518),
      const MockOHLC(05, 79.533, 79.525, 79.539, 79.518),
      const MockOHLC(06, 79.525, 79.514, 79.528, 79.505),
      const MockOHLC(07, 79.515, 79.510, 79.516, 79.507),
      const MockOHLC(08, 79.509, 79.507, 79.512, 79.503),
      const MockOHLC(09, 79.507, 79.518, 79.520, 79.504),
      const MockOHLC(10, 79.517, 79.507, 79.523, 79.507),
      const MockOHLC(11, 79.510, 79.509, 79.515, 79.505),
      const MockOHLC(12, 79.508, 79.513, 79.518, 79.508),
      const MockOHLC(13, 79.513, 79.526, 79.526, 79.513),
      const MockOHLC(14, 79.526, 79.526, 79.527, 79.521),
      const MockOHLC(15, 79.526, 79.544, 79.547, 79.525),
      const MockOHLC(16, 79.546, 79.545, 79.547, 79.533),
      const MockOHLC(17, 79.545, 79.556, 79.559, 79.538),
      const MockOHLC(18, 79.557, 79.554, 79.562, 79.544),
      const MockOHLC(19, 79.555, 79.549, 79.559, 79.548),
      const MockOHLC(20, 79.550, 79.548, 79.554, 79.545),
    ];
  });

  group('Relative Strength Index Indicator test.', () {
    test(
        'Relative Strength Index should calculate the correct results from the given closed value indicator ticks.',
        () {
      final CloseValueIndicator<MockResult> closeValueIndicator =
          CloseValueIndicator<MockResult>(MockInput(ticks));
      final RSIIndicator<MockResult> rsiIndicator =
          RSIIndicator<MockResult>.fromIndicator(closeValueIndicator, 14);

      expect(rsiIndicator.getValue(0).quote, 0);
      expect(roundDouble(rsiIndicator.getValue(14).quote, 2), 52.88);
      expect(roundDouble(rsiIndicator.getValue(15).quote, 2), 65.42);
      expect(roundDouble(rsiIndicator.getValue(16).quote, 2), 65.96);
      expect(roundDouble(rsiIndicator.getValue(17).quote, 2), 71.28);
    });
    test('RSI Indicator copyValuesFrom and refreshValueFor should works fine',
        () {
      final CloseValueIndicator<MockResult> closeValueIndicator =
          CloseValueIndicator<MockResult>(MockInput(ticks));

      final OpenValueIndicator<MockResult> openValueIndicator =
          OpenValueIndicator<MockResult>(MockInput(ticks));

      final RSIIndicator<MockResult> rsiIndicator =
          RSIIndicator<MockResult>.fromIndicator(closeValueIndicator, 14);

      final RSIIndicator<MockResult> rsiIndicatorWithNewData =
          RSIIndicator<MockResult>.fromIndicator(openValueIndicator, 14);

      expect(roundDouble(rsiIndicator.getValue(14).quote, 2), 52.88);
      expect(roundDouble(rsiIndicatorWithNewData.getValue(14).quote, 2), 51.22);

      rsiIndicatorWithNewData.copyValuesFrom(rsiIndicator);
      expect(roundDouble(rsiIndicatorWithNewData.getValue(14).quote, 2), 52.88);

      ticks.add(const MockOHLC(21, 89.550, 89.548, 89.554, 89.545));

      rsiIndicatorWithNewData.refreshValueFor(21);
      expect(roundDouble(rsiIndicatorWithNewData.getValue(21).quote, 2), 99.78);
    });
  });
}
