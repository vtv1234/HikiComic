import 'dart:convert';

import 'package:hikicomic/data/models/error_auth.dart';
import 'package:hikicomic/data/models/response.dart';

import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/const.dart';
import 'package:hikicomic/utils/utils.dart';
import 'package:http/http.dart' as http;

class ChapterImageRepository {
  final utils = Utils();
  Future<BaseResponse> getChaptersByChapterComicSeoAlias(
      String comicSeoAlias, String chapterSeoAlias) async {
    final response = await http.get(
        Uri.parse(
            '${Apis.getChapterByChapterComicSeoAlias}$comicSeoAlias/$chapterSeoAlias'),
        headers: await utils.isLoggedIn() == "true"
            ? {'Authorization': 'Bearer ${await utils.readStorage('token')}'}
            : {});
    final resultJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (resultJson['isSuccessed'] == true) {
        return BaseResponse.fromJson(resultJson, TypeModel.chapterImage);
      }
      return ErrorResponse.fromMap(resultJson);

      // print(result);
      // return result;
    } else {
      return ErrorResponse.fromJson(resultJson);
    }
  }
}
