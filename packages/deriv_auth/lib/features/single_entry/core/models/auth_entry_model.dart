import 'package:deriv_auth/deriv_auth.dart';
import 'package:deriv_auth/features/single_entry/core/models/signup_page_model.dart';

///
class AuthEntryModel {
  ///
  const AuthEntryModel({
    required this.getStartedPage,
    required this.loginPageModel,
    required this.derivAuthCubit,
    required this.signupPageModel,
  });

  /// GetStartedPage data model
  final GetStartedPageModel getStartedPage;

  /// LoginPage data model
  final LoginPageModel loginPageModel;

  /// DerivAuthCubit
  final DerivAuthCubit derivAuthCubit;

  /// SignupPage data model
  final SignupPageModel signupPageModel;
}
