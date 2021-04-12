import 'package:deriv_technical_analysis/src/indicators/calculations/commodity_channel_index_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_models.dart';

void main() {
  group('CommodityChannelIndex indicator', () {
    List<MockTick> ticks;

    setUp(() {
      ticks = const <MockTick>[
        MockTick(quote: 23.98),
        MockTick(quote: 23.92),
        MockTick(quote: 23.79),
        MockTick(quote: 23.67),
        MockTick(quote: 23.54),
        MockTick(quote: 23.36),
        MockTick(quote: 23.65),
        MockTick(quote: 23.72),
        MockTick(quote: 24.16),
        MockTick(quote: 23.91),
        MockTick(quote: 23.81),
        MockTick(quote: 23.92),
        MockTick(quote: 23.74),
        MockTick(quote: 24.68),
        MockTick(quote: 24.94),
        MockTick(quote: 24.93),
        MockTick(quote: 25.10),
        MockTick(quote: 25.12),
        MockTick(quote: 25.20),
        MockTick(quote: 25.06),
        MockTick(quote: 24.50),
        MockTick(quote: 24.31),
        MockTick(quote: 24.57),
        MockTick(quote: 24.62),
        MockTick(quote: 24.49),
        MockTick(quote: 24.37),
        MockTick(quote: 24.41),
        MockTick(quote: 24.35),
        MockTick(quote: 23.75),
        MockTick(quote: 24.09),
      ];
    });

    test('Commodity Channel Index calculates the correct result', () {
      final CommodityChannelIndexIndicator<MockResult> cci =
          CommodityChannelIndexIndicator<MockResult>(MockInput(ticks), 20);

      // Incomplete time frame
      expect(cci.getValue(0).quote, 0);
      expect(cci.getValue(1).quote, -66.66666666667062);
      expect(cci.getValue(2).quote, -100.000000000005);
      expect(cci.getValue(10).quote, 14.365001632386067);
      expect(cci.getValue(11).quote, 54.25442291491223);

      // Complete time frame
      expect(cci.getValue(19).quote, 101.91846522781749);
      expect(cci.getValue(20).quote, 31.19461183977306);
      expect(cci.getValue(21).quote, 6.557771560929368);
      expect(cci.getValue(22).quote, 33.607807258310565);
      expect(cci.getValue(23).quote, 34.9685534591193);
      expect(cci.getValue(24).quote, 13.602679930971021);
      expect(cci.getValue(25).quote, -10.678871090770443);
      expect(cci.getValue(26).quote, -11.470985155195915);
      expect(cci.getValue(27).quote, -29.256660705277692);
      expect(cci.getValue(28).quote, -128.60001740189702);
      expect(cci.getValue(29).quote, -72.72727272727296);
    });
  });
}
