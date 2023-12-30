import 'package:deriv_numpad/core/helpers/custom_website_status_helper.dart';
import 'package:deriv_numpad/number_pad/model/exchange_rate_model.dart';

class CurrencyExchangePayload {
  /// Here, the primaryCurrency is the one in keypad by default and
  /// secondary is in the switcher
  CurrencyExchangePayload({
    required this.onValid,
    required this.primaryCurrency,
    required this.exchangeRatesStream,
    required this.initialExchangeRate,
  });

  final CurrencyDetail primaryCurrency;
  final bool Function(String) onValid;
  final Stream<ExchangeRateModel> exchangeRatesStream;
  final ExchangeRateModel initialExchangeRate;
}

/// This is a data class for storing the currency data like amount, currencyType
class CurrencyDetail {
  /// Data class for currency
  CurrencyDetail(this.amount, this.currencyType);

  /// Available fiat currency that Deriv supports.
  static List<String> fiatCurrencies = <String>['USD', 'AUD', 'EUR'];

  /// Amount passed for exchance.
  final double amount;

  /// Type of the currency whether be it crypto or fiat. Eg: USD,BTC,ETH,AUD and so on.
  final String currencyType;

  /// This will check if this instance is a fiat type currency or not.
  bool get isFiat => fiatCurrencies.contains(currencyType);

  /// Amount that is used to display for user.
  String get displayAmount {
    if (amount == 0.0) {
      return '';
    }

    return isFiat ? amount.toStringAsFixed(2) : amount.toStringAsFixed(8);
  }

  /// This method is used to display currency for user.
  String get displayCurrency => getStringWithMappedCurrencyName(currencyType);
}
