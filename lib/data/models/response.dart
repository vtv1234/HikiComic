import 'package:equatable/equatable.dart';

import 'package:hikicomic/data/models/chapter.dart';
import 'package:hikicomic/data/models/genre.dart';
import 'package:hikicomic/data/models/user.dart';
import 'package:hikicomic/utils/const.dart';

import 'package:json_annotation/json_annotation.dart';

import 'account.dart';
import 'chapter_image.dart';
import 'comic_detail.dart';
import 'comment.dart';

@JsonSerializable(createToJson: false)
class BaseResponse<T> extends Equatable {
  final bool? isSuccessed;
  final String? message;
  final int? statusCode;
  @JsonKey(fromJson: _dataFromJson)
  final T? ressultObj;

  factory BaseResponse.fromJson(Map<String, dynamic> json, type) =>
      _$BaseResponseFromJson(json, type);

  const BaseResponse(
      {this.isSuccessed, this.message, this.statusCode, this.ressultObj});

  /// Decodes [json] by "inspecting" its contents.
  static T _dataFromJson<T>(Object json, TypeModel type) {
    if (json is Map<String, dynamic>) {
      if (type == TypeModel.comicDetail) {
        return ComicDetail.fromMap(json) as T;
      }
      if (type == TypeModel.chapter) {
        return Chapter.fromMap(json) as T;
      }
      if (type == TypeModel.chapterImage) {
        return ChapterImage.fromMap(json) as T;
      }
      if (type == TypeModel.user) {
        return User.fromMap(json) as T;
      }
      if (type == TypeModel.genre) {
        return Genre.fromMap(json) as T;
      }
      if (type == TypeModel.account) {
        return Account.fromMap(json) as T;
      }
      if (type == TypeModel.comment) {
        return Comment.fromMap(json) as T;
      }
    } else if (json is List) {
      if (type == TypeModel.chapter) {
        // return Chapter.fromMap(json) as T;

        return json
            .map((e) => Chapter.fromMap(e as Map<String, dynamic>))
            .toList() as T;
      }
      if (type == TypeModel.genre) {
        return json
            .map((e) => Genre.fromMap(e as Map<String, dynamic>))
            .toList() as T;
      }
      if (type == TypeModel.comment) {
        return json
            .map((e) => Comment.fromMap(e as Map<String, dynamic>))
            .toList() as T;
      }
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }

  @override
  List<Object?> get props => [isSuccessed, statusCode, message, ressultObj];
}

BaseResponse<T> _$BaseResponseFromJson<T>(
        Map<String, dynamic> json, TypeModel type) =>
    BaseResponse<T>(
      isSuccessed: json['isSuccessed'] as bool?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      ressultObj: BaseResponse._dataFromJson(json['resultObj'] as Object, type),
    );
