// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Chapter extends Equatable {
  final int? chapterId;
  final int? comicDetailId;
  final String? chapterName;
  final int? serialChapterOfComic;
  final DateTime? dateCreated;
  final int? viewCount;
  final bool? isActive;
  final String? comicSEOAlias;
  final String? chapterSEOAlias;
  const Chapter(
    this.chapterId,
    this.comicDetailId,
    this.chapterName,
    this.serialChapterOfComic,
    this.dateCreated,
    this.viewCount,
    this.isActive,
    this.comicSEOAlias,
    this.chapterSEOAlias,
  );

  @override
  List<Object?> get props {
    return [
      chapterId,
      comicDetailId,
      chapterName,
      serialChapterOfComic,
      dateCreated,
      viewCount,
      isActive,
      comicSEOAlias,
      chapterSEOAlias,
    ];
  }

  Chapter copyWith({
    int? chapterId,
    int? comicDetailId,
    String? chapterName,
    int? serialChapterOfComic,
    DateTime? dateCreated,
    int? viewCount,
    bool? isActive,
    String? comicSEOAlias,
    String? chapterSEOAlias,
  }) {
    return Chapter(
      chapterId ?? this.chapterId,
      comicDetailId ?? this.comicDetailId,
      chapterName ?? this.chapterName,
      serialChapterOfComic ?? this.serialChapterOfComic,
      dateCreated ?? this.dateCreated,
      viewCount ?? this.viewCount,
      isActive ?? this.isActive,
      comicSEOAlias ?? this.comicSEOAlias,
      chapterSEOAlias ?? this.chapterSEOAlias,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chapterId': chapterId,
      'comicDetailId': comicDetailId,
      'chapterName': chapterName,
      'serialChapterOfComic': serialChapterOfComic,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'viewCount': viewCount,
      'isActive': isActive,
      'comicSEOAlias': comicSEOAlias,
      'chapterSEOAlias': chapterSEOAlias,
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      map['chapterId'] != null ? map['chapterId'] as int : null,
      map['comicDetailId'] != null ? map['comicDetailId'] as int : null,
      map['chapterName'] != null ? map['chapterName'] as String : null,
      map['serialChapterOfComic'] != null
          ? map['serialChapterOfComic'] as int
          : null,
      map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'] as String)
          : null,
      map['viewCount'] != null ? map['viewCount'] as int : null,
      map['isActive'] != null ? map['isActive'] as bool : null,
      map['comicSEOAlias'] != null ? map['comicSEOAlias'] as String : null,
      map['chapterSEOAlias'] != null ? map['chapterSEOAlias'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
