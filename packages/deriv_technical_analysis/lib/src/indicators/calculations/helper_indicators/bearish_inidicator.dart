import 'package:deriv_technical_analysis/src/indicators/cached_indicator.dart';
import 'package:deriv_technical_analysis/src/models/data_input.dart';
import 'package:deriv_technical_analysis/src/models/models.dart';

/// Bearish Indicator
class BearishIndicator<T extends IndicatorResult> extends CachedIndicator<T> {
  /// Initializes
  BearishIndicator(this.inputs) : super(inputs);

  /// Calculating Bearish on this data
  final IndicatorDataInput inputs;

  @override
  T calculate(int index) {
    if (index < 2 || index > inputs.entries.length - 2) {
      return createResult(index: index, quote: double.nan);
    }
    if (inputs.entries[index].high > inputs.entries[index - 1].high &&
        inputs.entries[index].high > inputs.entries[index - 2].high &&
        inputs.entries[index].high > inputs.entries[index + 1].high &&
        inputs.entries[index].high > inputs.entries[index + 2].high) {
      return createResult(index: index, quote: inputs.entries[index].high);
    } else {
      return createResult(index: index, quote: double.nan);
    }
  }
}
