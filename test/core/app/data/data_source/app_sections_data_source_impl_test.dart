import 'package:dio/dio.dart';
import 'package:flower_app/core/api/api_client.dart';
import 'package:flower_app/core/api/models/response/user_dto.dart';
import 'package:flower_app/core/app/data/data_source/app_sections_data_source.dart';
import 'package:flower_app/core/app/data/data_source/app_sections_data_source_impl.dart';
import 'package:flower_app/core/app/data/models/response/get_current_user_data_response_dto.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/core/services/firebase/firebase_store_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../features/auth/data/datasources/auth_ds_impl_test.mocks.dart';
import 'app_sections_data_source_impl_test.mocks.dart';

@GenerateMocks([FirebaseStoreService])
void main() {
  late ApiClient mockApiClient;
  late FirebaseStoreService mockFirebaseStoreService;
  late AppSectionsDataSource appSectionsDataSource;
  late UserDto userDto;
  late GetCurrentUserDataResponseDto response;
  late DioException dioException;
  setUp(() {
    mockApiClient = MockApiClient();
    mockFirebaseStoreService = MockFirebaseStoreService();
    appSectionsDataSource = AppSectionsDataSourceImpl(
      mockApiClient,
      mockFirebaseStoreService,
    );
    userDto = UserDto(
      id: '1',
      firstName: 'Mohamed',
      lastName: 'Ehab',
      email: 'john.mclean@examplepetstore.com',
    );
    response = GetCurrentUserDataResponseDto(user: userDto);
    dioException = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.connectionError,
    );
  });
  test(
    "Test when i call getCurrentUserData it should return userDto in success",
    () async {
      // Arrange
      when(
        mockApiClient.getCurrentUserData(),
      ).thenAnswer((_) async => response);
      // Act
      var result =
          await appSectionsDataSource.getCurrentUserData() as Success<UserDto>;
      // Assert
      verify(mockApiClient.getCurrentUserData()).called(1);
      verifyNoMoreInteractions(mockApiClient);
      expect(result, isA<Success<UserDto>>());
      expect(result.data, userDto);
    },
  );

  test(
    "Test when i call getCurrentUserData it should return errorMSG in failure",
    () async {
      // Arrange

      when(mockApiClient.getCurrentUserData()).thenThrow(dioException);
      // Act
      var result =
          await appSectionsDataSource.getCurrentUserData() as Failure<UserDto>;
      // Assert
      verify(mockApiClient.getCurrentUserData()).called(1);
      verifyNoMoreInteractions(mockApiClient);
      expect(result, isA<Failure<UserDto>>());
      expect(result.errorMessage, 'errors.connectionError');
    },
  );
}
