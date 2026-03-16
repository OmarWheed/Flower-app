import 'package:cloud_firestore/cloud_firestore.dart';
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

@GenerateMocks([
  ApiClient,
  FirebaseFirestore,
  CollectionReference<Map<String, dynamic>>,
  DocumentReference<Map<String, dynamic>>,
  QuerySnapshot<Map<String, dynamic>>,
  QueryDocumentSnapshot<Map<String, dynamic>>,
])
void main() {
  late MockApiClient mockApiClient;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl;
  late DioException dioException;
  late UserDto userDto;
  late MockCollectionReference<Map<String, dynamic>> mockUsersCollection;
  late MockCollectionReference<Map<String, dynamic>>
  mockNotificationsCollection;
  late MockDocumentReference<Map<String, dynamic>> mockUserDoc;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<Map<String, dynamic>> mockDoc1;
  late MockQueryDocumentSnapshot<Map<String, dynamic>> mockDoc2;

  setUp(() {
    mockApiClient = MockApiClient();
    mockFirebaseFirestore = MockFirebaseFirestore();
    profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl(
      mockApiClient,
      mockFirebaseFirestore,
    );
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
    mockUsersCollection = MockCollectionReference();
    mockNotificationsCollection = MockCollectionReference();
    mockUserDoc = MockDocumentReference();
    mockQuerySnapshot = MockQuerySnapshot();
    mockDoc1 = MockQueryDocumentSnapshot();
    mockDoc2 = MockQueryDocumentSnapshot();
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
    setUp(() {
      when(
        mockFirebaseFirestore.collection('users'),
      ).thenReturn(mockUsersCollection);

      when(mockUsersCollection.doc("1")).thenReturn(mockUserDoc);

      when(
        mockUserDoc.collection('notifications'),
      ).thenReturn(mockNotificationsCollection);

      when(
        mockNotificationsCollection.get(),
      ).thenAnswer((_) async => mockQuerySnapshot);

      when(mockQuerySnapshot.docs).thenReturn([mockDoc1, mockDoc2]);

      when(mockDoc1.data()).thenReturn({
        "recipient": "1",
        "title": "Test title",
        "body": "Test body",
      });
      when(mockDoc2.data()).thenReturn({
        "recipient": "2",
        "title": "Test title 2",
        "body": "Test body 2",
      });
    });
    test(
      "Should return Success when getNotifications from firebase call succeeds",
      () async {
        final result = await profileRemoteDataSourceImpl.getNotifications(
          userId: "1",
        );
        expect(result, isA<Success<List<NotificationItemDTO>>>());
        final data = (result as Success<List<NotificationItemDTO>>).data;
        verify(mockFirebaseFirestore.collection('users')).called(1);
        expect(data.length, 2);
        expect(data.first.title, "Test title");
        expect(data.last.title, "Test title 2");
      },
    );
    test(
      "Should return Failure when getNotifications API call throws exception",
      () async {
        // Arrange
        when(mockFirebaseFirestore.collection('users')).thenThrow(dioException);
        final result = await profileRemoteDataSourceImpl.getNotifications(
          userId: "1",
        );

        expect(result, isA<Failure<List<NotificationItemDTO>>>());
      },
    );
  });
}
