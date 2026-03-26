import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

import '../analytics/analytics.dart';
import '../analytics/analytics_events.dart';

@lazySingleton
class AnalyticsPageObserver implements AutoRouteObserver {
  final Map<Route<dynamic>, DateTime> _screenStartTimes = {};

  int _durationMs(Route<dynamic> route) {
    final start = _screenStartTimes.remove(route);
    if (start == null) return 0;
    return DateTime.now().difference(start).inMilliseconds;
  }

  String _getScreenName(Route<dynamic>? route) {
    if (route?.settings.name == null || route!.settings.name!.isEmpty) {
      return 'unknown_screen';
    }

    String name = route.settings.name!;

    if (name.startsWith('/')) {
      name = name.substring(1);
    }

    if (name.endsWith('Route')) {
      name = name.substring(0, name.length - 5);
    }

    name = name.replaceAllMapped(
      RegExp(r'([a-z])([A-Z])'),
      (match) => '${match.group(1)}_${match.group(2)!.toLowerCase()}',
    );

    name = name.replaceAll('/', '_').toLowerCase();

    return name.isEmpty ? 'home' : name;
  }

  String _getTabName(TabPageRoute route) {
    return route.name.replaceAll('Route', '').replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (match) => '${match.group(1)}_${match.group(2)!.toLowerCase()}',
        ).toLowerCase();
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _screenStartTimes[route] = DateTime.now();

    final screenName = _getScreenName(route);
    final previousScreenName = _getScreenName(previousRoute);

    Analytics.track(
      AnalyticsEvent(
        name: AnalyticsEventNames.screenViewed,
        properties: {
          AnalyticsPropertyKeys.screenName: screenName,
          AnalyticsPropertyKeys.previousScreenName: previousScreenName,
          AnalyticsPropertyKeys.navigationMethod: 'push',
          AnalyticsPropertyKeys.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final duration = _durationMs(route);
    final screenName = _getScreenName(route);
    final previousScreenName = _getScreenName(previousRoute);

    Analytics.track(
      AnalyticsEvent(
        name: AnalyticsEventNames.screenClosed,
        properties: {
          AnalyticsPropertyKeys.screenName: screenName,
          AnalyticsPropertyKeys.previousScreenName: previousScreenName,
          AnalyticsPropertyKeys.navigationMethod: 'pop',
          AnalyticsPropertyKeys.viewDuration: duration,
          AnalyticsPropertyKeys.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final duration = oldRoute != null ? _durationMs(oldRoute) : 0;
    if (newRoute != null) _screenStartTimes[newRoute] = DateTime.now();

    final newScreenName = _getScreenName(newRoute);
    final oldScreenName = _getScreenName(oldRoute);

    Analytics.track(
      AnalyticsEvent(
        name: AnalyticsEventNames.screenReplaced,
        properties: {
          AnalyticsPropertyKeys.screenName: newScreenName,
          AnalyticsPropertyKeys.previousScreenName: oldScreenName,
          AnalyticsPropertyKeys.navigationMethod: 'replace',
          AnalyticsPropertyKeys.viewDuration: duration,
          AnalyticsPropertyKeys.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final duration = _durationMs(route);
    final screenName = _getScreenName(route);
    final previousScreenName = _getScreenName(previousRoute);

    Analytics.track(
      AnalyticsEvent(
        name: AnalyticsEventNames.screenRemoved,
        properties: {
          AnalyticsPropertyKeys.screenName: screenName,
          AnalyticsPropertyKeys.previousScreenName: previousScreenName,
          AnalyticsPropertyKeys.navigationMethod: 'remove',
          AnalyticsPropertyKeys.viewDuration: duration,
          AnalyticsPropertyKeys.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );
  }

  @override
  void didChangeTop(
    Route<dynamic> topRoute,
    Route<dynamic>? previousTopRoute,
  ) {
    final screenName = _getScreenName(topRoute);
    final previousScreenName = _getScreenName(previousTopRoute);

    Analytics.track(
      AnalyticsEvent(
        name: AnalyticsEventNames.screenBecameVisible,
        properties: {
          AnalyticsPropertyKeys.screenName: screenName,
          AnalyticsPropertyKeys.previousScreenName: previousScreenName,
          AnalyticsPropertyKeys.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    final tabName = _getTabName(route);
    final previousTabName = _getTabName(previousRoute);

    Analytics.track(
      AnalyticsEvent(
        name: AnalyticsEventNames.tabChanged,
        properties: {
          AnalyticsPropertyKeys.tabName: tabName,
          AnalyticsPropertyKeys.previousScreenName: previousTabName,
          AnalyticsPropertyKeys.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    final tabName = _getTabName(route);
    final previousTabName = previousRoute != null ? _getTabName(previousRoute) : 'none';

    Analytics.track(
      AnalyticsEvent(
        name: AnalyticsEventNames.tabInitialized,
        properties: {
          AnalyticsPropertyKeys.tabName: tabName,
          AnalyticsPropertyKeys.previousScreenName: previousTabName,
          AnalyticsPropertyKeys.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );
  }

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) {
    final screenName = _getScreenName(route);
    final previousScreenName = _getScreenName(previousRoute);

    Analytics.track(
      AnalyticsEvent(
        name: AnalyticsEventNames.navigationGestureStarted,
        properties: {
          AnalyticsPropertyKeys.screenName: screenName,
          AnalyticsPropertyKeys.previousScreenName: previousScreenName,
          AnalyticsPropertyKeys.isUserGesture: true,
          AnalyticsPropertyKeys.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );
  }

  @override
  void didStopUserGesture() {
    Analytics.track(
      AnalyticsEvent(
        name: AnalyticsEventNames.navigationGestureStopped,
        properties: {
          AnalyticsPropertyKeys.isUserGesture: true,
          AnalyticsPropertyKeys.timestamp: DateTime.now().toIso8601String(),
        },
      ),
    );
  }

  @override
  NavigatorState? get navigator => null;

  @override
  void subscribe(AutoRouteAware routeAware, RouteData<dynamic> route) {
    // Not used for basic route observation
  }

  @override
  void unsubscribe(AutoRouteAware routeAware) {
    // Not used for basic route observation
  }
}
