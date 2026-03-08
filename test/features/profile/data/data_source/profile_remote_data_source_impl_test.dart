import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/profile/data/data_source/profile_remote_data_source_impl.dart';
import 'package:flower_app/features/profile/data/models/edit_profile_request.dart';
import 'package:flower_app/features/profile/data/models/get_notifications_response_dto.dart';
import 'package:flower_app/features/profile/data/models/get_user_data_response.dart';
import 'package:flower_app/features/profile/data/models/upload_photo_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  late MockApiClient mockApiClient;
  late ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl;
  late DioException dioException;
  late UserDto userDto;

  setUp(() {
    mockApiClient = MockApiClient();
    profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(mockApiClient);
    dioException = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );
    userDto = UserDto(
      id: "123",
      firstName: "Mohamed",
      lastName: "Kamal",
      email: "test@test.com",
      phone: "+201000000000",
      photo: null,
    );
  });

  group("Get Profile Data Tests", () {
    late GetUserDataResponse getUserDataResponse;

    setUp(() {
      getUserDataResponse = GetUserDataResponse(
        message: "success",
        user: userDto,
      );
    });

    test("Should return Success when API call succeeds", () async {
      // Arrange
      when(
        mockApiClient.getProfileData(),
      ).thenAnswer((_) async => getUserDataResponse);

      // Act
      final result = await profileRemoteDataSourceImpl.getProfileData();

      // Assert
      expect(
        (result as Success).data.user.firstName,
        equals(userDto.firstName),
      );
      // expect((result as SuccessResponse<ResponseLoginDto>).data.token, equals(responseLoginDto.token));

      verify(mockApiClient.getProfileData()).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test("Should return Failure when API call throws exception", () async {
      // Arrange
      when(mockApiClient.getProfileData()).thenThrow(dioException);

      // Act
      final result = await profileRemoteDataSourceImpl.getProfileData();

      // Assert
      expect(result, isA<Failure<GetUserDataResponse>>());
      verify(mockApiClient.getProfileData()).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });
  });

  group("Edit Profile Tests", () {
    late EditProfileRequest editProfileRequest;
    late GetUserDataResponse editProfileResponse;

    setUp(() {
      editProfileRequest = const EditProfileRequest(
        firstName: "Updated",
        lastName: "User",
        email: "updated@test.com",
        phone: "+201000000001",
      );
      editProfileResponse = GetUserDataResponse(
        message: "success",
        user: UserDto(
          id: "123",
          firstName: editProfileRequest.firstName,
          lastName: editProfileRequest.lastName,
          email: editProfileRequest.email,
          phone: editProfileRequest.phone,
          photo: null,
        ),
      );
    });

    test("Should return Success when editProfile API call succeeds", () async {
      // Arrange
      when(
        mockApiClient.editProfile(editProfileRequest: editProfileRequest),
      ).thenAnswer((_) async => editProfileResponse);

      // Act
      final result = await profileRemoteDataSourceImpl.editProfile(
        editProfileRequest: editProfileRequest,
      );

      // Assert
      expect(
        (result as Success).data.user.firstName,
        equals(editProfileRequest.firstName),
      );
      verify(
        mockApiClient.editProfile(editProfileRequest: editProfileRequest),
      ).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test(
      "Should return Failure when editProfile API call throws exception",
      () async {
        // Arrange
        when(
          mockApiClient.editProfile(editProfileRequest: editProfileRequest),
        ).thenThrow(dioException);

        // Act
        final result = await profileRemoteDataSourceImpl.editProfile(
          editProfileRequest: editProfileRequest,
        );

        // Assert
        expect(result, isA<Failure<GetUserDataResponse>>());
        verify(
          mockApiClient.editProfile(editProfileRequest: editProfileRequest),
        ).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
  });

  group("Upload Photo Tests", () {
    late MultipartFile photo;
    late UploadPhotoResponse uploadPhotoResponse;

    setUp(() {
      photo = MultipartFile.fromBytes([0, 1, 2], filename: "photo.jpg");
      uploadPhotoResponse = const UploadPhotoResponse(message: "success");
    });

    test("Should return Success when uploadPhoto API call succeeds", () async {
      // Arrange
      when(
        mockApiClient.uploadPhoto(any),
      ).thenAnswer((_) async => uploadPhotoResponse);

      // Act
      final result = await profileRemoteDataSourceImpl.uploadPhoto(
        photo: photo,
      );

      // Assert
      expect((result as Success).data.message, equals("success"));
      verify(mockApiClient.uploadPhoto(photo)).called(1);
      verifyNoMoreInteractions(mockApiClient);
    });

    test(
      "Should return Failure when uploadPhoto API call throws exception",
      () async {
        // Arrange
        when(mockApiClient.uploadPhoto(photo)).thenThrow(dioException);

        // Act
        final result = await profileRemoteDataSourceImpl.uploadPhoto(
          photo: photo,
        );

        // Assert
        expect(result, isA<Failure<UploadPhotoResponse>>());
        verify(mockApiClient.uploadPhoto(photo)).called(1);
        verifyNoMoreInteractions(mockApiClient);
      },
    );
  });

  group("Get Notifications Tests", () {
    late GetNotificationsResponseDTO response;
    late List<NotificationItemDTO> notifications;
    setUp(() {
      notifications = [
        NotificationItemDTO(recipient: '1'),
        NotificationItemDTO(recipient: '2'),
        NotificationItemDTO(recipient: '3'),
      ];
      response = GetNotificationsResponseDTO(
        message: "success",
        notificationsDto: notifications,
      );
    });
    test(
      "Should return Success when getNotifications API call succeeds",
      () async {
        // Arrange
        when(
          mockApiClient.getNotifications(),
        ).thenAnswer((_) async => response);
        // Act
        final result = await profileRemoteDataSourceImpl.getNotifications();

        // Assert
        verify(mockApiClient.getNotifications()).called(1);
        verifyNoMoreInteractions(mockApiClient);
        expect(
          (result as Success<List<NotificationItemDTO>>).data,
          equals(notifications),
        );
      },
    );
    test(
      "Should return Failure when getNotifications API call throws exception",
      () async {
        // Arrange
        when(mockApiClient.getNotifications()).thenThrow(dioException);
        // Act
        final result = await profileRemoteDataSourceImpl.getNotifications();

        // Assert
        verify(mockApiClient.getNotifications()).called(1);
        verifyNoMoreInteractions(mockApiClient);
        expect(result, isA<Failure<List<NotificationItemDTO>>>());
      },
    );
  });
}
