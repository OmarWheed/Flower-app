import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class NetworkException {
  static String getMessageError(Exception exception) {
    if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
          return 'errors.connectionTimeout'.tr();
        case DioExceptionType.sendTimeout:
          return 'errors.sendTimeout'.tr();
        case DioExceptionType.receiveTimeout:
          return 'errors.receiveTimeout'.tr();
        case DioExceptionType.badCertificate:
          return 'errors.badCertificate'.tr();
        case DioExceptionType.badResponse:
          return _handleMessageResponse(exception);
        case DioExceptionType.cancel:
          return 'errors.cancel'.tr();
        case DioExceptionType.connectionError:
          return 'errors.connectionError'.tr();
        case DioExceptionType.unknown:
          return 'errors.unknown'.tr();
      }
    } else if (exception is FirebaseException) {
      return _handleMessageErrorFromFirebase(exception);
    } else {
      return exception.toString();
    }
  }

  static String _handleMessageResponse(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      switch (e.response!.statusCode) {
        case 400:
          return 'errors.error400'.tr();
        case 401:
          return 'errors.error401'.tr() + data['error'].toString();
        case 403:
          return 'errors.error403'.tr();
        case 404:
          return data['error'].toString();
        case 408:
          return 'errors.error408'.tr();
        case 429:
          return 'errors.error429'.tr();
        case 500:
          return 'errors.error500'.tr();
        case 502:
          return 'errors.error502'.tr();
        case 503:
          return 'errors.error503'.tr();
        case 504:
          return 'errors.error504'.tr();
        default:
          if (data is Map && data['error'] != null) {
            return data['error'].toString();
          }
          return 'Server error (${statusCode ?? 'unknown'}). Please try again.';
      }
    }
    return 'errors.defaultError'.tr();
  }

  static String _handleMessageErrorFromFirebase(FirebaseException exception) {
    switch (exception.code) {
      case 'permission-denied':
        return 'errors.permissionDenied'.tr();
      case 'unavailable':
        return 'errors.serviceUnavailable'.tr();
      case 'deadline-exceeded':
        return 'errors.timeout'.tr();
      case 'not-found':
        return 'errors.notFound'.tr();
      case 'already-exists':
        return 'errors.alreadyExists'.tr();
      case 'unauthenticated':
        return 'errors.unauthenticated'.tr();
      case 'cancelled':
        return 'errors.cancelled'.tr();
      case 'resource-exhausted':
        return 'errors.resourceExhausted'.tr();
      case 'aborted':
        return 'errors.aborted'.tr();
      case 'internal':
        return 'errors.internal'.tr();
      default:
        return exception.message ?? 'errors.unknown'.tr();
    }
  }
}
