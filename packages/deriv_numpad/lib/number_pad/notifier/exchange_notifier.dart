import 'package:deriv_numpad/number_pad/model/currency_exchange_payload.dart';
import 'package:deriv_numpad/number_pad/model/exchange_rate_model.dart';
import 'package:flutter/material.dart';

///
class ExchangeNotifier extends InheritedNotifier<ExchangeController> {
  ///
  const ExchangeNotifier({
    required super.child,
    super.notifier,
  });

  static ExchangeController? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ExchangeNotifier>()!.notifier;
}

class ExchangeController extends ChangeNotifier {
  ExchangeController({
    // required this.rateSource,
    required CurrencyDetail primaryCurrency,
    required CurrencyDetail secondaryCurrency,
    required this.currencyFieldController,
  })  : _secondaryCurrency = secondaryCurrency,
        _primaryCurrency = primaryCurrency;
  TextEditingController currencyFieldController;
  late bool _isSwapped = false;

  CurrencyDetail _primaryCurrency;
  CurrencyDetail _secondaryCurrency;

  CurrencyDetail get primaryCurrency => _primaryCurrency;
  CurrencyDetail get secondaryCurrency => _secondaryCurrency;

  final ExchangeRateModel exchangeRate = ExchangeRateModel(
    baseCurrency: 'BTC',
    targetCurrency: 'ETH',
    exchangeRate: 18.0695090444717,
  );

  // final Stream<int> rateSource;

  void onChangeCurrency(String newValue) {
    if (currencyFieldController.text.isNotEmpty &&
        currencyFieldController.text != _primaryCurrency.amount.toString()) {
      _secondaryCurrency = _getUpdatedSecondaryCurrency();
      _primaryCurrency = _getUpdatedPrimaryCurrency();
      notifyListeners();
    } else {
      _secondaryCurrency = CurrencyDetail(0, _secondaryCurrency.currencyType);
    }
  }

  void swap() {
    // Its better to have a boolean flag to hold swapped or not flag. meaning
    //swapped from the initial point.
    //eg: in initial state the flag will be false.
    // when swapped it will toggle and so will the logic from actual to inverse. i.e exchangeRate to 1 / exchangeRate
    _isSwapped = !_isSwapped;

    final double localPrimary =
        double.tryParse(currencyFieldController.text) ?? 0.0;
    // localPrimary = _getExchangedOutput(localPrimary);
    final String localPrimaryCurrency = _primaryCurrency.currencyType;

    _primaryCurrency = CurrencyDetail(
      _secondaryCurrency.amount,
      _secondaryCurrency.currencyType,
    );
    _secondaryCurrency = CurrencyDetail(localPrimary, localPrimaryCurrency);
    currencyFieldController.text = _primaryCurrency.amount == 0.0
        ? ''
        : _primaryCurrency.amount.toString();
    currencyFieldController.selection = TextSelection.fromPosition(
      TextPosition(offset: currencyFieldController.text.length),
    );
    notifyListeners();
  }

  CurrencyDetail _getUpdatedSecondaryCurrency() {
    final double value = double.parse(
        _getExchangedOutput(double.parse(currencyFieldController.text))
            .toStringAsFixed(8));
    return CurrencyDetail(value, _secondaryCurrency.currencyType);
  }

  CurrencyDetail _getUpdatedPrimaryCurrency() => CurrencyDetail(
      double.parse(currencyFieldController.text),
      _primaryCurrency.currencyType);

  double _getExchangedOutput(double amount) => _isSwapped
      ? exchangeRate.getInverseOfExchangeRate() * amount
      : exchangeRate.exchangeRate * amount;
}

extension ExchangeRateInverse on ExchangeRateModel {
  double getInverseOfExchangeRate() => 1 / exchangeRate;
}
