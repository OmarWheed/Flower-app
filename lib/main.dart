import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower_app/core/bloc_box/my_bloc_observer.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/core/services/firebase/push_notification_service.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

bool isLoggedInUser = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotificationService.initFCM();
  await Permission.notification.request().then((allow) {
    AppLocalStorage.setData(LocalKeys.notification, allow.isGranted);
  });
  await EasyLocalization.ensureInitialized();
  await configureDependencies();

  isLoggedInUser = await getInitialAppRoute();

  Bloc.observer = MyBlocObserver();
  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const FlowerApp(),
    ),
  );
}

Future<bool> getInitialAppRoute() async {
  final rememberMe = await AppLocalStorage.getBool(LocalKeys.rememberMe);
  final token = await AppLocalStorage.getSecuredString(
    key: LocalKeys.authToken,
  );
  if (rememberMe && token.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}
