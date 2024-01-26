import 'package:deriv_auth/deriv_auth.dart';
import 'package:deriv_auth/features/single_entry/core/auth_data.dart';
import 'package:deriv_auth/features/single_entry/features/get_started/pages/get_started_page.dart';
import 'package:flutter/material.dart';

///
class AuthEntryPage extends StatelessWidget {
  ///
  AuthEntryPage(AuthEntryModel entryData) {
    AuthData().data = entryData;
  }

  @override
  Widget build(BuildContext context) => const GetStartedPage();
}
