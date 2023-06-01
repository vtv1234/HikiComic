import 'dart:convert';

import 'package:hikicomic/data/models/response.dart';
import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/const.dart';

import 'package:hikicomic/utils/utils.dart';

import 'package:http/http.dart' as http;

class UserRepository {
  final utils = Utils();
  Future<BaseResponse?> getUser() async {
    final response = await http.get(Uri.parse(Apis.getUserByUserId), headers: {
      'Authorization': 'Bearer ${await utils.readStorage('token')}'
    });
    if (response.statusCode == 200) {
      final result =
          BaseResponse.fromJson(jsonDecode(response.body), TypeModel.user);
      return result;
    } else {
      return null;
    }
  }

  Future<BaseResponse?> getUserFacebook() async {
    final response = await http.get(Uri.parse(Apis.getUserByUserId), headers: {
      'Authorization': 'Bearer ${await utils.readStorage('token')}'
    });
    if (response.statusCode == 200) {
      final result =
          BaseResponse.fromJson(jsonDecode(response.body), TypeModel.user);
      return result;
    } else {
      return null;
    }
  }
}
