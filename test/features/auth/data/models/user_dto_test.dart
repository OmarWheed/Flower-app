import 'package:flower_app/features/auth/data/models/user_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserDto userDto;
  setUpAll(() {
    userDto = UserDto(
      firstName: null,
      lastName: null,
      email: null,
      phone: null,
      id: null,
      role: null,
      createdAt: null,
      photo: null,
      wishlist: null,
      addresses: null,
    );
  });
  test(
    'test toEntity with null value it should return UserEntity with null value',
        () {
      final result = userDto.toEntity();
      expect(result.id, equals(userDto.id));
      expect(result.gender, isNull);
      expect(result.firstName, isNull);
      expect(result.lastName, isNull);
      expect(result.email, isNull);
      expect(result.phone, isNull);
      expect(result.role, isNull);
      expect(result.photo, isNull);
      expect(result.addresses, isNull);

    },
  );
  test('test toEntity with true value it should return UserEntity with true value', () {
    final result = userDto.toEntity();
    expect(result.id, equals(userDto.id));
    expect(result.gender, equals(userDto.gender));
    expect(result.firstName, equals(userDto.firstName));
    expect(result.lastName, equals(userDto.lastName));
    expect(result.email, equals(userDto.email));
    expect(result.phone, equals(userDto.phone));
    expect(result.role, equals(userDto.role));
    expect(result.addresses, equals(userDto.addresses));
    expect(result.photo, equals(userDto.photo));
  });
}
