import 'dart:convert';

import 'package:hikicomic/data/models/history_comic.dart';

import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/utils.dart';
import 'package:http/http.dart' as http;

class ComicReadingHistoriesRepository {
  final utils = Utils();
  Future<List<HistoryComic>> getComicReadingHistories() async {
    int pageIndex = 1;
    int pageSize = 30;
    final response = await http.get(
        Uri.parse(
            '${Apis.comicReadingHistories}/paging?PageIndex=$pageIndex&PageSize=$pageSize'),
        headers: await utils.isLoggedIn() == "true"
            ? {'Authorization': 'Bearer ${await utils.readStorage('token')}'}
            : {});

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      return result.map((e) => HistoryComic.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
