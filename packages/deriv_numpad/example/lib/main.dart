import 'dart:async';

import 'package:deriv_numpad/deriv_numberpad.dart';
import 'package:deriv_numpad/number_pad/model/currency_exchange_payload.dart';
import 'package:deriv_numpad/number_pad/model/exchange_rate_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DerivNumberPad Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final stream = StreamController<ExchangeRateModel>.broadcast();
            // Future.delayed(const Duration(seconds: 5), () {
            //   stream.sink.add(ExchangeRateModel(
            //     baseCurrency: 'BTC',
            //     targetCurrency: 'USD',
            //     exchangeRate: 12,
            //   ));
            // });

            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NumberPad.withCurrencyExchanger(
                    exchangeRatesStream: stream.stream,
                    onValid: (_) => true,
                    initialExchangeRate: ExchangeRateModel(
                      baseCurrency: 'BTC',
                      targetCurrency: 'USD',
                      exchangeRate: 42800,
                    ),
                    primaryCurrency: CurrencyDetail(0.123, 'BTC'),
                    label: NumberPadLabel(
                      semanticNumberPadBottomSheetHandle:
                          'semanticNumberPadBottomSheetHandle',
                      warnValueCantBeLessThan: (_, __, ___) =>
                          'warnValueCantBeLessThan',
                      warnValueCantBeGreaterThan: (_, __, ___) =>
                          'warnValueCantBeGreaterThan',
                      warnDoubleInputValueCantBeLessThan: (_, __, ___) =>
                          'warnDoubleInputValueCantBeLessThan',
                      warnDoubleInputValueCantBeGreaterThan: (_, __, ___) =>
                          'warnDoubleInputValueCantBeGreaterThan',
                      warnValueShouldBeInRange: (_, __, ___, ____) =>
                          'warnValueShouldBeInRange',
                      actionOK: 'OK',
                    ),
                  ),
                ],
              ),
            );
          },
          child: const Text('Button 1'),
        ),
      ),
    );
  }
}
