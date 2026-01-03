import 'package:equatable/equatable.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/features/auth/domain/entities/user_entity.dart';

class SignupStates extends Equatable {
  final BaseState<UserEntity>? signUpState;
  final String? selectedGender;
  const SignupStates({this.signUpState, this.selectedGender});
  @override
  List<Object?> get props => [signUpState, selectedGender];
  SignupStates copyWith({
    BaseState<UserEntity>? signUpState,
    String? selectedGender,
  }) {
    return SignupStates(
      signUpState: signUpState ?? this.signUpState,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }
}
