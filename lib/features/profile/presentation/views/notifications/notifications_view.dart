import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/managers/notifications_view_contract.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/managers/notifications_view_keys.dart';
import 'package:flower_app/features/profile/presentation/views/notifications/view_model/notifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    key: NotificationsViewKeys.scaffold,
    appBar: AppBar(
      key: NotificationsViewKeys.appBar,
      title: Text('notification'.tr()),
      scrolledUnderElevation: 0,
    ),
    body: BlocBuilder<NotificationsViewModel, NotificationsViewState>(
      key: NotificationsViewKeys.blocBuilder,
      builder: (context, state) {
        if (state.notificationsEntitiesState.isInitial ||
            state.notificationsEntitiesState.isLoading) {
          return Center(
            key: NotificationsViewKeys.center,
            child: SizedBox(
              key: NotificationsViewKeys.sizedBox,
              height: 50,
              width: 50,
              child: LoadingIndicator(
                key: NotificationsViewKeys.loadingIndicator,
                indicatorType: Indicator.lineScale,
                colors: context.appTheme.kDefaultRainbowColors,
                strokeWidth: 1,
                backgroundColor: context.appTheme.backgroundColor,
                pathBackgroundColor: Colors.black,
              ),
            ),
          );
        } else if (state.notificationsEntitiesState.isError) {
          return Center(
            key: NotificationsViewKeys.center,
            child: Text(
              key: NotificationsViewKeys.errorMsg,
              state.notificationsEntitiesState.errorMessage ?? "",
            ),
          );
        } else {
          final notifications = state.notificationsEntitiesState.data ?? [];
          return ListView.builder(
            key: NotificationsViewKeys.listViewBuilder,
            shrinkWrap: true,
            itemCount: notifications.length,
            itemBuilder: (context, index) => Card(
              key: NotificationsViewKeys.card,
              color: Colors.white,
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                key: NotificationsViewKeys.listTile,
                leading: const Icon(
                  key: NotificationsViewKeys.leading,
                  Icons.notifications_none_rounded,
                ),
                title: Text(
                  key: NotificationsViewKeys.title,
                  notifications[index].title,
                  style: context.appTheme.medium16,
                ),
                subtitle: Text(
                  key: NotificationsViewKeys.subtitle,
                  notifications[index].body,
                  style: context.appTheme.regular14,
                ),
              ),
            ),
          );
        }
      },
    ),
  );
}
