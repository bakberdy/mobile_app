/// Constants for analytics event names.
/// Group: navigation, session, auth, content, actions, errors.
abstract final class AnalyticsEventNames {
  // ── Navigation ────────────────────────────────────────────
  static const String screenViewed = 'screen_viewed';
  static const String screenClosed = 'screen_closed';
  static const String screenReplaced = 'screen_replaced';
  static const String screenRemoved = 'screen_removed';
  static const String screenBecameVisible = 'screen_became_visible';
  static const String tabChanged = 'tab_changed';
  static const String tabInitialized = 'tab_initialized';
  static const String navigationGestureStarted = 'navigation_gesture_started';
  static const String navigationGestureStopped = 'navigation_gesture_stopped';

  // ── App lifecycle ─────────────────────────────────────────
  static const String appOpened = 'app_opened';
  static const String sessionStarted = 'session_started';
  static const String sessionEnded = 'session_ended';

  // ── Auth ──────────────────────────────────────────────────
  static const String signUpCompleted = 'sign_up_completed';
  static const String signUpFailed = 'sign_up_failed';
  static const String loginCompleted = 'login_completed';
  static const String loginFailed = 'login_failed';
  static const String loggedOut = 'logged_out';
  static const String passwordResetRequested = 'password_reset_requested';

  // ── User actions ──────────────────────────────────────────
  static const String buttonClicked = 'button_clicked';
  static const String searchPerformed = 'search_performed';
  static const String filterApplied = 'filter_applied';
  static const String sortApplied = 'sort_applied';
  static const String onboardingStepCompleted = 'onboarding_step_completed';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String notificationTapped = 'notification_tapped';

  // ── Content ────────────────────────────────────────────────
  static const String contentViewed = 'content_viewed';
  static const String contentShared = 'content_shared';
  static const String contentSaved = 'content_saved';

  // ── Commerce ──────────────────────────────────────────────
  static const String purchaseStarted = 'purchase_started';
  static const String purchaseCompleted = 'purchase_completed';
  static const String purchaseFailed = 'purchase_failed';

  // ── Errors / Failures (business-impacting) ────────────────
  static const String apiRequestFailed = 'api_request_failed';
  static const String contentLoadFailed = 'content_load_failed';
  static const String searchFailed = 'search_failed';
  static const String formValidationFailed = 'form_validation_failed';
  static const String permissionFailed = 'permission_failed';
}

/// Constants for analytics property keys.
final class AnalyticsPropertyKeys {
  // ── Screen / Navigation ───────────────────────────────────
  static const String screenName = 'screen_name';
  static const String previousScreenName = 'previous_screen_name';
  static const String navigationMethod = 'navigation_method';
  static const String tabName = 'tab_name';
  static const String tabIndex = 'tab_index';

  // ── User ─────────────────────────────────────────────────
  static const String userId = 'user_id';
  static const String authMethod = 'auth_method'; // email, google, apple

  // ── Session ───────────────────────────────────────────────
  static const String sessionId = 'session_id';
  static const String sessionDuration = 'session_duration_ms';
  static const String screenCount = 'screen_count';

  // ── Actions ───────────────────────────────────────────────
  static const String buttonName = 'button_name';
  static const String searchQuery = 'search_query';
  static const String resultCount = 'result_count';
  static const String filterType = 'filter_type';
  static const String sortOrder = 'sort_order';
  static const String notificationType = 'notification_type';
  static const String stepName = 'step_name';
  static const String stepIndex = 'step_index';

  // ── Content ───────────────────────────────────────────────
  static const String contentId = 'content_id';
  static const String contentType = 'content_type';
  static const String viewDuration = 'view_duration_ms';

  // ── Commerce ─────────────────────────────────────────────
  static const String amount = 'amount';
  static const String currency = 'currency';
  static const String itemId = 'item_id';

  // ── Errors ────────────────────────────────────────────────
  static const String errorMessage = 'error_message';
  static const String errorCode = 'error_code';
  static const String endpoint = 'endpoint';
  static const String httpStatusCode = 'http_status_code';
  static const String permissionType = 'permission_type';
  static const String formField = 'form_field';

  // ── Meta ──────────────────────────────────────────────────
  static const String appVersion = 'app_version';
  static const String platform = 'platform';
  static const String timestamp = 'timestamp';
  static const String isUserGesture = 'is_user_gesture';

  static const String failureType = 'failure_type';
  static const String failureMessage = 'failure_message';
  static const String failureSource = 'failure_source';
}

class AnalyticsEvent {
  final String name;
  final Map<String, dynamic>? properties;

  const AnalyticsEvent({required this.name, this.properties});
}
