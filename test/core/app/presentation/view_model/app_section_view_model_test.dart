import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/app/domain/use_case/get_user_data_use_case.dart';
import 'package:flower_app/core/app/domain/use_case/upload_user_info_use_case.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_contracts.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_section_view_model_test.mocks.dart';

@GenerateMocks([GetUserDataUseCase, UploadUserInfoUseCase])
void main() {
  late MockGetUserDataUseCase mockGetUserDataUseCase;
  late MockUploadUserInfoUseCase mockUploadUserInfoUseCase;
  late AppSectionViewModel viewModel;

  setUp(() {
    provideDummy<Result<UserEntity>>(Success(UserEntity()));
    mockGetUserDataUseCase = MockGetUserDataUseCase();
    mockUploadUserInfoUseCase = MockUploadUserInfoUseCase();
    viewModel = AppSectionViewModel(
      mockGetUserDataUseCase,
      mockUploadUserInfoUseCase,
    );
  });

  tearDown(() => viewModel.close());

  group('AppSectionViewModel', () {
    test('initial state is correct', () {
      expect(viewModel.state, const AppSectionState());
    });

    blocTest<AppSectionViewModel, AppSectionState>(
      'emits home state when ViewHomeIntent is added',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ViewHomeIntent()),
      expect: () => [
        const AppSectionState(currentTab: 0, selectedCategoryIndex: null),
      ],
    );

    blocTest<AppSectionViewModel, AppSectionState>(
      'emits category state with index when ViewCategoryIntent is added',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ViewCategoryIntent(2)),
      expect: () => [
        const AppSectionState(currentTab: 1, selectedCategoryIndex: 2),
      ],
    );

    blocTest<AppSectionViewModel, AppSectionState>(
      'emits cart state when ViewCartIntent is added',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ViewCartIntent()),
      expect: () => [const AppSectionState(currentTab: 2)],
    );

    blocTest<AppSectionViewModel, AppSectionState>(
      'emits profile state when ViewProfileIntent is added',
      build: () => viewModel,
      act: (bloc) => bloc.doIntent(ViewProfileIntent()),
      expect: () => [const AppSectionState(currentTab: 3)],
    );

    blocTest<AppSectionViewModel, AppSectionState>(
      'switching from category to home clears selectedCategoryIndex',
      build: () => viewModel,
      act: (bloc) {
        bloc.doIntent(ViewCategoryIntent(1));
        bloc.doIntent(ViewHomeIntent());
      },
      expect: () => [
        const AppSectionState(currentTab: 1, selectedCategoryIndex: 1),
        const AppSectionState(currentTab: 0, selectedCategoryIndex: null),
      ],
    );
  });

  test("Test init intent function when success result", () async {
    // arrange
    var userEntity = UserEntity(
      id: '1',
      firstName: 'Mohamed',
      lastName: 'Ehab',
    );
    var successResponse = Success(userEntity);
    provideDummy<Result<UserEntity>>(successResponse);
    when(
      mockGetUserDataUseCase.call(),
    ).thenAnswer((_) async => successResponse);
    // act
    viewModel.doIntent(AppSectionInitIntent());
    await untilCalled(mockGetUserDataUseCase.call());
    // assert
    verify(mockGetUserDataUseCase.call()).called(1);
    verifyNoMoreInteractions(mockGetUserDataUseCase);
    expect(viewModel.user.id, userEntity.id);
    expect(viewModel.user.firstName, userEntity.firstName);
    expect(viewModel.user.lastName, userEntity.lastName);
  });

  test("Test init intent function when failure", () async {
    // arrange
    expectLater(
      viewModel.uiStream,
      emitsInOrder([isA<AppSectionLogoutEvent>()]),
    );
    var failureResponse = Failure<UserEntity>('error');
    provideDummy<Result<UserEntity>>(failureResponse);
    when(
      mockGetUserDataUseCase.call(),
    ).thenAnswer((_) async => failureResponse);
    // act
    viewModel.doIntent(AppSectionInitIntent());
    await Future.delayed(const Duration(microseconds: 1));
    // assert
    verify(mockGetUserDataUseCase.call()).called(1);
    verifyNoMoreInteractions(mockGetUserDataUseCase);
  });
}
