import 'package:equatable/equatable.dart';

class LoginViewState with EquatableMixin {
  final bool isLoading;
  final String successMessage;
  final String errorMessage;

  LoginViewState({
    this.isLoading = false,
    this.errorMessage = "",
    this.successMessage = "",
  });

  factory LoginViewState.initial() => LoginViewState();

  LoginViewState copyWith({
    bool? isLoading,
    String? successMessage,
    String? errorMessage,
  }) => LoginViewState(
    isLoading: isLoading ?? false,
    successMessage: successMessage ?? "",
    errorMessage: errorMessage ?? "",
  );

  @override
  List<Object?> get props => [isLoading, successMessage, errorMessage];
}
