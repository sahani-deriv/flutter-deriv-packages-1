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

  /// Retrieve [ExchangeController] from the widget tree.
  static ExchangeController? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ExchangeNotifier>()!.notifier;
}

/// It controls exchange rate conversion, switching between currencies and all the logic related to currency.
class ExchangeController extends ChangeNotifier {
  ///
  ExchangeController({
    required this.rateSource,
    required CurrencyDetail primaryCurrency,
    required this.currencyFieldController,
    required ExchangeRateModel initialExchangeRate,
  }) {
    exchangeRate = initialExchangeRate;
    _primaryCurrency = primaryCurrency;
    _secondaryCurrency = CurrencyDetail(
        _getExchangedOutput(_primaryCurrency.amount),
        exchangeRate.targetCurrency);
    _listenForExchangeRateChange();
  }

  /// controller for active textfield.
  TextEditingController currencyFieldController;
  late bool _isSwapped = false;
  late ExchangeRateModel exchangeRate;
  late CurrencyDetail _primaryCurrency;
  late CurrencyDetail _secondaryCurrency;
  Stream<ExchangeRateModel> rateSource;

  /// Currently active currency in textField
  CurrencyDetail get primaryCurrency => _primaryCurrency;

  /// Exchanged currency
  CurrencyDetail get secondaryCurrency => _secondaryCurrency;

  Future<void> _listenForExchangeRateChange() async {
    rateSource.listen((ExchangeRateModel rate) {
      exchangeRate = rate;
      _secondaryCurrency = CurrencyDetail(
        _getExchangedOutput(_primaryCurrency.amount),
        rate.targetCurrency,
      );
      notifyListeners();
    });
  }

  /// This is called when an amount is changed in textField and immediately converts amount in secondary currency.
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

  /// This will interchange the currency, amount from textField to switcher and vice-versa.
  void swap() {
    _isSwapped = !_isSwapped;

    final double localPrimary =
        double.tryParse(currencyFieldController.text) ?? 0.0;

    final String localPrimaryCurrency = _primaryCurrency.currencyType;

    _primaryCurrency = CurrencyDetail(
      _secondaryCurrency.amount,
      _secondaryCurrency.currencyType,
    );
    _secondaryCurrency = CurrencyDetail(localPrimary, localPrimaryCurrency);
    currencyFieldController
      ..text = _primaryCurrency.amount == 0.0
          ? ''
          : _primaryCurrency.amount.toString()
      ..selection = TextSelection.fromPosition(
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

/// Inversion extension
extension ExchangeRateInverse on ExchangeRateModel {
  /// This will get the inverse of the actual exchange rate.
  double getInverseOfExchangeRate() => 1 / exchangeRate;
}
