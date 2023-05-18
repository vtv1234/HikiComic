import 'dart:convert';

import 'package:hikicomic/data/models/comment.dart';
import 'package:hikicomic/data/models/response.dart';
import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/const.dart';

import 'package:hikicomic/utils/utils.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  final utils = Utils();
  Future<List<Comment>?> getListCommentOfChapter(
      {required int comicId,
      required int? chapterId,
      required int pageIndex,
      required int pageSize}) async {
    bool isLoggedIn = await utils.isLoggedIn() == "true";
    final response = await http.get(
      Uri.parse(
        chapterId != null
            ? '${Apis.pagingComment}?ComicId=$comicId&ChapterId=$chapterId&PageIndex=$pageIndex&PageSize=$pageSize'
            : '${Apis.pagingComment}?ComicId=$comicId&PageIndex=$pageIndex&PageSize=$pageSize',
      ),
      headers: isLoggedIn
          ? {
              'Authorization': 'Bearer ${await utils.readStorage('token')}',
            }
          : {},
    );
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['items'];
      return result.map((e) => Comment.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<BaseResponse> sendComment(
      {required chapterId,
      required comicId,
      required int? parentCommentId,
      required String commentContent}) async {
    final response = await http.post(Uri.parse(Apis.createComment),
        body: jsonEncode({
          "comicId": comicId,
          "chapterId": chapterId,
          "parentCommentId": parentCommentId,
          "commentContent": commentContent
        }),
        headers: {
          'Authorization': 'Bearer ${await utils.readStorage('token')}',
          'Content-Type': 'application/json'
        });
    if (response.statusCode == 200) {
      final result =
          BaseResponse.fromJson(jsonDecode(response.body), TypeModel.comment);

      // print(result);
      return result;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
