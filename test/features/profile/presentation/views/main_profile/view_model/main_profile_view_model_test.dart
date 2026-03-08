import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_intents.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_ui_events.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/view_model/main_profile_view_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MainProfileViewModel viewModel;

  setUp(() {
    SharedPreferences.setMockInitialValues({});

    const channel = MethodChannel('flutter.baseflow.com/permissions/methods');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'checkPermissionStatus') {
            return 1; // 1
          }
          return null;
        });

    viewModel = MainProfileViewModel();
  });

  tearDown(() async {
    await viewModel.close();
  });

  group('MainProfileViewModel UI Events', () {
    test('emits NavToEditProfileEvent on OnEditProfileClickIntent', () {
      expectLater(
        viewModel.uiEvents,
        emitsInOrder([isA<NavToEditProfileEvent>()]),
      );

      viewModel.doIntent(OnEditProfileClickIntent());
    });

    test('emits NavToMyOrdersEvent on OnMyOrdersClickIntent', () {
      expectLater(
        viewModel.uiEvents,
        emitsInOrder([isA<NavToMyOrdersEvent>()]),
      );

      viewModel.doIntent(OnMyOrdersClickIntent());
    });

    test('emits NavToSavedAddressesEvent on OnSavedAddressesClickIntent', () {
      expectLater(
        viewModel.uiEvents,
        emitsInOrder([isA<NavToSavedAddressesEvent>()]),
      );

      viewModel.doIntent(OnSavedAddressesClickIntent());
    });

    test('emits OpenLanguageBottomSheetEvent on OnLanguageClickIntent', () {
      expectLater(
        viewModel.uiEvents,
        emitsInOrder([isA<OpenLanguageBottomSheetEvent>()]),
      );

      viewModel.doIntent(OnLanguageClickIntent());
    });

    test('emits NavToTermsEvent on OnTermsClickIntent', () {
      expectLater(viewModel.uiEvents, emitsInOrder([isA<NavToTermsEvent>()]));

      viewModel.doIntent(OnTermsClickIntent());
    });

    test('emits NavToAboutUsEvent on OnAboutUsClickIntent', () {
      expectLater(viewModel.uiEvents, emitsInOrder([isA<NavToAboutUsEvent>()]));

      viewModel.doIntent(OnAboutUsClickIntent());
    });

    test('emits LogoutEvent on OnLogoutClickIntent', () {
      expectLater(viewModel.uiEvents, emitsInOrder([isA<LogoutEvent>()]));

      viewModel.doIntent(OnLogoutClickIntent());
    });
  });
}
