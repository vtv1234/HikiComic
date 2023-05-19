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
  final bool? isLockedChapter;
  const Chapter({
    this.chapterId,
    this.comicDetailId,
    this.chapterName,
    this.serialChapterOfComic,
    this.dateCreated,
    this.viewCount,
    this.isActive,
    this.comicSEOAlias,
    this.chapterSEOAlias,
    this.isLockedChapter,
  });

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
      isLockedChapter
    ];
  }

  Chapter copyWith(
      {int? chapterId,
      int? comicDetailId,
      String? chapterName,
      int? serialChapterOfComic,
      DateTime? dateCreated,
      int? viewCount,
      bool? isActive,
      String? comicSEOAlias,
      String? chapterSEOAlias,
      bool? isLockedChapter}) {
    return Chapter(
        chapterId: chapterId ?? this.chapterId,
        comicDetailId: comicDetailId ?? this.comicDetailId,
        chapterName: chapterName ?? this.chapterName,
        serialChapterOfComic: serialChapterOfComic ?? this.serialChapterOfComic,
        dateCreated: dateCreated ?? this.dateCreated,
        viewCount: viewCount ?? this.viewCount,
        isActive: isActive ?? this.isActive,
        comicSEOAlias: comicSEOAlias ?? this.comicSEOAlias,
        chapterSEOAlias: chapterSEOAlias ?? this.chapterSEOAlias,
        isLockedChapter: isLockedChapter ?? this.isLockedChapter);
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
      'isLockedChapter': isLockedChapter
    };
  }

  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      chapterId: map['chapterId'] != null ? map['chapterId'] as int : null,
      comicDetailId:
          map['comicDetailId'] != null ? map['comicDetailId'] as int : null,
      chapterName:
          map['chapterName'] != null ? map['chapterName'] as String : null,
      serialChapterOfComic: map['serialChapterOfComic'] != null
          ? map['serialChapterOfComic'] as int
          : null,
      dateCreated: map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'] as String)
          : null,
      viewCount: map['viewCount'] != null ? map['viewCount'] as int : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      comicSEOAlias:
          map['comicSEOAlias'] != null ? map['comicSEOAlias'] as String : null,
      chapterSEOAlias: map['chapterSEOAlias'] != null
          ? map['chapterSEOAlias'] as String
          : null,
      isLockedChapter: map['isLockedChapter'] != null
          ? map['isLockedChapter'] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chapter.fromJson(String source) =>
      Chapter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
