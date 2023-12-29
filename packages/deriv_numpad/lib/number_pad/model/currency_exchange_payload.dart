import 'package:deriv_numpad/core/helpers/custom_website_status_helper.dart';

class CurrencyExchangePayload {
  /// Here, the primaryCurrency is the one in keypad by default and
  /// secondary is in the switcher
  CurrencyExchangePayload({
    required this.primaryCurrency,
    required this.secondaryCurrency,
  });

  final CurrencyDetail primaryCurrency;
  final CurrencyDetail secondaryCurrency;
}

class CurrencyDetail {
  CurrencyDetail(this.amount, this.currencyType);

  static List<String> fiatCurrencies = <String>['USD', 'AUD', 'EUR'];

  final double amount;
  final String currencyType;

  bool get isFiat => fiatCurrencies.contains(currencyType);

  String get displayAmount {
    if (amount == 0.0) {
      return '';
    }

    return isFiat ? amount.toStringAsFixed(2) : amount.toStringAsFixed(8);
  }

  String get displayCurrency => getStringWithMappedCurrencyName(currencyType);
}
