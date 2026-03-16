import 'dart:convert';

import 'package:flower_app/core/constants/constants.dart';
import 'package:flower_app/core/helper/assets_manager.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class FCMService {
  const FCMService._();

  static Future<String> getAccessToken() async {
    final jsonString = await rootBundle.loadString(
      AssetsManager.serviceAccountPath,
    );
    final jsonData = jsonDecode(jsonString);
    final accountCredentials = ServiceAccountCredentials.fromJson(jsonData);
    final scopes = [AppConstants.scopeUrl];
    final client = http.Client();
    try {
      final accessCredentials = await obtainAccessCredentialsViaServiceAccount(
        accountCredentials,
        scopes,
        client,
      );
      return accessCredentials.accessToken.data;
    } finally {
      client.close();
    }
  }
}
