class ForgetPasswordState {
  final bool? isLoading;
  final String? error;
  final String? message;
  final int resendRemainingSeconds;

  const ForgetPasswordState({
    this.isLoading = false,
    this.error,
    this.message,
    this.resendRemainingSeconds = 30,
  });

  ForgetPasswordState copyWith({
    bool? isLoading,
    String? error,
    String? message,
    int? resendRemainingSeconds,
  }) {
    return ForgetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      message: message ?? this.message,
      resendRemainingSeconds:
          resendRemainingSeconds ?? this.resendRemainingSeconds,
    );
  }
}