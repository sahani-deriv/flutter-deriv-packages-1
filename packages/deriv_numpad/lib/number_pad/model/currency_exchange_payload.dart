import 'package:deriv_numpad/core/helpers/custom_website_status_helper.dart';

class CurrencyExchangePayload {
  CurrencyExchangePayload({
    required this.primaryCurrency,
    required this.secondaryCurrency,
  });

  final CurrencyDetail primaryCurrency;
  final CurrencyDetail secondaryCurrency;
}

class CurrencyDetail {
  CurrencyDetail(this.amount, this.currencyType);

  final double amount;
  final String currencyType;

  String get displayAmount => amount != 0.0 ? amount.toStringAsFixed(8) : '';

  String get displayCurrency => getStringWithMappedCurrencyName(currencyType);
}
