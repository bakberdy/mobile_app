import '../api/models/api_exception.dart';
import 'failure.dart';

extension ExceptionX on Exception {
  Failure toFailure({required String source}) {
    final e = this;
    if (e is ApiException) {
      String? message;
      try {
        message = e.response?.data['message'];
      } catch (_) {
        message = null;
      }
      return Failure.api(
        message: message,
        data: e.response?.data,
        type: FailureType.values.byName(
          e.response?.data?['type'] ?? 'snackbar',
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
