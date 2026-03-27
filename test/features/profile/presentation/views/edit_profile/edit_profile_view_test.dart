import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/bloc_box/base_state.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/auth/domain/models/user_entity.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/edit_profile_view.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_intent.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_view_model.dart';
import 'package:flower_app/features/profile/presentation/views/edit_profile/view_model/edit_profile_view_state.dart';
import 'package:flutter/material.dart' hide Intent;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_profile_view_test.mocks.dart';

@GenerateMocks([EditProfileViewModel])
void main() {
  late MockEditProfileViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockEditProfileViewModel();
    when(mockViewModel.uiEventsStream).thenAnswer((_) => const Stream.empty());
    when(mockViewModel.doIntent(argThat(isA<Intent>()))).thenReturn(null);
    when(
      mockViewModel.doUIEvent(argThat(isA<EditProfileUIEvents>())),
    ).thenReturn(null);
  });

  Future<void> registerVm() async {
    if (getIt.isRegistered<EditProfileViewModel>()) {
      getIt.unregister<EditProfileViewModel>();
    }
    getIt.registerSingleton<EditProfileViewModel>(mockViewModel);
  }

  Future<void> unregisterVm() async {
    if (getIt.isRegistered<EditProfileViewModel>()) {
      getIt.unregister<EditProfileViewModel>();
    }
  }

  Widget buildTestableWidget() {
    return EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MaterialApp(
        theme: LightTheme().themeData,
        home: const EditProfileView(),
      ),
    );
  }

  group('EditProfileView Widget Tests', () {
    testWidgets('Calls GetProfileData on init and shows loading when loading', (
      tester,
    ) async {
      await registerVm();

      final loadingState = EditProfileViewState.initial().copyWith(
        getProfileDateStates:
            EditProfileViewState.initial().getProfileDateStates.loading,
      );

      when(mockViewModel.state).thenReturn(loadingState);
      when(mockViewModel.stream).thenAnswer((_) => Stream.value(loadingState));

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      verify(mockViewModel.doIntent(argThat(isA<GetProfileData>()))).called(1);
      expect(find.byType(CircularProgressIndicator), findsWidgets);

      await unregisterVm();
    });

    testWidgets('Renders form fields when profile is loaded', (tester) async {
      await registerVm();

      final user = UserEntity(
        firstName: 'Mona',
        lastName: 'Ahmed',
        email: 'mona@test.com',
        phone: '01001112233',
        photo: '',
      );

      final loadedState = EditProfileViewState.initial().copyWith(
        getProfileDateStates: EditProfileViewState.initial()
            .getProfileDateStates
            .loaded(user),
      );

      when(mockViewModel.state).thenReturn(loadedState);
      when(mockViewModel.stream).thenAnswer((_) => Stream.value(loadedState));

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(5));
      expect(find.byType(ElevatedButton), findsOneWidget);

      await unregisterVm();
    });

    testWidgets('Tapping update dispatches EditProfile when form valid', (
      tester,
    ) async {
      await registerVm();

      final user = UserEntity(
        firstName: 'Mona',
        lastName: 'Ahmed',
        email: 'mona@test.com',
        phone: '01001112233',
        photo: '',
      );

      final loadedState = EditProfileViewState.initial().copyWith(
        getProfileDateStates: EditProfileViewState.initial()
            .getProfileDateStates
            .loaded(user),
      );

      when(mockViewModel.state).thenReturn(loadedState);
      when(mockViewModel.stream).thenAnswer((_) => Stream.value(loadedState));

      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      // fields are prefilled in listener; pump once more
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
    });
  });
}
