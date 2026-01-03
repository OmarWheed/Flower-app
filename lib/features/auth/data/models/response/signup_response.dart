import 'package:flower_app/features/auth/data/models/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'signup_response.g.dart';

@JsonSerializable()
class SignupResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? userDto;
  @JsonKey(name: "token")
  final String? token;

  SignupResponse ({
    this.message,
    this.userDto,
    this.token,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => _$SignupResponseFromJson(json);


  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}



