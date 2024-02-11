/// Sign-up page model
class SignupPageModel {
  /// Constructor [SignupPageModel]
  SignupPageModel({
    required this.verificationCode,
    required this.signupPageLable,
    required this.signupPageDescription,
    required this.isSocialAuthEnabled,
    this.affiliateToken,
  });

  /// verification code
  final String verificationCode;

  /// affiliate token
  final String? affiliateToken;

  /// sing-up page label
  final String signupPageLable;

  /// sign-up page description
  final String signupPageDescription;

  /// is social auth enabled
  final bool isSocialAuthEnabled;
}
