import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/app/presentation/view_model/app_section_view_model.dart';
import 'package:flower_app/core/app_extension/app_extension.dart';
import 'package:flower_app/core/app_extension/app_spacing_extension.dart';
import 'package:flower_app/core/constants/app_dimensions.dart';
import 'package:flower_app/core/helper/app_routes.dart';
import 'package:flower_app/core/widgets/custom_image_view.dart';
import 'package:flower_app/features/auth/presentation/pages/logout/logout_dialog.dart';
import 'package:flower_app/features/localization/model/app_language.dart';
import 'package:flower_app/features/localization/view/language_bottom_sheet.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_intents.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_state.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/managers/main_profile_view_ui_events.dart';
import 'package:flower_app/features/profile/presentation/views/main_profile/view_model/main_profile_view_model.dart';
import 'package:flower_app/features/profile/presentation/widgets/main_profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MainProfileView extends StatefulWidget {
  const MainProfileView({super.key});

  @override
  State<MainProfileView> createState() => _MainProfileViewState();
}

class _MainProfileViewState extends State<MainProfileView>
    with WidgetsBindingObserver {
  String _appVersion = '0.0.0';
  late StreamSubscription _uiEventsSubscription;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<MainProfileViewModel>().doIntent(RefreshState());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadVersion();
    _uiEventsSubscription = context
        .read<MainProfileViewModel>()
        .uiEvents
        .listen((event) {
          if (!mounted) return;
          switch (event) {
            case NavToEditProfileEvent():
              Navigator.pushNamed(context, AppRoutes.editProfile);

            case NavToMyOrdersEvent():
              Navigator.pushNamed(context, AppRoutes.savedOrders);

            case NavToSavedAddressesEvent():
              Navigator.of(context).pushNamed(AppRoutes.saveAddress);

            case NavToNotificationEvent():
              Navigator.pushNamed(context, AppRoutes.notifications);

            case OpenLanguageBottomSheetEvent():
              showLanguageBottomSheet();

            case NavToTermsEvent():
              Navigator.pushNamed(context, AppRoutes.terms);

            case LogoutEvent():
              showLogoutDialog(context);

            case NavToAboutUsEvent():
              Navigator.pushNamed(context, AppRoutes.aboutUs);
          }
        });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _uiEventsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var vm = context.read<MainProfileViewModel>();
    var user = context.read<AppSectionViewModel>().user;
    return SafeArea(
      child: Padding(
        padding: AppDimensions.pagePadding,
        child: Column(
          children: [
            CustomImageView(
              imagePath: user.photo ?? "assets/image/splash_android_12.png",
              width: 80,
              height: 80,
              radius: const BorderRadius.all(Radius.circular(40)),
            ),
            context.h(16),
            InkWell(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    user.firstName ?? "user".tr(),
                    style: context.appTheme.semiBold18,
                  ),
                  context.w(4),
                  const Icon(Icons.edit, size: 20),
                ],
              ),
              onTap: () => vm.doIntent(OnEditProfileClickIntent()),
            ),
            context.h(4),
            Text(
              user.email ?? "example_email".tr(),
              style: context.appTheme.semiBold18.copyWith(
                color: context.appTheme.grey,
              ),
            ),
            context.h(16),
            MainProfileItem(
              prefix: const Icon(Icons.list_alt, size: 18),
              title: 'my_orders'.tr(),
              onTap: () => vm.doIntent(OnMyOrdersClickIntent()),
            ),
            MainProfileItem(
              prefix: const Icon(Icons.location_on_outlined, size: 18),
              title: 'saved_address'.tr(),
              onTap: () => vm.doIntent(OnSavedAddressesClickIntent()),
            ),
            const Divider(),
            BlocBuilder<MainProfileViewModel, MainProfileViewState>(
              buildWhen: (previous, current) =>
                  previous.allowNotification != current.allowNotification,
              builder: (context, state) {
                return MainProfileItem(
                  title: 'notification'.tr(),
                  prefix: Switch(
                    value: state.allowNotification ?? false,
                    inactiveTrackColor: context.appTheme.grey,
                    onChanged: (newValue) {
                      context.read<MainProfileViewModel>().doIntent(
                        OnNotificationClickIntent(allowNotification: newValue),
                      );
                    },
                  ),
                  onTap: () {
                    context.read<MainProfileViewModel>().doIntent(
                      NavigateToNotificationEvent(),
                    );
                  },
                );
              },
            ),
            const Divider(),
            MainProfileItem(
              prefix: const Icon(Icons.translate_rounded, size: 18),
              title: 'language'.tr(),
              suffix: TextButton(
                style: TextButton.styleFrom(),
                onPressed: () => vm.doIntent(OnLanguageClickIntent()),
                child: Text(
                  context.locale.languageCode ==
                          AppLanguage.values.first.locale.languageCode
                      ? AppLanguage.values.first.displayName.tr()
                      : AppLanguage.values.last.displayName.tr(),
                  style: context.appTheme.regular12.copyWith(
                    color: context.appTheme.primary,
                  ),
                ),
              ),
              onTap: () => vm.doIntent(OnLanguageClickIntent()),
            ),
            MainProfileItem(
              title: 'about_us'.tr(),
              onTap: () => vm.doIntent(OnAboutUsClickIntent()),
            ),
            MainProfileItem(
              title: 'terms_and_conditions'.tr(),
              onTap: () => vm.doIntent(OnTermsClickIntent()),
            ),
            const Divider(),
            MainProfileItem(
              title: 'logout'.tr(),
              onTap: () => vm.doIntent(OnLogoutClickIntent()),
              prefix: const Icon(Icons.logout, size: 16),
              suffix: const Icon(Icons.logout, size: 24),
            ),
            const Spacer(),
            Text('${"v".tr()} $_appVersion', style: context.appTheme.regular14),
          ],
        ),
      ),
    );
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() => _appVersion = info.version);
  }

  showLanguageBottomSheet() {
    showModalBottomSheet(
      backgroundColor: const Color(0xFFF9F9F9),
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      showDragHandle: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          color: context.appTheme.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: const LanguageBottomSheet(),
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const LogOuDialog(),
        );
      },
    );
  }
}
