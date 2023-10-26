import 'package:deriv_auth/deriv_auth.dart';
import 'package:deriv_auth_ui/src/core/extensions/context_extension.dart';
import 'package:deriv_auth_ui/src/core/states/auth_error_state_handler.dart';
import 'package:deriv_ui/deriv_ui.dart';
import 'package:flutter/material.dart';

/// {@template default_auth_error_state_handler}
/// Default implementation of [AuthErrorStateHandler].
/// {@endtemplate}
class DefaultAuthErrorStateHandler implements AuthErrorStateHandler {
  /// {@macro default_auth_error_state_handler}
  DefaultAuthErrorStateHandler({
    required this.context,
  });

  /// The [BuildContext] of the widget that is using this handler.
  final BuildContext context;

  @override
  void invalid2faCode(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informInvalid2FACode,
      actionLabel: context.localization.actionTryAgain,
    );
  }

  @override
  void onAccountUnavailable(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informDeactivatedAccount,
      actionLabel: context.localization.actionTryAgain,
    );
  }

  @override
  void onExpiredAccount(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informExpiredAccount,
      actionLabel: context.localization.actionTryAgain,
    );
  }

  @override
  void onFailedAuthorization(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informFailedAuthorization,
      actionLabel: context.localization.actionTryAgain,
    );
  }

  @override
  void onInavlidResidence(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informInvalidResidence,
      actionLabel: context.localization.actionTryAgain,
    );
  }

  @override
  void onInvalidCredentials(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informInvalidCredentials,
      actionLabel: context.localization.actionTryAgain,
    );
  }

  @override
  void onMissingOtp(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informMissingOtp,
      actionLabel: context.localization.actionTryAgain,
    );
  }

  @override
  void onSelfClosed(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informSelfClosed,
      actionLabel: context.localization.actionTryAgain,
    );
  }

  @override
  void onUnexpectedError(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informUnexpectedError,
      actionLabel: context.localization.actionTryAgain,
    );
  }

  @override
  void onUnsupportedCountry(DerivAuthErrorState state) {
    showErrorDialog(
      context: context,
      errorMessage: context.localization.informUnsupportedCountry,
      actionLabel: context.localization.actionTryAgain,
    );
  }
}
