class UserEntity {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final String? id;
  final List<dynamic>? addresses;

  UserEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.id,
    this.addresses,
  });
}
