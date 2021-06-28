import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/helper_indicators/close_value_inidicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/sma_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_models.dart';

void main() {
  group('Variable Moving Average', () {
    late List<MockTick> ticks;

    setUpAll(() {
      // Data from app.deriv.com:
      ticks = const <MockTick>[
        MockTick(epoch: 0, quote: 84.154),
        MockTick(epoch: 1, quote: 84.150),
        MockTick(epoch: 2, quote: 84.150),
        MockTick(epoch: 3, quote: 84.151),
        MockTick(epoch: 4, quote: 84.148),
        MockTick(epoch: 5, quote: 84.143),
        MockTick(epoch: 6, quote: 84.136),
        MockTick(epoch: 7, quote: 84.141),
        MockTick(epoch: 8, quote: 84.135),
        MockTick(epoch: 9, quote: 84.137),
        MockTick(epoch: 10, quote: 84.135),
        MockTick(epoch: 11, quote: 84.146),
        MockTick(epoch: 12, quote: 84.142),
        MockTick(epoch: 13, quote: 84.140),
        MockTick(epoch: 14, quote: 84.141),
        MockTick(epoch: 15, quote: 84.122),
        MockTick(epoch: 16, quote: 84.121),
        MockTick(epoch: 17, quote: 84.124),
        MockTick(epoch: 18, quote: 84.128),
        MockTick(epoch: 19, quote: 84.117),
        MockTick(epoch: 20, quote: 84.122),
      ];
    });

    test('VMAIndicator calculates the correct results', () {
      final VMAIndicator<MockResult> v = VMAIndicator<MockResult>(
          CloseValueIndicator<MockResult>(MockInput(ticks)), 3);

      // Comparing Results with app.deriv.com
      // expect(v.getValue(10).quote, closeTo(84.139, 0.03));
      // expect(v.getValue(11).quote, closeTo(84.139, 0.03));
      // expect(v.getValue(12).quote, closeTo(84.139, 0.01));
      // expect(v.getValue(13).quote, closeTo(84.139, 0.01));
      // expect(v.getValue(14).quote, closeTo(84.137, 0.01));
      // expect(v.getValue(15).quote, closeTo(84.134, 0.01));
      // expect(v.getValue(16).quote, closeTo(84.133, 0.01));
      // expect(v.getValue(18).quote, closeTo(84.130, 0.01));
      // expect(v.getValue(19).quote, closeTo(84.128, 0.01));
      // expect(v.getValue(20).quote, closeTo(84.128, 0.01));
    });
  });
}
