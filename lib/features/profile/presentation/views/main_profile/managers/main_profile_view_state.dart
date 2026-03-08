final class MainProfileViewState {
  bool? allowNotification;

  MainProfileViewState({this.allowNotification});

  MainProfileViewState copyWith({bool? allowNotification}) {
    return MainProfileViewState(
      allowNotification: allowNotification ?? this.allowNotification,
    );
  }
}
