import 'package:deriv_technical_analysis/deriv_technical_analysis.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/helper_indicators/close_value_inidicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/sma_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_models.dart';

void main() {
  group('Simple Moving Average', () {
    List<MockTick> ticks;

    setUpAll(() {
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

    test('SMAIndicator calculates the correct results', () {
      // final PdmS<MockResult> smaIndicator = PdmS<MockResult>(
      //     CloseValueIndicator<MockResult>(MockInput(ticks)), 1/3)..calculateValues();
      // final MdmS<MockResult> m = MdmS<MockResult>(
      //     CloseValueIndicator<MockResult>(MockInput(ticks)), 1/3)..calculateValues();
      // final MdiS<MockResult> s = MdiS<MockResult>(
      //     CloseValueIndicator<MockResult>(MockInput(ticks)), 1/3)..calculateValues();
      // final IS<MockResult> ss = IS<MockResult>(
      //     CloseValueIndicator<MockResult>(MockInput(ticks)), 1/3)..calculateValues();
      final VMAIndicator<MockResult> v = VMAIndicator<MockResult>(
          CloseValueIndicator<MockResult>(MockInput(ticks)), 3);
      print(v.getValue(19).quote);
      expect(v.getValue(19).quote,84.128);
      // expect(1.5, smaIndicator.getValue(1).quote);
      // expect(2, smaIndicator.getValue(2).quote);
      // expect(3, smaIndicator.getValue(3).quote);
      // expect(10 / 3, smaIndicator.getValue(4).quote);
      // expect(11 / 3, smaIndicator.getValue(5).quote);
      // expect(4, smaIndicator.getValue(6).quote);
      // expect(13 / 3, smaIndicator.getValue(7).quote);
      // expect(4, smaIndicator.getValue(8).quote);
      // expect(10 / 3, smaIndicator.getValue(9).quote);
      // expect(10 / 3, smaIndicator.getValue(10).quote);
      // expect(10 / 3, smaIndicator.getValue(11).quote);
      // expect(3, smaIndicator.getValue(12).quote);
    });
  });
}
