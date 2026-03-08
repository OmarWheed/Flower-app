import 'package:equatable/equatable.dart';

final class AppSectionState extends Equatable {
  final int currentTab;
  final int? selectedCategoryIndex;

  const AppSectionState({this.currentTab = 0, this.selectedCategoryIndex});

  AppSectionState copyWith({int? currentTab, int? selectedCategoryIndex}) =>
      AppSectionState(
        currentTab: currentTab ?? this.currentTab,
        selectedCategoryIndex: selectedCategoryIndex,
      );

  @override
  List<Object?> get props => [currentTab, selectedCategoryIndex];
}

sealed class AppSectionIntent {}

class AppSectionInitIntent extends AppSectionIntent {}

class UpLoadUserInfoIntent extends AppSectionIntent {
  final String collectionPath;
  final String userId;
  final Map<String, dynamic> data;

  UpLoadUserInfoIntent({
    required this.collectionPath,
    required this.userId,
    required this.data,
  });
}

class ViewHomeIntent extends AppSectionIntent {}

class ViewCategoryIntent extends AppSectionIntent {
  int? categoryIndex;

  ViewCategoryIntent(this.categoryIndex);
}

class ViewCartIntent extends AppSectionIntent {}

class ViewProfileIntent extends AppSectionIntent {}

sealed class AppSectionUIEvents {}

class AppSectionLogoutEvent extends AppSectionUIEvents with EquatableMixin {
  final String message;

  AppSectionLogoutEvent(this.message);

  @override
  List<Object?> get props => [message];
}
