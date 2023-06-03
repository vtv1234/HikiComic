import 'dart:convert';

import 'dart:io';

import 'package:hikicomic/data/models/error_auth.dart';
import 'package:hikicomic/data/models/response.dart';

import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/const.dart';
import 'package:hikicomic/utils/utils.dart';

import 'package:http/http.dart' as http;

class AccountRepository {
  final utils = Utils();
  Future<BaseResponse> getAccountInformation() async {
    final response =
        await http.get(Uri.parse(Apis.getAccountInformaton), headers: {
      'Authorization': 'Bearer ${await utils.readStorage('token')}',
    });
    if (response.statusCode == 200) {
      final result =
          BaseResponse.fromJson(jsonDecode(response.body), TypeModel.account);

      // print(result);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final response = await http.post(
      Uri.parse(Apis.resetPassword),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword
      }),
    );
    // if (response.statusCode == 200) {
    final jsonResult = jsonDecode(response.body);
    if (jsonResult['isSuccessed'] == true) {
      final result = BaseResponse(
          isSuccessed: jsonResult['isSuccessed'] as bool,
          message: jsonResult['message'],
          statusCode: jsonResult['statusCode'] as int,
          resultObj: jsonResult['resultObj'] as dynamic);
      return {'isSuccessed': true, 'result': result};
    }
    return {'isSuccessed': false, 'result': ErrorResponse.fromMap(jsonResult)};
  }

  Future<bool> uploadAvatar(File imageFile) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${await utils.readStorage('token')}',
      "Content-type": "multipart/form-data"
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        Apis.uploadAvatar,
      ),
    );
    request.headers.addAll(headers);
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ),
    );
    var response = await request.send();
    if (response.statusCode == 200) {
      // print('Image uploaded successfully');
      return true;
    } else {
      // print('Image upload failed with status ${response.statusCode}');
      return false;
    }
  }
}
