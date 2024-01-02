import 'package:deriv_numpad/core/assets.dart';
import 'package:deriv_numpad/number_pad/model/currency_detail.dart';
import 'package:deriv_theme/deriv_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A widget that reflects the exchanged currency of what every typed in currency textfield.
class CurrencySwitcher extends StatelessWidget {
  /// A widget that reflects the exchanged currency of what every typed in currency textfield.
  const CurrencySwitcher({
    required this.currencyDetail,
    this.onTap,
  });

  /// Data class for currency information to show in this widget.
  final CurrencyDetail currencyDetail;

  /// call back when this widget is pressed.
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
              children: <Widget>[
                currencyDetail.displayAmount.isEmpty
                    ? const SizedBox()
                    : _CurrencyText('${currencyDetail.displayAmount} '),
                _CurrencyText(currencyDetail.displayCurrency),
                const SizedBox(width: 4),
                SvgPicture.asset(
                  swapIcon,
                  height: 16,
                  width: 16,
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
