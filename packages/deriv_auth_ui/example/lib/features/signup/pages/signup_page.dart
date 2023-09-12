import 'package:deriv_auth_ui/deriv_auth_ui.dart';
import 'package:example/features/login/pages/login_page.dart';
import 'package:example/features/signup/pages/verify_email_page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) => DerivSignupLayout(
        signupPageLabel: 'Start trading with Deriv',
        signupPageDescription:
            'Join over 1 million traders worldwide who loves trading at Deriv.',
        onSocialAuthButtonPressed: (_) {},
        onSingupError: (_) {},
        onSingupEmailSent: (email) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyEmailPage(email: email),
            ),
          );
        },
        onSignupPressed: () {},
        onLoginTapped: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        ),
      );
}