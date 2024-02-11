import 'package:deriv_auth/deriv_auth.dart';
import 'package:deriv_ui/deriv_ui.dart';
import 'package:flutter/material.dart';

/// Reset password page
class ResetPassPage extends StatefulWidget {
  /// Constructor for reset password page
  const ResetPassPage({super.key});

  @override
  State<ResetPassPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPassPage> {
  @override
  Widget build(BuildContext context) => DerivResetPassLayout(
        onResetPassError: (String? errorMessage) {
          showErrorDialog(
            context: context,
            errorMessage: errorMessage,
            actionLabel: 'okay',
          );
        },
      );
}
