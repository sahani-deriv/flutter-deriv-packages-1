import 'package:deriv_auth/features/auth/cubit/deriv_auth_cubit.dart';
import 'package:deriv_auth/features/login/presentation/layouts/deriv_login_layout.dart';
import 'package:deriv_auth/features/single_entry/core/auth_data.dart';
import 'package:deriv_auth/features/single_entry/features/home/pages/home_page.dart';
import 'package:deriv_auth/features/single_entry/features/reset_pass/pages/reset_pass_page.dart';
import 'package:deriv_auth/features/single_entry/features/signup/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    BlocProvider.of<DerivAuthCubit>(context).logout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => DerivLoginLayout(
        welcomeLabel: AuthData().data.loginPageModel.welcomeLabel,
        greetingLabel: AuthData().data.loginPageModel.greetingLabel,
        onLoggedIn: (_) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        ),
        authErrorStateHandler:
            AuthData().data.loginPageModel.authErrorStateHandler,
        onLoginError: AuthData().data.loginPageModel.onLoginError,
        onResetPassTapped: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResetPassPage(),
          ),
        ),
        onSignupTapped: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignupPage(),
          ),
        ),
        onSocialAuthButtonPressed:
            AuthData().data.loginPageModel.onSocialAuthButtonPressed,
      );
}
