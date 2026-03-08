import 'dart:async';

import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_intents.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_state.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_ui_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class MainProfileViewModel extends Cubit<MainProfileViewState> {
  MainProfileViewModel() : super(MainProfileViewState()) {
    _loadNotificationStatus();
  }

  final _uiControllerBroadcast =
      StreamController<MainProfileViewUIEvents>.broadcast();

  Stream<MainProfileViewUIEvents> get uiEvents => _uiControllerBroadcast.stream;

  doIntent(ProfileViewIntents intent) {
    switch (intent) {
      case OnEditProfileClickIntent():
        _navToEdit();
      case OnMyOrdersClickIntent():
        _navToMyOrders();
      case OnSavedAddressesClickIntent():
        _navToAddresses();
      case OnNotificationClickIntent():
        _toggleNotification(intent.allowNotification ?? false);
      case OnLanguageClickIntent():
        _openLanguagesBottomSheet();
      case OnTermsClickIntent():
        _navToTerms();
      case OnAboutUsClickIntent():
        _navToAboutUs();
      case OnLogoutClickIntent():
        _logout();
      case RefreshState():
        _refreshPermissionStatus();
    }
  }

  _navToEdit() => _uiControllerBroadcast.add(NavToEditProfileEvent());

  _navToMyOrders() => _uiControllerBroadcast.add(NavToMyOrdersEvent());

  _navToAddresses() => _uiControllerBroadcast.add(NavToSavedAddressesEvent());

  _openLanguagesBottomSheet() =>
      _uiControllerBroadcast.add(OpenLanguageBottomSheetEvent());

  _navToTerms() => _uiControllerBroadcast.add(NavToTermsEvent());

  _navToAboutUs() => _uiControllerBroadcast.add(NavToAboutUsEvent());

  _logout() => _uiControllerBroadcast.add(LogoutEvent());

  Future<void> _loadNotificationStatus() async {
    // Check actual system permission status on load
    bool isGranted = await Permission.notification.isGranted;
    await AppLocalStorage.setData(LocalKeys.notification, isGranted);
    emit(state.copyWith(allowNotification: isGranted));
  }

  Future<void> _toggleNotification(bool requestedValue) async {
    await openAppSettings();
    await Future.delayed(const Duration(milliseconds: 500));
    await _refreshPermissionStatus();
  }

  Future<void> _refreshPermissionStatus() async {
    bool isGranted = await Permission.notification.isGranted;
    await AppLocalStorage.setData(LocalKeys.notification, isGranted);
    emit(state.copyWith(allowNotification: isGranted));
  }

  @override
  Future<void> close() {
    _uiControllerBroadcast.close();
    return super.close();
  }
}
