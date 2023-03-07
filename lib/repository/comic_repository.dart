import 'dart:convert';

import 'package:hikicomic/apis.dart';
import 'package:hikicomic/data/models/comic.dart';
import 'package:http/http.dart' as http;

class ComicRepository {
  //Comic? _comic;

  Future<List<Comic>> getHotComics() async {
    final response = await http.get(Uri.parse(Apis.hotComicsUrl));
    //List<dynamic> listRes = response.body['newComicStrips'];
    // List<ComicStrip> list = [];
    // for (var element in listRes) {
    //   list.add(ComicStrip.fromMap(element));
    // }
    // return list;
    // List<Comic> listComicStrips = List.from(json
    //     .decode(response.body)['hotComics']['hotComicsOfTheDay']
    //     .map((x) => Comic.fromJson(x)));
    // print(listComicStrips);
    //return listComicStrips;
    var responseJson = json.decode(response.body);
    return (responseJson['hotComics']['hotComicsOfTheDay'] as List)
        .map((p) => Comic.fromJson(p))
        .toList();
  }
}
