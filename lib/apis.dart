import 'dart:io';

class Apis {
  static const _baseUrl = 'https://localhost:7068/api';
  // "https://localhost:7068/api/comics/hot-comics"

  static const authorsApi = '$_baseUrl/authors';
  //static const categoriesApi = '$_baseUrl/authors';
  //static const chapterComicsApi = '$_baseUrl/authors';
  //static const chapterImageURLsApi = '$_baseUrl/authors';
  static const _comicsUrl = '$_baseUrl/comics';
  static const userUrl = '/user';
  static const hotComicsUrl = '$_baseUrl/$_comicsUrl/hot-comics';

  // static const signUpApi = _baseUrl + 'singup_api_endpoint';
  static const loginApi = '$_baseUrl/users/login';
  static const getUserById = ' $_baseUrl/users/login';
}

// Future<bool> checkIsPhysicalDevice() async {
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   if (Platform.isAndroid) {
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     print('Is emulator: ${androidInfo.isPhysicalDevice}');
//     return androidInfo.isPhysicalDevice;
//   } else if (Platform.isIOS) {
//     IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//     print('Is simulator: ${iosInfo.isPhysicalDevice}');
//     return iosInfo.isPhysicalDevice;
//   }
//   return true;
// }
