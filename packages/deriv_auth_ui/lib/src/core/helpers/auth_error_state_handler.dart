import 'package:deriv_auth/deriv_auth.dart';

/// {@template auth_state_listener}
/// An abstract class that represents all the possible case of the
/// [DerivAuthErrorState]. Each method will be called when the corresponding
/// error state is emitted and can be implemented by the client app to handle
/// the error.
/// {@endtemplate}
abstract class AuthErrorStateHandler {
  /// {@macro auth_state_listener}

  /// User has set up 2FA and needs to enter 2FA.
  void onMissingOtp();

  /// Account is self closed.
  void onSelfClosed();

  /// Account is not supported in the country.
  void onUnsupportedCountry();

  /// Invalid credentials.
  void onInvalidCredentials();

  /// Account is unavailable.
  void onAccountUnavailable();

  /// Invalid 2FA code.
  void invalid2faCode();

  /// Failed authorization.
  void onFailedAuthorization();

  /// User is trying to authenticate from an unsupported residence.
  void onInavlidResidence();

  /// User is trying to authenticate from an expired account.
  void onExpiredAccount();

  /// Default error handler for unexpected case.
  void defaultError();
}
