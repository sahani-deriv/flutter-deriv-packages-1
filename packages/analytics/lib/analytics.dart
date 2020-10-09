import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_segment/flutter_segment.dart';

import 'analytics_route_observer.dart';

const ENABLE_ANALYTICS = bool.fromEnvironment('dart.vm.product');

class Analytics {
  static final Analytics instance = Analytics._internal();
  static const ignoredRoutes = [];

  Analytics._internal();

  FirebaseAnalytics fbAnalytics;
  AnalyticsRouteObserver observer;
  bool _loggedIn = false;

  void init({String deviceToken}) {
    fbAnalytics = FirebaseAnalytics();
    observer = AnalyticsRouteObserver(onNewRoute: _newRouteHandler);

    // Enable or disable the analytics on this device.
    fbAnalytics.setAnalyticsCollectionEnabled(ENABLE_ANALYTICS);
    ENABLE_ANALYTICS ? Segment.enable() : Segment.disable();

    if (deviceToken != null) _setSegmentDeviceToken(deviceToken);
  }

  void _newRouteHandler(PageRoute route) {
    this.setCurrentScreen(
      screenName: route.settings.name,
      properties: route.settings.arguments ?? {},
    );
  }

  void logAppOpened() async {
    await fbAnalytics?.logAppOpen();
    if (_loggedIn) await Segment.track(eventName: 'Application Opened');
  }

  void logAppBackgrounded() async {
    if (_loggedIn) await Segment.track(eventName: 'Application Backgrounded');
  }

  void logAppCrashed() async {
    if (_loggedIn) await Segment.track(eventName: 'Application Crashed');
  }

  void setCurrentScreen({
    @required String screenName,
    Map<String, dynamic> properties = const {},
  }) async {
    if (screenName == null || ignoredRoutes.contains(screenName)) return;

    await fbAnalytics?.setCurrentScreen(screenName: screenName);

    if (_loggedIn)
      await Segment.screen(
        screenName: screenName,
        properties: properties,
      );
  }

  void logLoginEvent(int userId) async {
    _loggedIn = true;

    _setFirebaseUserId(userId.toString());

    await fbAnalytics?.logLogin();
    // TODO: add traits if needed such as user-name, email, etc.
    await Segment.identify(
      userId: userId.toString(),
    );
  }

  void logLogoutEvent() async {
    await fbAnalytics?.logEvent(name: 'logout');

    _loggedIn = false;
  }

  void logCreateAdEvent({String id}) async => await fbAnalytics?.logEvent(
        name: 'ad_created',
        parameters: <String, dynamic>{'ad_id': id},
      );

  void logDeleteAdEvent({String adId}) async => await fbAnalytics?.logEvent(
        name: 'ad_deleted',
        parameters: <String, dynamic>{'ad_id': adId},
      );

  void logBuyerConfirmOrderEvent({String orderId}) async =>
      await fbAnalytics?.logEvent(
        name: 'buyer_order_confirmed',
        parameters: <String, dynamic>{'order_id': orderId},
      );

  void logBuyerCancelOrderEvent({String orderId}) async =>
      await fbAnalytics?.logEvent(
        name: 'buyer_order_cancelled',
        parameters: <String, dynamic>{'order_id': orderId},
      );

  void logAdvertiserConfirmOrderEvent({
    String orderId,
    String status,
    String type,
  }) async =>
      await fbAnalytics?.logEvent(
        name: 'advertiser_order_confirmed',
        parameters: <String, dynamic>{
          'order_id': orderId,
          'status': status,
          'type': type
        },
      );

  void logAdvertiserListingStatus({bool isListed}) async =>
      await fbAnalytics?.logEvent(
        name: 'advertiser_listing_status',
        parameters: <String, dynamic>{'is_listed': isListed},
      );

  void _setSegmentDeviceToken(String deviceToken) async =>
      await Segment.setContext({
        'device': {'token': deviceToken},
      });

  void _setFirebaseUserId(String userId) async =>
      await fbAnalytics?.setUserId(userId);
}
