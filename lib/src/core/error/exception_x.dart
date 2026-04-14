import 'package:mobile_app/src/core/utils/typedef.dart';

import '../api/models/api_exception.dart';
import 'failure.dart';

extension ExceptionX on Exception {
  Failure toFailure({required String source}) {
    final e = this;
    if (e is ApiException) {
      final data = e.response?.data as DataMap?;
      String? message;
      try {
        message = data?['message'];
      } catch (_) {
        message = null;
      }
      return Failure.api(
        message: message,
        data: data,
        type: FailureType.values.byName(
          data?['type'] ?? 'snackbar',
        ),
        source: source,
      );
    }
    if (e is FormatException || e is TypeError) {
      return Failure.parse(source: source);
    }
    return Failure.base(source: source);
  }
}
