import 'package:deriv_auth/deriv_auth.dart';

/// {@template auth_state_listener}
/// An abstract class that represents all the possible case of the
/// [DerivAuthErrorState]. Each method will be called when the corresponding
/// error state is emitted and can be implemented by the client app to handle
/// the error. This class is also to make sure that each error case is handled.
/// {@endtemplate}
abstract class AuthErrorStateHandler {
  /// {@macro auth_state_listener}

  /// User has set up 2FA and needs to enter 2FA.
  void onMissingOtp(DerivAuthErrorState state);

  /// Account is self closed.
  void onSelfClosed(DerivAuthErrorState state);

  /// Account is not supported in the country.
  void onUnsupportedCountry(DerivAuthErrorState state);

  /// Invalid credentials.
  void onInvalidCredentials(DerivAuthErrorState state);

  /// Account is unavailable.
  void onAccountUnavailable(DerivAuthErrorState state);

  /// Invalid 2FA code.
  void invalid2faCode(DerivAuthErrorState state);

  /// Failed authorization.
  void onFailedAuthorization(DerivAuthErrorState state);

  /// User is trying to authenticate from an unsupported residence.
  void onInavlidResidence(DerivAuthErrorState state);

  /// User is trying to authenticate from an expired account.
  void onExpiredAccount(DerivAuthErrorState state);

  /// Default error handler for unexpected case.
  void onUnexpectedError(DerivAuthErrorState state);
}
