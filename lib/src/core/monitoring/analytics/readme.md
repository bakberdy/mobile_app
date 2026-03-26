# Analytics

A lightweight, provider-agnostic analytics layer. Events are tracked once and fanned out to all registered providers (Firebase, Mixpanel, etc.) simultaneously.

---

## Architecture

```
Analytics.track(event)
    ├── FirebaseAnalyticsProvider
    ├── MixpanelAnalyticsProvider
    └── ConsoleAnalyticsProvider  ← dev/debug only
```

| File | Purpose |
|---|---|
| `analytics.dart` | Static facade — `Analytics.track()`, `setUserId()`, `setUserProperty()` |
| `analytics_events.dart` | `AnalyticsEventNames`, `AnalyticsPropertyKeys`, `AnalyticsEvent` |
| `providers/` | One file per analytics platform |

---

## Setup

Register providers once at app startup in `main.dart`:

```dart
Analytics.initialize(
  [
    ConsoleAnalyticsProvider(),       // dev builds only
    FirebaseAnalyticsProvider(),
    MixpanelAnalyticsProvider(mixpanel),
  ],
  enableAnalytics: !kDebugMode,       // disable in debug if preferred
);
```

Set the user identity after login:

```dart
await Analytics.setUserId(user.id);
await Analytics.setUserProperty({
  AnalyticsPropertyKeys.authMethod: 'google',
  AnalyticsPropertyKeys.appVersion: packageInfo.version,
  AnalyticsPropertyKeys.platform: Platform.operatingSystem,
});
```

Clear identity on logout:

```dart
await Analytics.setUserId(null);
```

---

## Tracking Events

### Minimal event

```dart
Analytics.track(
  AnalyticsEvent(name: AnalyticsEventNames.appOpened),
);
```

### Event with properties

```dart
Analytics.track(
  AnalyticsEvent(
    name: AnalyticsEventNames.buttonClicked,
    properties: {
      AnalyticsPropertyKeys.buttonName: 'continue',
      AnalyticsPropertyKeys.screenName: 'onboarding',
      AnalyticsPropertyKeys.stepIndex: '1'
    },
  ),
);
```

### Tracking from a BLoC (recommended pattern)

Track business outcomes in the BLoC, not in the repository:

```dart
on<LoginSubmitted>((event, emit) async {
  final result = await _authRepository.login(event.email, event.password);

  result.fold(
    (failure) {
      Analytics.track(AnalyticsEvent(
        name: AnalyticsEventNames.loginFailed,
        properties: {
          AnalyticsPropertyKeys.errorMessage: failure.message,
          AnalyticsPropertyKeys.authMethod: 'email',
        },
      ));
      emit(LoginError(failure));
    },
    (user) {
      Analytics.track(AnalyticsEvent(
        name: AnalyticsEventNames.loginCompleted,
        properties: {
          AnalyticsPropertyKeys.authMethod: 'email',
          AnalyticsPropertyKeys.userId: user.id,
        },
      ));
      Analytics.setUserId(user.id);
      emit(LoginSuccess(user));
    },
  );
});
```

---

## Screen Tracking

Screen views are tracked automatically via `AnalyticsPageObserver` — no manual calls needed.

Register the observer in your router:

```dart
AutoRouter(
  navigatorObservers: () => [getIt<AnalyticsPageObserver>()],
)
```

Each navigation event sends:

| Event | Triggered by | Includes `view_duration_ms`? |
|---|---|---|
| `screen_viewed` | push | no |
| `screen_closed` | pop | ✅ |
| `screen_replaced` | replace | ✅ (time on old screen) |
| `screen_removed` | programmatic remove | ✅ |
| `screen_became_visible` | top route change | no |
| `tab_changed` | tab switch | no |

---

## Event Reference

### Event Names — `AnalyticsEventNames`

| Constant | Value | When to send |
|---|---|---|
| `appOpened` | `app_opened` | App cold/warm start |
| `sessionStarted` | `session_started` | User becomes active |
| `sessionEnded` | `session_ended` | App backgrounded / closed |
| `screenViewed` | `screen_viewed` | Auto via observer |
| `screenClosed` | `screen_closed` | Auto via observer |
| `tabChanged` | `tab_changed` | Auto via observer |
| `loginCompleted` | `login_completed` | Successful auth |
| `loginFailed` | `login_failed` | Failed auth attempt |
| `signUpCompleted` | `sign_up_completed` | New account created |
| `signUpFailed` | `sign_up_failed` | Registration error |
| `loggedOut` | `logged_out` | User signs out |
| `buttonClicked` | `button_clicked` | Key CTA taps |
| `searchPerformed` | `search_performed` | Search submitted |
| `searchFailed` | `search_failed` | No results / error |
| `filterApplied` | `filter_applied` | Filter changed |
| `onboardingStepCompleted` | `onboarding_step_completed` | Each onboarding step |
| `onboardingCompleted` | `onboarding_completed` | Onboarding finished |
| `contentViewed` | `content_viewed` | Detail screen opened |
| `contentShared` | `content_shared` | Share action |
| `contentSaved` | `content_saved` | Bookmark / save |
| `purchaseStarted` | `purchase_started` | Payment flow entered |
| `purchaseCompleted` | `purchase_completed` | Payment success |
| `purchaseFailed` | `purchase_failed` | Payment failed |
| `apiRequestFailed` | `api_request_failed` | Business-impacting API error |
| `contentLoadFailed` | `content_load_failed` | Screen failed to load data |
| `formValidationFailed` | `form_validation_failed` | User hit a form error |
| `permissionFailed` | `permission_failed` | OS permission denied |

### Property Keys — `AnalyticsPropertyKeys`

| Constant | Value | Type |
|---|---|---|
| `screenName` | `screen_name` | `String` |
| `previousScreenName` | `previous_screen_name` | `String` |
| `viewDuration` | `view_duration_ms` | `int` |
| `userId` | `user_id` | `String` |
| `authMethod` | `auth_method` | `String` (email / google / apple) |
| `buttonName` | `button_name` | `String` |
| `searchQuery` | `search_query` | `String` |
| `resultCount` | `result_count` | `int` |
| `contentId` | `content_id` | `String` |
| `contentType` | `content_type` | `String` |
| `errorMessage` | `error_message` | `String` |
| `errorCode` | `error_code` | `String` |
| `httpStatusCode` | `http_status_code` | `int` |
| `amount` | `amount` | `num` |
| `currency` | `currency` | `String` (ISO 4217) |
| `appVersion` | `app_version` | `String` |
| `platform` | `platform` | `String` |
| `timestamp` | `timestamp` | `String` (ISO 8601) |

---

## Adding a New Provider

1. Create `providers/my_provider.dart` and implement `AnalyticsProvider`:

```dart
class MyAnalyticsProvider implements AnalyticsProvider {
  @override
  Future<void> track(AnalyticsEvent event) async {
    mySDK.track(event.name, event.properties ?? {});
  }

  @override
  Future<void> setUserId(String? userId) async {
    mySDK.identify(userId);
  }

  @override
  Future<void> setUserProperty(Map<String, dynamic> properties) async {
    mySDK.setUserProperties(properties);
  }
}
```

2. Register it in `main.dart` initialization list — no other changes needed.

---

## What NOT to Track

- **PII** — no emails, full names, or exact coordinates in properties
- **Every tap** — only key actions (CTAs, core features); avoid noise
- **Pure technical errors** — null pointers, crashes → use Sentry/Crashlytics instead
- **High-frequency passive events** — scrolling, hover; sample if needed
