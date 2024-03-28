import 'dart:async';
import 'dart:developer' as logger;

import 'package:flutter/services.dart';

/// DerivRudderstack plugin handles initialising and setting up RudderStack
/// client and handles logging various analytical events.
class DerivRudderstack {
  static const MethodChannel _channel = MethodChannel('deriv_rudderstack');

  /// Call `identify` to track the users across the application installation.
  /// It requires [userId] and an optional map of [traits] for extra details.
  Future<bool> identify(
      {required String userId, Map<String, dynamic>? traits}) async {
    try {
      final bool response =
          await _channel.invokeMethod<dynamic>('identify', <String, dynamic>{
        'userId': userId,
        'traits': traits ?? <String, dynamic>{},
      });

      return response;
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
  }

  /// Call `track` to record the users' activity. It requires the [eventName]
  /// and an optional [properties] map for extra details.
  Future<bool> track(
      {required String eventName, Map<String, dynamic>? properties}) async {
    try {
      final bool response =
          await _channel.invokeMethod<dynamic>('track', <String, dynamic>{
        'eventName': eventName,
        'properties': properties ?? <String, dynamic>{},
      });
      return response;
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
  }

  /// You can use the `screen` call to record whenever the user sees a screen
  /// on the mobile device. It requires [screenName] an optional
  /// [properties] map for extra details.
  Future<bool> screen(
      {required String screenName, Map<String, dynamic>? properties}) async {
    try {
      final bool response =
          await _channel.invokeMethod<dynamic>('screen', <String, dynamic>{
        'screenName': screenName,
        'properties': properties ?? <String, dynamic>{},
      });

      return response;
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
  }

  /// The `group` call associates a user to a specific organization. It requires
  /// [groupId] and an optional [traits] map for extra details.
  Future<bool> group(
      {required String groupId, Map<String, dynamic>? traits}) async {
    try {
      final bool response =
          await _channel.invokeMethod<dynamic>('group', <String, dynamic>{
        'groupId': groupId,
        'traits': traits ?? <String, dynamic>{},
      });

      return response;
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
  }

  /// The `alias` call associates the user with a new identification. It requires
  /// [alias] value.
  Future<bool> alias({required String alias}) async {
    try {
      final bool response =
          await _channel.invokeMethod<dynamic>('alias', <String, dynamic>{
        'alias': alias,
      });

      return response;
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
  }

  /// The `setup` initialize the rudderStack client.
  Future<bool> setup() async {
    try {
      final bool response = await _channel.invokeMethod<dynamic>('setup');
      return response;
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
  }

  /// Use the `reset` call to clear the persisted traits for the identify call.
  /// This is required for Logout operations.
  Future<bool> reset() async {
    try {
      final bool response = await _channel.invokeMethod<dynamic>('reset');

      return response;
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
  }

  /// Call `disable` to disable sending rudder stack events.
  Future<bool> disable() async {
    try {
      return await _channel.invokeMethod<dynamic>('disable');
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
  }

  /// Call `enable` too enable sending rudder stack events.
  Future<bool> enable() async {
    try {
      return await _channel.invokeMethod<dynamic>('enable');
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
  }

  /// Call `setContext` to support sending push notification to the destinations
  /// that support Push Notification. It requires [token] value.
  Future<bool> setContext({required String token}) async {
    try {
      final bool response =
          await _channel.invokeMethod<dynamic>('setContext', <String, dynamic>{
        'pushToken': token,
      });

      return response;
    } on PlatformException catch (e) {
      logger.log('${(DerivRudderstack).toString()}: ${e.message}');
    }

    return false;
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
