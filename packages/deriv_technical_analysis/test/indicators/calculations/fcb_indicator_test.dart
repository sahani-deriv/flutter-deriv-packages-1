import 'package:deriv_technical_analysis/src/indicators/calculations/fcb_high_indicator.dart';
import 'package:deriv_technical_analysis/src/indicators/calculations/fcb_low_indicator.dart';

import 'package:flutter_test/flutter_test.dart';
import '../mock_models.dart';

void main() {
  group('Fractal Chaos Band Indicator', () {
    List<MockOHLC> candles;
    setUpAll(() {
      candles = <MockOHLC>[
        const MockOHLC(1, 212.61, 212.80, 213.35, 211.52),
        const MockOHLC(2, 213.16, 214.06, 214.22, 213.15),
        const MockOHLC(3, 213.77, 213.89, 214.06, 213.02),
        const MockOHLC(4, 214.02, 214.66, 215.17, 213.42),
        const MockOHLC(5, 214.38, 213.95, 214.53, 213.91),
        const MockOHLC(6, 213.97, 213.95, 214.89, 213.52),
        const MockOHLC(7, 213.86, 214.55, 214.55, 213.13),
        const MockOHLC(8, 213.99, 214.02, 214.22, 212.53),
        const MockOHLC(9, 214.21, 214.51, 214.84, 214.17),
        const MockOHLC(10, 213.81, 213.75, 214.25, 213.33),
        const MockOHLC(11, 214.02, 214.22, 214.27, 213.42),
        const MockOHLC(12, 214.31, 213.43, 214.46, 212.96),
        const MockOHLC(13, 214.18, 214.21, 214.75, 213.49),
        const MockOHLC(14, 213.85, 213.66, 214.28, 212.83),
        const MockOHLC(15, 213.89, 215.03, 215.48, 213.77),
        const MockOHLC(16, 216.07, 216.89, 216.89, 215.89),
        const MockOHLC(17, 216.73, 216.66, 217.02, 216.36),
        const MockOHLC(18, 216.75, 216.32, 216.91, 216.12),
        const MockOHLC(19, 215.57, 214.98, 215.59, 213.90),
        const MockOHLC(20, 214.44, 214.96, 215.03, 213.82),
        const MockOHLC(21, 215.65, 215.05, 215.96, 214.40),
        const MockOHLC(22, 214.65, 215.19, 215.50, 214.29),
        const MockOHLC(23, 216.18, 216.67, 216.87, 215.84),
        const MockOHLC(24, 216.23, 216.28, 216.66, 215.92),
        const MockOHLC(25, 216.71, 216.29, 216.97, 216.09),
        const MockOHLC(26, 215.98, 216.58, 216.72, 215.70),
      ];
    });

    test('FractalChaosBandHighIndicator should calculates the correct results',
        () {
      final FractalChaosBandHighIndicator<MockResult>
          fractalChaosBandHighIndicator =
          FractalChaosBandHighIndicator<MockResult>(MockInput(candles));
      expect(fractalChaosBandHighIndicator.getValue(7).quote, 215.17);
      expect(fractalChaosBandHighIndicator.getValue(8).quote, 215.17);
      expect(fractalChaosBandHighIndicator.getValue(11).quote, 214.84);
      expect(fractalChaosBandHighIndicator.getValue(26).quote, 217.02);
      expect(fractalChaosBandHighIndicator.getValue(12).quote, 214.84);
    });

    test('FractalChaosBandLowIndicator should calculates the correct results',
        () {
      final FractalChaosBandLowIndicator<MockResult>
          fractalChaosBandLowIndicator =
          FractalChaosBandLowIndicator<MockResult>(MockInput(candles));
      expect(fractalChaosBandLowIndicator.getValue(10).quote, 212.53);
      expect(fractalChaosBandLowIndicator.getValue(17).quote, 212.83);
      expect(fractalChaosBandLowIndicator.getValue(25).quote, 213.82);
      expect(fractalChaosBandLowIndicator.getValue(26).quote, 213.82);
    });
  });
}
