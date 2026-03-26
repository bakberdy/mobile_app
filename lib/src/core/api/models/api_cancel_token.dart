import 'package:dio/dio.dart';

class ApiCancelToken {
  final _inner = CancelToken();

  void cancel([String? reason]) => _inner.cancel(reason);

  bool get isCancelled => _inner.isCancelled;

  CancelToken get nativeCancelToken => _inner;
}
