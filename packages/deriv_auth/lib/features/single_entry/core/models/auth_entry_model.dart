import 'package:deriv_auth/deriv_auth.dart';

///
class AuthEntryModel {
  ///
  const AuthEntryModel({
    required this.getStartedPage,
    required this.loginPageModel,
    required this.derivAuthCubit,
  });

  /// GetStartedPage data model
  final GetStartedPageModel getStartedPage;

  /// LoginPage data model
  final LoginPageModel loginPageModel;

  /// DerivAuthCubit
  final DerivAuthCubit derivAuthCubit;
}
