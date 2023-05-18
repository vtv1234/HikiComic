// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class HistoryComic extends Equatable {
  final int? userComicReadingHistoryId;
  final String? comicName;
  final int? viewCount;
  final String? comicCoverImageURL;
  final String? status;
  final String? comicSEOAlias;
  final String? chapterSEOAlias;
  final num? rating;
  final String? chapterName;
  final DateTime? dateRead;
  const HistoryComic({
    this.userComicReadingHistoryId,
    this.comicName,
    this.viewCount,
    this.comicCoverImageURL,
    this.status,
    this.comicSEOAlias,
    this.chapterSEOAlias,
    this.rating,
    this.chapterName,
    this.dateRead,
  });

  HistoryComic copyWith({
    int? userComicReadingHistoryId,
    String? comicName,
    int? viewCount,
    String? comicCoverImageURL,
    String? status,
    String? comicSEOAlias,
    String? chapterSEOAlias,
    num? rating,
    String? chapterName,
    DateTime? dateRead,
  }) {
    return HistoryComic(
      userComicReadingHistoryId:
          userComicReadingHistoryId ?? this.userComicReadingHistoryId,
      comicName: comicName ?? this.comicName,
      viewCount: viewCount ?? this.viewCount,
      comicCoverImageURL: comicCoverImageURL ?? this.comicCoverImageURL,
      status: status ?? this.status,
      comicSEOAlias: comicSEOAlias ?? this.comicSEOAlias,
      chapterSEOAlias: chapterSEOAlias ?? this.chapterSEOAlias,
      rating: rating ?? this.rating,
      chapterName: chapterName ?? this.chapterName,
      dateRead: dateRead ?? this.dateRead,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userComicReadingHistoryId': userComicReadingHistoryId,
      'comicName': comicName,
      'viewCount': viewCount,
      'comicCoverImageURL': comicCoverImageURL,
      'status': status,
      'comicSEOAlias': comicSEOAlias,
      'chapterSEOAlias': chapterSEOAlias,
      'rating': rating,
      'chapterName': chapterName,
      'dateRead': dateRead?.millisecondsSinceEpoch,
    };
  }

  factory HistoryComic.fromMap(Map<String, dynamic> map) {
    return HistoryComic(
      userComicReadingHistoryId: map['userComicReadingHistoryId'] != null
          ? map['userComicReadingHistoryId'] as int
          : null,
      comicName: map['comicName'] != null ? map['comicName'] as String : null,
      viewCount: map['viewCount'] != null ? map['viewCount'] as int : null,
      comicCoverImageURL: map['comicCoverImageURL'] != null
          ? map['comicCoverImageURL'] as String
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      comicSEOAlias:
          map['comicSEOAlias'] != null ? map['comicSEOAlias'] as String : null,
      chapterSEOAlias: map['chapterSEOAlias'] != null
          ? map['chapterSEOAlias'] as String
          : null,
      rating: map['rating'] != null ? map['rating'] as num : null,
      chapterName:
          map['chapterName'] != null ? map['chapterName'] as String : null,
      dateRead: map['dateRead'] != null
          ? DateTime.parse(map['dateRead'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryComic.fromJson(String source) =>
      HistoryComic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      userComicReadingHistoryId,
      comicName,
      viewCount,
      comicCoverImageURL,
      status,
      comicSEOAlias,
      chapterSEOAlias,
      rating,
      chapterName,
      dateRead,
    ];
  }
}
