import 'package:flutter/foundation.dart';
import 'package:hikicomic/data/models/storage_item.dart';
import 'package:hikicomic/utils/secure_storage.dart';

class Utils {
  final _storageService = StorageService();
  Future<void> deleteAllSecureData() async {
    await _storageService.deleteAllSecureData();
    if (kDebugMode) {
      print('delete all storage');
    }
  }

  Future<void> deleteToken(String key) async {
    /// delete from keystore/keychain

    await _storageService.deleteSecureData(key);
    return;
  }

  Future<void> persistToken(StorageItem item) async {
    /// write to keystore/keychain

    await _storageService.writeSecureData(item);
    return;
  }

  Future<String?> methodLogin() async {
    if (kDebugMode) {
      print(await _storageService.readSecureData('methodLogin'));
    }

    return await _storageService.readSecureData('methodLogin');
    // await Future.delayed(Duration(seconds: 1));
  }

  Future<bool> hasToken() async {
    if (kDebugMode) {
      print(await _storageService.readSecureData('token'));
    }

    return await _storageService.containsKeyInSecureData('token');
    // await Future.delayed(Duration(seconds: 1));
  }

  Future<bool> hasAccessTokenFacebook() async {
    if (kDebugMode) {
      print(await _storageService.readSecureData('accessTokenFacebook'));
    }

    return await _storageService.containsKeyInSecureData('accessTokenFacebook');
    // await Future.delayed(Duration(seconds: 1));
  }

  Future<bool> hasAccessTokenGoogle() async {
    if (kDebugMode) {
      print(await _storageService.readSecureData('accessTokenGoogle'));
    }

    return await _storageService.containsKeyInSecureData('accessTokenGoogle');
    // await Future.delayed(Duration(seconds: 1));
  }

  Future<String?> readStorage(String key) async {
    return await _storageService.readSecureData(key);
  }

  Future<bool> isLoggedIn() async {
    if (await _storageService.readSecureData('methodLogin') != null) {
      return true;
    }
    return false;
  }

  String differentTime(DateTime dateStart) {
    Duration differentDuration = DateTime.now().difference(dateStart);
    //second<minute<hours<day
    //60<60<24<1
    if (differentDuration > const Duration(days: 1)) {
      return '${differentDuration.inDays} day ago';
    } else if (differentDuration > const Duration(hours: 1)) {
      return '${differentDuration.inHours} hours ago';
    } else if (differentDuration > const Duration(minutes: 1)) {
      return '${differentDuration.inMinutes} minutes ago';
    } else {
      return '${differentDuration.inSeconds} seconds ago';
    }
  }
}
