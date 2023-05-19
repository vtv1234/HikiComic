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

  Future<String?> isLoggedIn() async {
    if (kDebugMode) {
      print(await _storageService.readSecureData('isLoggedIn'));
    }

    return await _storageService.readSecureData('isLoggedIn');
    // await Future.delayed(Duration(seconds: 1));
  }

  Future<bool> hasToken() async {
    if (kDebugMode) {
      print(await _storageService.readSecureData('token'));
    }

    return await _storageService.containsKeyInSecureData('token');
    // await Future.delayed(Duration(seconds: 1));
  }

  Future<String?> readStorage(String key) async {
    return await _storageService.readSecureData(key);
  }
}
