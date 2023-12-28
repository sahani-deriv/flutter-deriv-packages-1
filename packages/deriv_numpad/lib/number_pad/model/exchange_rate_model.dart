class ExchangeRateModel {
  ExchangeRateModel({
    required this.baseCurrency,
    required this.targetCurrency,
    required this.exchangeRate,
  });

  final String baseCurrency;
  final String targetCurrency;
  final double exchangeRate;
}
