import 'dart:convert';

import 'package:hikicomic/data/models/response.dart';
import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/const.dart';
import 'package:http/http.dart' as http;

class ChapterRepository {
  Future<BaseResponse> getChaptersByComicSeoAlias(String comicSeoAlias) async {
    final response = await http
        .get(Uri.parse('${Apis.getChaptersByComicSeoAlias}$comicSeoAlias'));
    if (response.statusCode == 200) {
      final result =
          BaseResponse.fromJson(jsonDecode(response.body), TypeModel.chapter);

      // print(result);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
