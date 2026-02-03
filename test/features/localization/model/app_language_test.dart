import 'package:flower_app/features/localization/model/app_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppLanguage', () {
    test('english has correct locale', () {
      expect(AppLanguage.english.locale, const Locale('en'));
    });

    test('arabic has correct locale', () {
      expect(AppLanguage.arabic.locale, const Locale('ar'));
    });

    test('english displayName returns correct value', () {
      expect(AppLanguage.english.displayName, 'English');
    });

    test('arabic displayName returns correct value', () {
      expect(AppLanguage.arabic.displayName, 'Arabic');
    });

    test('enum contains exactly two values', () {
      expect(AppLanguage.values.length, 2);
      expect(
        AppLanguage.values,
        containsAll([AppLanguage.english, AppLanguage.arabic]),
      );
    });
  });
}
