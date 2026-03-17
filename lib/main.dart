import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flower_app/core/bloc_box/my_bloc_observer.dart';
import 'package:flower_app/core/constants/constants.dart';
import 'package:flower_app/core/di/di.dart';
import 'package:flower_app/core/helper/app_local_storage.dart';
import 'package:flower_app/core/helper/local_keys.dart';
import 'package:flower_app/core/services/firebase/fcm_service.dart';
import 'package:flower_app/core/services/firebase/push_notification_service.dart';
import 'package:flower_app/flower_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

bool isLoggedInUser = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await configureDependencies();

  await PushNotificationService.initFCM().then((deviceToken) {
    AppLocalStorage.setData(LocalKeys.deviceToken, deviceToken);
  });
  await FCMService.getAccessToken().then((fcmAccessToken) {
    AppLocalStorage.setSecuredString(
      key: AppConstants.fcmAccessToken,
      value: fcmAccessToken,
    );
  });

  await Permission.notification.request().then((allow) {
    AppLocalStorage.setData(LocalKeys.notification, allow.isGranted);
  });
  // Sync Errors to Crashlytics - Main Thread errors
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Async Errors to Crashlytics - OutSide Main Threads - PlatForm Specific Errors - Apis Requests Errors
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  Bloc.observer = MyBlocObserver();
  isLoggedInUser = await getInitialAppRoute();
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
