import 'package:flower_app/core/constants/text_strings.dart';
import 'package:flower_app/core/theme/light_theme.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_events.dart';
import 'package:flower_app/features/auth/presentation/cubit/login_view_model/login_view_model.dart';
import 'package:flower_app/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_screen_test.mocks.dart';

@GenerateMocks([LoginViewModel])
void main() {
  late MockLoginViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockLoginViewModel();
    when(mockViewModel.uiEventsStream).thenAnswer((_) => const Stream.empty());
    when(mockViewModel.state).thenReturn(LoginState.initial());
    when(mockViewModel.stream).thenAnswer((_) => const Stream.empty());
    when(
      mockViewModel.doIntent(argThat(isA<LoginViewIntent>())),
    ).thenReturn(null);
  });

  Widget buildTestableWidget() {
    return MaterialApp(
      theme: LightTheme().themeData,
      home: BlocProvider<LoginViewModel>.value(
        value: mockViewModel,
        child: const LoginScreen(),
      ),
    );
  }

  group('LoginScreen Widget Tests', () {
    testWidgets('Initial UI renders correctly and login is disabled', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      expect(find.text(IAppText.login), findsWidgets);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text(IAppText.continueAsGuest), findsOneWidget);

      final loginBtn = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(loginBtn.onPressed, isNull);
    });

    testWidgets('Enables login button when form filled', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'test@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'Mohamed@123');
      await tester.pump();

      final loginBtn = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(loginBtn.onPressed, isNotNull);
    });

    testWidgets('Tapping login calls doIntent(UserLoginIntent)', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).at(0),
        'test@example.com',
      );
      await tester.enterText(find.byType(TextFormField).at(1), 'Mohamed@123');
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      verify(mockViewModel.doIntent(argThat(isA<UserLoginIntent>()))).called(1);
    });

    testWidgets('Tapping continue as guest calls GuestLoginIntent', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pump();

      await tester.tap(find.text(IAppText.continueAsGuest));
      await tester.pump();

      verify(
        mockViewModel.doIntent(argThat(isA<GuestLoginIntent>())),
      ).called(1);
    });
  });
}
