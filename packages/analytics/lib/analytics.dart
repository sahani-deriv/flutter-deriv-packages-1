import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_segment/flutter_segment.dart';

import 'analytics_route_observer.dart';

const ENABLE_ANALYTICS = bool.fromEnvironment('dart.vm.product');

class Analytics {
  static final Analytics instance = Analytics._internal();
  List ignoredRoutes = [];

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

  Future logLoginEvent(int userId) async {
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

  void _setSegmentDeviceToken(String deviceToken) async =>
      await Segment.setContext({
        'device': {'token': deviceToken},
      });

  Future _setFirebaseUserId(String userId) async =>
      await fbAnalytics?.setUserId(userId);

  Future logToFirebase(
      {@required String name, Map<String, dynamic> params}) async =>
      await fbAnalytics?.logEvent(
        name: name,
        parameters: params,
      );

  void setIgnoredRoutes(List routes) {
    ignoredRoutes = routes;
  }
}
