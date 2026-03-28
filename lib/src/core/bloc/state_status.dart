enum StateStatus { error, success, loading, initial }

extension StateStatusX on StateStatus {
  bool get isLoading => this == StateStatus.loading;
  bool get isSuccess => this == StateStatus.success;
  bool get isError => this == StateStatus.error;
  bool get isInitial => this == StateStatus.initial;
}
