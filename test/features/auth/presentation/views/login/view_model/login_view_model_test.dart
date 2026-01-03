import 'package:bloc_test/bloc_test.dart';
import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/login_response.dart';
import 'package:flower_app/features/auth/domain/use_cases/login/login_use_case.dart';
import 'package:flower_app/features/auth/presentation/views/login/managers/login_view_events.dart';
import 'package:flower_app/features/auth/presentation/views/login/managers/login_view_intents.dart';
import 'package:flower_app/features/auth/presentation/views/login/managers/login_view_state.dart';
import 'package:flower_app/features/auth/presentation/views/login/view_model/login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_view_model_test.mocks.dart';

@GenerateMocks([LoginUseCase])
void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginViewModel viewModel;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    viewModel = LoginViewModel(mockLoginUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  group('LoginViewModel - Initial State', () {
    test('initial state should be LoginState.initial()', () {
      expect(viewModel.state, isA<LoginViewState>());
      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.errorMessage, '');
      expect(viewModel.state.successMessage, '');
    });
  });

  group('LoginViewModel - UserLoginIntent', () {
    const email = "joe@example.com";
    const password = "Mo!!00001111";
    const successMessage = 'Login successful';

    blocTest<LoginViewModel, LoginViewState>(
      'emits loading state then success state on successful login',
      build: () {
        final mockLoginResponse = Success<LoginResponse>(
          LoginResponse(message: successMessage, token: 'mock_token'),
        );
        provideDummy<Result<LoginResponse>>(mockLoginResponse);
        when(
          mockLoginUseCase.login(email: email, password: password),
        ).thenAnswer((_) async => mockLoginResponse);
        return LoginViewModel(mockLoginUseCase);
      },
      act: (cubit) =>
          cubit.doIntent(UserLoginIntent(email: email, password: password)),
      expect: () => [
        LoginViewState(isLoading: true),
        LoginViewState(successMessage: successMessage),
      ],
      verify: (cubit) {
        verify(
          mockLoginUseCase.login(email: email, password: password),
        ).called(1);
      },
    );

    test(
      'verifies NavigateToHome event is emitted on successful login',
      () async {
        final mockLoginResponse = Success<LoginResponse>(
          LoginResponse(message: successMessage, token: 'mock_token'),
        );
        final localMockLoginUseCase = MockLoginUseCase();
        provideDummy<Result<LoginResponse>>(mockLoginResponse);
        when(
          localMockLoginUseCase.login(email: email, password: password),
        ).thenAnswer((_) async => mockLoginResponse);

        final localViewModel = LoginViewModel(localMockLoginUseCase);

        final events = <LoginUIEvents>[];
        localViewModel.uiEventsStream.listen(events.add);

        localViewModel.doIntent(
          UserLoginIntent(email: email, password: password),
        );
        await Future.delayed(const Duration(milliseconds: 200));

        expect(events.length, 1);
        expect(events[0], isA<NavigateToHome>());

        localViewModel.close();
      },
    );

    blocTest<LoginViewModel, LoginViewState>(
      'emits loading state then resets state on failed login',
      build: () {
        const errorMessage = 'Invalid credentials';
        final mockErrorResponse = Failure<LoginResponse>(errorMessage);
        provideDummy<Result<LoginResponse>>(mockErrorResponse);
        when(
          mockLoginUseCase.login(email: email, password: password),
        ).thenAnswer((_) async => mockErrorResponse);
        return LoginViewModel(mockLoginUseCase);
      },
      act: (cubit) =>
          cubit.doIntent(UserLoginIntent(email: email, password: password)),
      expect: () => [LoginViewState(isLoading: true), LoginViewState()],
      verify: (cubit) {
        verify(
          mockLoginUseCase.login(email: email, password: password),
        ).called(1);
      },
    );

    test('verifies error toast event is emitted on failed login', () async {
      const errorMessage = 'Invalid credentials';
      final mockErrorResponse = Failure<LoginResponse>(errorMessage);
      final localMockLoginUseCase = MockLoginUseCase();
      provideDummy<Result<LoginResponse>>(mockErrorResponse);
      when(
        localMockLoginUseCase.login(email: email, password: password),
      ).thenAnswer((_) async => mockErrorResponse);

      final localViewModel = LoginViewModel(localMockLoginUseCase);

      final events = <LoginUIEvents>[];
      localViewModel.uiEventsStream.listen(events.add);

      localViewModel.doIntent(
        UserLoginIntent(email: email, password: password),
      );
      await Future.delayed(const Duration(milliseconds: 200));

      expect(events.length, 1);
      expect(events[0], isA<LoginViewShowToast>());
      final toastEvent = events[0] as LoginViewShowToast;
      expect(toastEvent.message, errorMessage);
      expect(toastEvent.isError, true);

      localViewModel.close();
    });

    blocTest<LoginViewModel, LoginViewState>(
      'handles multiple login attempts correctly',
      build: () {
        final mockLoginResponse = Success<LoginResponse>(
          LoginResponse(message: successMessage, token: 'mock_token'),
        );
        provideDummy<Result<LoginResponse>>(mockLoginResponse);
        when(
          mockLoginUseCase.login(email: email, password: password),
        ).thenAnswer((_) async => mockLoginResponse);
        return LoginViewModel(mockLoginUseCase);
      },
      act: (cubit) async {
        cubit.doIntent(UserLoginIntent(email: email, password: password));
        await Future.delayed(const Duration(milliseconds: 100));
        cubit.doIntent(UserLoginIntent(email: email, password: password));
      },
      expect: () => [
        LoginViewState(isLoading: true),
        LoginViewState(successMessage: successMessage),
        LoginViewState(isLoading: true),
        LoginViewState(successMessage: successMessage),
      ],
    );
  });

  group('LoginViewModel - GuestLoginIntent', () {
    test('navigates to home without changing state on guest login', () async {
      final events = <LoginUIEvents>[];
      viewModel.uiEventsStream.listen(events.add);

      final initialState = viewModel.state;
      viewModel.doIntent(GuestLoginIntent());
      await Future.delayed(const Duration(milliseconds: 100));

      // State should not change
      expect(viewModel.state.isLoading, initialState.isLoading);
      expect(viewModel.state.errorMessage, initialState.errorMessage);
      expect(viewModel.state.successMessage, initialState.successMessage);

      // NavigateToHome event should be emitted
      expect(events.length, 1);
      expect(events[0], isA<NavigateToHome>());
    });
  });

  group('LoginViewModel - SignupIntent', () {
    test('navigates to signup without changing state', () async {
      final events = <LoginUIEvents>[];
      viewModel.uiEventsStream.listen(events.add);

      final initialState = viewModel.state;
      viewModel.doIntent(NavToSignupIntent());
      await Future.delayed(const Duration(milliseconds: 100));

      // State should not change
      expect(viewModel.state.isLoading, initialState.isLoading);
      expect(viewModel.state.errorMessage, initialState.errorMessage);
      expect(viewModel.state.successMessage, initialState.successMessage);

      // NavigateToSignup event should be emitted
      expect(events.length, 1);
      expect(events[0], isA<NavigateToSignup>());
    });
  });

  group('LoginViewModel - ForgetPasswordIntent', () {
    test('navigates to forget password without changing state', () async {
      final events = <LoginUIEvents>[];
      viewModel.uiEventsStream.listen(events.add);

      final initialState = viewModel.state;
      viewModel.doIntent(NavToForgetPasswordIntent());
      await Future.delayed(const Duration(milliseconds: 100));

      // State should not change
      expect(viewModel.state.isLoading, initialState.isLoading);
      expect(viewModel.state.errorMessage, initialState.errorMessage);
      expect(viewModel.state.successMessage, initialState.successMessage);

      // NavigateToForgetPassword event should be emitted
      expect(events.length, 1);
      expect(events[0], isA<NavigateToForgetPassword>());
    });
  });

  group('LoginViewModel - UI Events Stream', () {
    test('uiEventsStream is broadcast and can have multiple listeners', () {
      expect(viewModel.uiEventsStream.isBroadcast, true);
    });

    test('different intents emit correct UI events in sequence', () async {
      final events = <LoginUIEvents>[];
      viewModel.uiEventsStream.listen(events.add);

      viewModel.doIntent(NavToSignupIntent());
      await Future.delayed(const Duration(milliseconds: 50));

      viewModel.doIntent(NavToForgetPasswordIntent());
      await Future.delayed(const Duration(milliseconds: 50));

      viewModel.doIntent(GuestLoginIntent());
      await Future.delayed(const Duration(milliseconds: 50));

      expect(events.length, 3);
      expect(events[0], isA<NavigateToSignup>());
      expect(events[1], isA<NavigateToForgetPassword>());
      expect(events[2], isA<NavigateToHome>());
    });
  });
}
