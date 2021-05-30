import 'package:deriv_technical_analysis/src/indicators/calculations/williams_r_indicator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_models.dart';

void main() {
  group('William\'s R indicator', () {
    test('description', () {
      const List<MockOHLC> ticks = <MockOHLC>[
        MockOHLC(1, 44.98, 45.05, 45.17, 44.96),
        MockOHLC(2, 45.05, 45.10, 45.15, 44.99),
        MockOHLC(3, 45.11, 45.19, 45.32, 45.11),
        MockOHLC(4, 45.19, 45.14, 45.25, 45.04),
        MockOHLC(5, 45.12, 45.15, 45.20, 45.10),
        MockOHLC(6, 45.15, 45.14, 45.20, 45.10),
        MockOHLC(7, 45.13, 45.10, 45.16, 45.07),
        MockOHLC(8, 45.12, 45.15, 45.22, 45.10),
        MockOHLC(9, 45.15, 45.22, 45.27, 45.14),
        MockOHLC(10, 45.24, 45.43, 45.45, 45.20),
        MockOHLC(11, 45.43, 45.44, 45.50, 45.39),
        MockOHLC(12, 45.43, 45.55, 45.60, 45.35),
        MockOHLC(13, 45.58, 45.55, 45.61, 45.39),
      ];

      final WilliamsRIndicator<MockResult> williamsRIndicator =
          WilliamsRIndicator<MockResult>(MockInput(ticks), 5);

      expect(williamsRIndicator.getValue(4).quote, -47.22222222222277);
      expect(williamsRIndicator.getValue(5).quote, -54.54545454545474);
      expect(williamsRIndicator.getValue(6).quote, -78.57142857142784);
      expect(williamsRIndicator.getValue(7).quote, -47.619047619048104);
      expect(williamsRIndicator.getValue(8).quote, -25.000000000001776);
      expect(williamsRIndicator.getValue(9).quote, -5.263157894737629);
      expect(williamsRIndicator.getValue(10).quote, -13.953488372093561);
    });
  });
}
