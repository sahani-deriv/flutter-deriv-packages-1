import 'package:deriv_auth/features/get_started/presentation/layouts/deriv_get_started_layout.dart';
import 'package:deriv_auth/features/single_entry/core/auth_data.dart';
import 'package:deriv_auth/features/single_entry/features/login/pages/login_page.dart';
import 'package:deriv_auth/features/single_entry/features/settings/pages/settings_page.dart';
import 'package:deriv_auth/features/single_entry/features/signup/pages/signup_page.dart';
import 'package:flutter/material.dart';

///
class GetStartedPage extends StatelessWidget {
  ///
  const GetStartedPage();

  ///

  @override
  Widget build(BuildContext context) => DerivGetStartedLayout(
        slides: AuthData().data.slides,
        appLogoIconPath: AuthData().data.appLogoIconPath,
        backgroundImagePath: AuthData().data.backgroundImagePath,
        onLoginTapped: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        ),
        onSignupTapped: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        ),
        onTapNavigation: () {
          Navigator.push(
            context,
            MaterialPageRoute<Widget>(
              builder: (BuildContext context) => const SettingsPage(),
            ),
          );
        },
      );
}
