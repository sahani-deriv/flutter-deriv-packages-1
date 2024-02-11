import 'package:deriv_auth/deriv_auth.dart';
import 'package:deriv_auth/features/single_entry/features/signup/pages/set_password_page.dart';
import 'package:flutter/material.dart';

/// Country selection page
class CountrySelectionPage extends StatelessWidget {
  ///
  const CountrySelectionPage({
    required this.verificationCode,
    this.affiliateToken,
    super.key,
  });

  /// Verification code
  final String verificationCode;

  ///
  final String? affiliateToken;

  @override
  Widget build(BuildContext context) => DerivCountrySelectionLayout(
        onNextPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => SetPasswordPage(
                verificationCode: verificationCode,
                affiliateToken: affiliateToken,
              ),
            ),
          );
        },
        residences: Future.value([
          const DerivResidenceModel(
            code: 'ID',
            name: 'Indonesia',
            isDisabled: false,
          ),
          const DerivResidenceModel(
            code: 'UK',
            name: 'England',
            isDisabled: true,
          ),
        ]),
        verificationCode: verificationCode,
        affiliateToken: affiliateToken,
      );
}
