import 'package:deriv_theme/deriv_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencySwitcher extends StatelessWidget {
  const CurrencySwitcher({
    required this.amount,
    required this.currency,
    this.onTap,
  });
  final String amount;
  final String currency;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: context.theme.colors.general,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                amount.isEmpty ? const SizedBox() : _CurrencyText('$amount '),
                _CurrencyText(currency),
                const SizedBox(width: 4),
                SvgPicture.asset(
                  'assets/ic_currency_swap.svg',
                  height: 8,
                  width: 8,
                  color: context.theme.colors.prominent,
                )
              ],
            ),
          ),
        ),
      );
}

class _CurrencyText extends StatelessWidget {
  const _CurrencyText(this.message);

  final String message;

  @override
  Widget build(BuildContext context) => Text(
        message,
        style: context.theme.textStyle(
          textStyle: TextStyles.body1,
          color: context.theme.colors.general,
        ),
      );
}
