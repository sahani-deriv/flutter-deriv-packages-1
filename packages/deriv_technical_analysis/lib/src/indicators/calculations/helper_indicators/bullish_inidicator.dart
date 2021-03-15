import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Bullish Indicator
class BullishIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  BullishIndicator(this.inputs) : super(inputs);

  /// Calculating Bullish on this data
  final IndicatorDataInput inputs;

  @override
  T calculate(int index) {
    if (index < 2 || index > inputs.entries.length - 3) {
      return createResult(index: index, quote: double.nan);
    }
    if (inputs.entries[index].low < inputs.entries[index - 1].low &&
        inputs.entries[index].low < inputs.entries[index - 2].low &&
        inputs.entries[index].low < inputs.entries[index + 1].low &&
        inputs.entries[index].low < inputs.entries[index + 2].low) {
      return createResult(index: index, quote: inputs.entries[index].low);
    } else {
      return createResult(index: index, quote: double.nan);
    }
  }
}
