import 'package:deriv_auth/features/single_entry/core/models/get_started_page_model.dart';
import 'package:deriv_auth/features/single_entry/core/models/login_page_model.dart';

///
class AuthEntryModel {
  ///
  const AuthEntryModel({
    required this.getStartedPage,
    required this.loginPageModel,
  });

  /// GetStartedPage data model
  final GetStartedPageModel getStartedPage;

  /// LoginPage data model
  final LoginPageModel loginPageModel;
}
