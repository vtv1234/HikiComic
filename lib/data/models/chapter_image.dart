// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ChapterImage extends Equatable {
  final int? comicId;
  final int? chapterId;
  final bool? isFollow;
  final String? comicName;
  final String? chapterName;
  final List<String>? chapterImageURLs;
  final String? comicSEOAlias;
  final String? nextChapterSEOAlias;
  final String? previousChapterSEOAlias;
  final DateTime? dateCreated;
  final String? chapters;
  const ChapterImage({
    this.comicId,
    this.chapterId,
    this.isFollow,
    this.comicName,
    this.chapterName,
    this.chapterImageURLs,
    this.comicSEOAlias,
    this.nextChapterSEOAlias,
    this.previousChapterSEOAlias,
    this.dateCreated,
    this.chapters,
  });

  ChapterImage copyWith({
    int? comicId,
    int? chapterId,
    bool? isFollow,
    String? comicName,
    String? chapterName,
    List<String>? chapterImageURLs,
    String? comicSEOAlias,
    String? nextChapterSEOAlias,
    String? previousChapterSEOAlias,
    DateTime? dateCreated,
    String? chapters,
  }) {
    return ChapterImage(
      comicId: comicId ?? this.comicId,
      chapterId: chapterId ?? this.chapterId,
      isFollow: isFollow ?? this.isFollow,
      comicName: comicName ?? this.comicName,
      chapterName: chapterName ?? this.chapterName,
      chapterImageURLs: chapterImageURLs ?? this.chapterImageURLs,
      comicSEOAlias: comicSEOAlias ?? this.comicSEOAlias,
      nextChapterSEOAlias: nextChapterSEOAlias ?? this.nextChapterSEOAlias,
      previousChapterSEOAlias:
          previousChapterSEOAlias ?? this.previousChapterSEOAlias,
      dateCreated: dateCreated ?? this.dateCreated,
      chapters: chapters ?? this.chapters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comicId': comicId,
      'chapterId': chapterId,
      'isFollow': isFollow,
      'comicName': comicName,
      'chapterName': chapterName,
      'chapterImageURLs': chapterImageURLs,
      'comicSEOAlias': comicSEOAlias,
      'nextChapterSEOAlias': nextChapterSEOAlias,
      'previousChapterSEOAlias': previousChapterSEOAlias,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'chapters': chapters,
    };
  }

  factory ChapterImage.fromMap(Map<String, dynamic> map) {
    return ChapterImage(
      comicId: map['comicId'] != null ? map['comicId'] as int : null,
      chapterId: map['chapterId'] != null ? map['chapterId'] as int : null,
      isFollow: map['isFollow'] != null ? map['isFollow'] as bool : null,
      comicName: map['comicName'] != null ? map['comicName'] as String : null,
      chapterName:
          map['chapterName'] != null ? map['chapterName'] as String : null,
      chapterImageURLs: map['chapterImageURLs'] != null
          ? List<String>.from((map['chapterImageURLs'] as List<dynamic>))
          : null,
      comicSEOAlias:
          map['comicSEOAlias'] != null ? map['comicSEOAlias'] as String : null,
      nextChapterSEOAlias: map['nextChapterSEOAlias'] != null
          ? map['nextChapterSEOAlias'] as String
          : null,
      previousChapterSEOAlias: map['previousChapterSEOAlias'] != null
          ? map['previousChapterSEOAlias'] as String
          : null,
      dateCreated: map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'] as String)
          : null,
      chapters: map['chapters'] != null ? map['chapters'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChapterImage.fromJson(String source) =>
      ChapterImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      comicId,
      chapterId,
      isFollow,
      comicName,
      chapterName,
      chapterImageURLs,
      comicSEOAlias,
      nextChapterSEOAlias,
      previousChapterSEOAlias,
      dateCreated,
      chapters,
    ];
  }
}
