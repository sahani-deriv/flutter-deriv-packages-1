import 'package:deriv_auth/deriv_auth.dart';

///
class GetStartedPageModel {
  ///
  const GetStartedPageModel({
    required this.slides,
    required this.appLogoIconPath,
    required this.backgroundImagePath,
  });

  ///
  final List<DerivGetStartedSlideModel> slides;

  ///
  final String appLogoIconPath;

  ///
  final String backgroundImagePath;
}
