import 'dart:convert';

// import 'package:hikicomic/data/models/comic_detail.dart';
import 'package:hikicomic/data/models/response.dart';

import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/const.dart';
import 'package:hikicomic/utils/utils.dart';
import 'package:http/http.dart' as http;

class ComicDetailRepository {
  final utils = Utils();
  Future<BaseResponse> getComicDetailByComicSeoAlias(
      String comicSeoAlias) async {
    bool isLoggedIn = await utils.isLoggedIn() == "true";
    final response = await http.get(
      Uri.parse(isLoggedIn
          ? '${Apis.getComicDetailByComicSeoAliasWithUser}$comicSeoAlias'
          : '${Apis.getComicDetailByComicSeoAlias}$comicSeoAlias'),
      headers: isLoggedIn
          ? {
              'Authorization': 'Bearer ${await utils.readStorage('token')}',
            }
          : {},
    );
    if (response.statusCode == 200) {
      final result = BaseResponse.fromJson(
          jsonDecode(response.body), TypeModel.comicDetail);

      // print(result);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<BaseResponse> updateStatusUserFollowComic(int comicId) async {
    // bool isLoggedIn = await utils.isLoggedIn() == "true";
    final response = await http.get(
      Uri.parse('${Apis.updateStatusUserFollowComic}$comicId'),
      headers: {
        'Authorization': 'Bearer ${await utils.readStorage('token')}',
      },
    );
    if (response.statusCode == 200) {
      final jsonResult = jsonDecode(response.body);
      final result = BaseResponse(
          isSuccessed: jsonResult['isSuccessed'] as bool,
          message: jsonResult['message'],
          statusCode: jsonResult['statusCode'] as int,
          ressultObj: jsonResult['resultObj'] as dynamic);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<BaseResponse> ratingComic(
      {required int comicId,
      required String comicSEOAlias,
      required double rating}) async {
    // bool isLoggedIn = await utils.isLoggedIn() == "true";
    final response = await http.post(
      Uri.parse(Apis.userRatingComic),
      body: jsonEncode({
        "comicId": comicId,
        "comicSEOAlias": comicSEOAlias,
        "rating": rating
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await utils.readStorage('token')}',
      },
    );
    if (response.statusCode == 200) {
      final jsonResult = jsonDecode(response.body);
      final result = BaseResponse(
          isSuccessed: jsonResult['isSuccessed'] as bool,
          message: jsonResult['message'],
          statusCode: jsonResult['statusCode'] as int,
          ressultObj: jsonResult['resultObj'] as dynamic);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
