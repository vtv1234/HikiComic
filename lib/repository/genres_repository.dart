import 'dart:convert';

import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/data/models/response.dart';
import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/const.dart';
import 'package:http/http.dart' as http;

class GenresRepository {
  //Comic? _comic;

  Future<BaseResponse> getAllGenres() async {
    final response = await http.get(Uri.parse(Apis.getAllGenresApi));
    if (response.statusCode == 200) {
      final result =
          BaseResponse.fromJson(jsonDecode(response.body), TypeModel.genre);

      // print(result);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Comic>> getComicByGenre(
      {required String keyword,
      required int genreId,
      required int pageIndex,
      required int pageSize}) async {
    final response = await http.get(Uri.parse(
        '${Apis.getComicByGenre}?Keyword=$keyword&GenreId=$genreId&PageIndex=$pageIndex&PageSize=$pageSize'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      return result.map((e) => Comic.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
