import 'package:flower_app/core/error_handling/result.dart';
import 'package:flower_app/features/auth/data/models/response/reset_password_response.dart';
import 'package:flower_app/features/auth/data/models/response/send_reset_password_code_response.dart';
import 'package:flower_app/features/auth/data/models/response/verify_reset_code_response.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/reset_password_use_case.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/send_reset_password_code_use_case.dart';
import 'package:flower_app/features/auth/domain/use_cases/forget_password/verify_reset_password_code_use_case.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_intents.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_ui_events.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/view_model/forget_password_view_model.dart';
import 'package:flower_app/features/auth/presentation/views/forget_password/managers/forget_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_view_model_test.mocks.dart';

@GenerateMocks([
  ResetPasswordUseCase,
  SendResetPasswordCodeUseCase,
  VerifyResetPasswordCodeUseCase,
])
void main() {
  late ForgetPasswordViewModel cubit;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockSendResetPasswordCodeUseCase mockSendResetPasswordCodeUseCase;
  late MockVerifyResetPasswordCodeUseCase mockVerifyResetPasswordCodeUseCase;

  const testEmail = 'test@example.com';
  const testCode = '123456';
  const testPassword = 'newPassword123';

  setUpAll(() {
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockSendResetPasswordCodeUseCase = MockSendResetPasswordCodeUseCase();
    mockVerifyResetPasswordCodeUseCase = MockVerifyResetPasswordCodeUseCase();
  });
  setUp(() {
    cubit = ForgetPasswordViewModel(
      mockSendResetPasswordCodeUseCase,
      mockVerifyResetPasswordCodeUseCase,
      mockResetPasswordUseCase,
    );
  });
  group('forget password view model test success cases', () {
    blocTest(
      'When the user enters a valid email to send otp ',
      build: () => cubit,
      setUp: () {
        provideDummy<Result<SendResetPasswordCodeResponse>>(
          Success(
            SendResetPasswordCodeResponse(
              message: 'success',
              info: 'otp sent successfully',
            ),
          ),
        );

        when(
          mockSendResetPasswordCodeUseCase(email: anyNamed('email')),
        ).thenAnswer(
              (_) async => Success(
            SendResetPasswordCodeResponse(
              message: 'success',
              info: 'otp sent successfully',
            ),
          ),
        );
      },
      act: (cubit) => cubit.doIntent(SendResetPasswordCodeIntent(testEmail)),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'isLoading', true)
            .having((s) => s.message, 'message', null),

        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'isLoading', true)
            .having(
              (s) => s.resendRemainingSeconds,
          'resendRemainingSeconds',
          30,
        ),

        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.message, 'message', 'success')
            .having(
              (s) => s.resendRemainingSeconds,
          'resendRemainingSeconds',
          30,
        )
            .having((s) => s.error, 'error', ''),
      ],
    );
    blocTest(
      'When the user enters a valid code to verify otp ',
      build: () => cubit,
      setUp: () {
        provideDummy<Result<VerifyResetCodeResponse>>(
          Success(VerifyResetCodeResponse(message: 'success')),
        );

        when(
          mockVerifyResetPasswordCodeUseCase(resetCode: anyNamed('resetCode')),
        ).thenAnswer(
              (_) async => Success(VerifyResetCodeResponse(message: 'success')),
        );
      },
      act: (cubit) => cubit.doIntent(VerifyResetPasswordCodeIntent(testCode)),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'isLoading', true)
            .having((s) => s.message, 'message', null),

        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.message, 'message', 'success')
            .having(
              (s) => s.resendRemainingSeconds,
          'resendRemainingSeconds',
          30,
        )
            .having((s) => s.error, 'error', ''),
      ],
    );
    blocTest(
      'When the user enters a valid email and password to reset password ',
      build: () => cubit,
      setUp: () {
        provideDummy<Result<ResetPasswordResponse>>(
          Success(ResetPasswordResponse(message: 'success', token: 'token')),
        );

        when(
          mockResetPasswordUseCase(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer(
              (_) async => Success(
            ResetPasswordResponse(message: 'success', token: 'token'),
          ),
        );
      },
      act: (cubit) =>
          cubit.doIntent(ResetPasswordIntent(testEmail, testPassword)),
      expect: () => [
        isA<ForgetPasswordState>().having(
              (s) => s.isLoading,
          'isLoading',
          true,
        ),

        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.message, 'message', 'success'),
      ],
    );
  });
  group('forget password view model test failure cases', () {
    blocTest(
      'When the user enters an invalid email, it should emit failure state',
      build: () => cubit,
      setUp: () {
        provideDummy<Result<SendResetPasswordCodeResponse>>(
          Failure('Invalid Email Address'),
        );
        when(
          mockSendResetPasswordCodeUseCase(email: anyNamed('email')),
        ).thenAnswer((_) async => Failure('Invalid Email Address'));
      },
      act: (cubit) =>
          cubit.doIntent(SendResetPasswordCodeIntent('wrong-email')),
      expect: () => [
        isA<ForgetPasswordState>().having((s) => s.isLoading, 'loading', true),
        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.error, 'error', 'Invalid Email Address'),
      ],
    );

    blocTest(
      'When the user enters an invalid otp, it should emit failure state',
      build: () => cubit,
      setUp: () {
        provideDummy<Result<VerifyResetCodeResponse>>(Failure('Invalid Code'));
        when(
          mockVerifyResetPasswordCodeUseCase(resetCode: anyNamed('resetCode')),
        ).thenAnswer((_) async => Failure('Invalid Code'));
      },
      act: (cubit) =>
          cubit.doIntent(VerifyResetPasswordCodeIntent('wrong code')),
      expect: () => [
        isA<ForgetPasswordState>().having((s) => s.isLoading, 'loading', true),
        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.error, 'error', 'Invalid Code'),
      ],
    );

    blocTest(
      'When the user enters an invalid email and password to reset password, it should emit failure state',
      build: () => cubit,
      setUp: () {
        provideDummy<Result<ResetPasswordResponse>>(Failure('Invalid Data'));
        when(
          mockResetPasswordUseCase(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer((_) async => Failure('Invalid Data'));
      },
      act: (cubit) => cubit.doIntent(ResetPasswordIntent('wrong-email', '')),
      expect: () => [
        isA<ForgetPasswordState>().having((s) => s.isLoading, 'loading', true),
        isA<ForgetPasswordState>()
            .having((s) => s.isLoading, 'loading', false)
            .having((s) => s.error, 'error', 'Invalid Data'),
      ],
    );
    group('UI Events & Navigation & Toast & Timer', () {
      test(
        'Should emit NavigateToOTPEvent and ShowToastEvent when send code succeeds',
            () async {
          provideDummy<Result<SendResetPasswordCodeResponse>>(
            Success(
              SendResetPasswordCodeResponse(
                message: 'success',
                info: 'otp sent',
              ),
            ),
          );
          when(
            mockSendResetPasswordCodeUseCase(email: anyNamed('email')),
          ).thenAnswer(
                (_) async => Success(
              SendResetPasswordCodeResponse(
                message: 'success',
                info: 'otp sent',
              ),
            ),
          );

          expectLater(
            cubit.uiEventsStream,
            emitsInOrder([
              isA<ForgetPasswordShowToastEvent>().having(
                    (e) => e.message,
                'message',
                'otp sent',
              ),
              isA<NavigateToOTPEvent>(),
            ]),
          );

          cubit.doIntent(SendResetPasswordCodeIntent(testEmail));
        },
      );
      test(
        'Should emit NavigateToLoginEvent when reset password succeeds',
            () async {
          provideDummy<Result<ResetPasswordResponse>>(
            Success(
              ResetPasswordResponse(message: 'reset success', token: '123'),
            ),
          );
          when(
            mockResetPasswordUseCase(
              email: anyNamed('email'),
              password: anyNamed('password'),
            ),
          ).thenAnswer(
                (_) async => Success(
              ResetPasswordResponse(message: 'reset success', token: '123'),
            ),
          );

          expectLater(
            cubit.uiEventsStream,
            emitsThrough(isA<NavigateToLoginEvent>()),
          );

          cubit.doIntent(ResetPasswordIntent(testEmail, testPassword));
        },
      );
    });
    test(
      'Should emit ForgetPasswordShowToastEvent with error message on failure',
          () async {
        provideDummy<Result<SendResetPasswordCodeResponse>>(
          Failure('Network Error'),
        );

        when(
          mockSendResetPasswordCodeUseCase(email: anyNamed('email')),
        ).thenAnswer((_) async => Failure('Network Error'));

        expectLater(
          cubit.uiEventsStream,
          emitsThrough(
            isA<ForgetPasswordShowToastEvent>().having(
                  (e) => e.message,
              'message',
              'Network Error',
            ),
          ),
        );

        cubit.doIntent(SendResetPasswordCodeIntent(testEmail));
      },
    );
    blocTest(
      'When OTP is sent, timer should decrease after 1 second',
      build: () => cubit,
      setUp: () {
        provideDummy<Result<SendResetPasswordCodeResponse>>(
          Success(SendResetPasswordCodeResponse(message: 's', info: 'i')),
        );
        when(
          mockSendResetPasswordCodeUseCase(email: anyNamed('email')),
        ).thenAnswer(
              (_) async =>
              Success(SendResetPasswordCodeResponse(message: 's', info: 'i')),
        );
      },
      act: (cubit) => cubit.doIntent(SendResetPasswordCodeIntent(testEmail)),
      wait: const Duration(seconds: 1),
      expect: () => [
        isA<ForgetPasswordState>().having((s) => s.isLoading, 'loading', true),
        isA<ForgetPasswordState>().having(
              (s) => s.resendRemainingSeconds,
          'timer',
          30,
        ),
        isA<ForgetPasswordState>().having(
              (s) => s.resendRemainingSeconds,
          'timer',
          30,
        ),
        isA<ForgetPasswordState>().having(
              (s) => s.resendRemainingSeconds,
          'timer',
          29,
        ),
      ],
    );
  });
}