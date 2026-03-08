sealed class ProfileViewIntents {}

class OnEditProfileClickIntent extends ProfileViewIntents {}

class OnMyOrdersClickIntent extends ProfileViewIntents {}

class OnSavedAddressesClickIntent extends ProfileViewIntents {}

class OnNotificationClickIntent extends ProfileViewIntents {
  final bool? allowNotification;

  OnNotificationClickIntent({this.allowNotification});
}

class RefreshState extends ProfileViewIntents {}

class OnLanguageClickIntent extends ProfileViewIntents {}

class OnTermsClickIntent extends ProfileViewIntents {}

class OnAboutUsClickIntent extends ProfileViewIntents {}

class OnLogoutClickIntent extends ProfileViewIntents {}
