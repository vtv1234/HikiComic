import 'dart:convert';

import 'package:hikicomic/data/models/comic.dart';

import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/utils.dart';
import 'package:http/http.dart' as http;

class ComicRepository {
  final utils = Utils();
  Future<List<Comic>> getHotComicsOfDay() async {
    int numberOfElement = 30;
    final response =
        await http.get(Uri.parse('${Apis.getHotComicsUrl}/$numberOfElement'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['hotComicsOfTheDay'];
      return result.map((e) => Comic.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Comic>> getHotComicsOfMonth() async {
    int numberOfElement = 30;
    final response =
        await http.get(Uri.parse('${Apis.getHotComicsUrl}/$numberOfElement'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['hotComicsOfTheMonth'];
      return result.map((e) => Comic.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Comic>> getHotComicsOfWeek() async {
    int numberOfElement = 30;
    final response =
        await http.get(Uri.parse('${Apis.getHotComicsUrl}/$numberOfElement'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['hotComicsOfTheWeek'];
      return result.map((e) => Comic.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Comic>> getNewComics(
      {required int pageIndex, required int pageSize}) async {
    final response = await http.get(Uri.parse(
        '${Apis.getNewComicsUrl}?PageIndex=$pageIndex&PageSize=$pageSize'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body);
      return result.map((e) => Comic.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Comic>> getFollowingComics() async {
    int pageIndex = 1;
    int pageSize = 30;
    final response = await http.post(
      Uri.parse(Apis.getFollowedComicsApi),
      body: jsonEncode({"pageIndex": pageIndex, "pageSize": pageSize}),
      headers: await utils.isLoggedIn() == "true"
          ? {
              'Authorization': 'Bearer ${await utils.readStorage('token')}',
              'Content-Type': 'application/json'
            }
          : {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      return result.map((e) => Comic.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Comic>> getComicsByStatus(
      {required int statusId,
      required int pageIndex,
      required int pageSize}) async {
    final response = await http.get(Uri.parse(
        '${Apis.getComicByStatus}?StatusId=$statusId&PageIndex=$pageIndex&PageSize=$pageSize'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];

      return result.map((e) => Comic.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Comic>> getComicsByKeyword(
      {required String keyword,
      required int pageIndex,
      required int pageSize}) async {
    final response = await http.get(Uri.parse(
        '${Apis.getComicByStatus}?Keyword=$keyword&PageIndex=$pageIndex&PageSize=$pageSize'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      return result.map((e) => Comic.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
