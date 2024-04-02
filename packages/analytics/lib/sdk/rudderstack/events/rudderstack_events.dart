import 'package:analytics/sdk/rudderstack/core/rudderstack_configuration.dart';
import 'package:analytics/sdk/rudderstack/sdk/deriv_rudderstack_sdk.dart';

/// Class which hold events which should be monitored.
class DerivRudderstackEvents {
  /// Constructor for [DerivRudderstackEvents].
  const DerivRudderstackEvents();

  ///Set ups Rudderstack connection.
  void setup({required String dataPlaneUrl, required String writeKey}) {
    DerivRudderstack().setup(
      RudderstackConfiguration(dataPlaneUrl: dataPlaneUrl, writeKey: writeKey),
    );
  }

  /// Captures app_open event when the app is opened.
  void logAppOpened() {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'open',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Captures user tap on Log in button on sign up screen.
  void logUserTappedLoginButton() {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'go_to_login',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Captures user tap on Get free account button on sign up screen.
  void logAppGetFreeAccount(String slideName) {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'get_free_account',
      'form_source': 'mobile_derivgo',
      'getstarted_slide_name':
          '${slideName.substring(slideName.indexOf('.') + 1, slideName.length)}',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Tracks when user turns on or off Refferal toggle switcher.
  void logReferralToggleSwitched() {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'tab_referral_toggle',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Tracks when user gets Invalid referral code pop up with Try again button.
  void logTryAgainReferralCode() {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'try_again_referral_code',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Tracks when Email confirmation is sent to a user.
  void logEmailConfirmationSent() {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'email_confirmation_sent',
      'signup_provider': 'email',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Tracks when user land on Successfull email verification screen.
  void logEmailConfirmed() {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'email_confirmed',
      'signup_provider': 'email',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Tracks when user taps Continue button on Successfull email verification screen.
  void logSignupContinued() {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'signup_continued',
      'signup_provider': 'email',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Tracks when user lands on Country selection screen.
  void logCountrySelectionPageOpened() {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'country_selection_screen_opened',
      'signup_provider': 'email',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Tracks when user lands on Create password page while creating demo account.
  void logSetPasswordPageOpened() {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'password_screen_opened',
      'signup_provider': 'email',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Tracks when user's sign up is finished.
  void logSignUpDone(String signupProvider) {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'signup_done',
      'signup_provider': '$signupProvider',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }

  /// Tracks when user taps 'Create free demo account' or social log in button.
  void logSignUpPageAction(String signupProvider,
      [bool? isToggleOn, String? referralCode]) {
    DerivRudderstack().track(eventName: 'ce_virtual_signup_form', properties: {
      'action': 'started',
      'signup_provider': '$signupProvider',
      'referral_toggle_mode': '${isToggleOn ?? false} ',
      'referral_code': '$referralCode',
      'form_source': 'mobile_derivgo',
      'form_name': 'virtual_signup_derivgo'
    });
  }
}
