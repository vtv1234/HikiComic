// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:hikicomic/data/models/artist.dart';
import 'package:hikicomic/data/models/author.dart';
import 'package:hikicomic/data/models/genre.dart';

class ComicDetail extends Equatable {
  final int? comicDetailId;
  final int? comicId;
  final String? comicName;
  final String? alternative;
  final int? viewCount;
  final String? comicCoverImageURL;
  final DateTime? dateCreated;
  final int? newChapterId;
  final num? rating;
  final int? countRating;
  final int? countFollow;
  final String? summary;
  final String? comicSEOSummary;
  final String? comicSEOTitle;
  final String? comicSEOAlias;
  final String? status;
  final bool? isActive;
  final bool? isFollow;
  final List<Artist> artists;
  final List<Author> authors;
  final List<Genre> genres;
  const ComicDetail({
    this.comicDetailId,
    this.comicId,
    this.comicName,
    this.alternative,
    this.viewCount,
    this.comicCoverImageURL,
    this.dateCreated,
    this.newChapterId,
    this.rating,
    this.countRating,
    this.countFollow,
    this.summary,
    this.comicSEOSummary,
    this.comicSEOTitle,
    this.comicSEOAlias,
    this.status,
    this.isActive,
    this.isFollow,
    required this.artists,
    required this.authors,
    required this.genres,
  });

  ComicDetail copyWith({
    int? comicDetailId,
    int? comicId,
    String? comicName,
    String? alternative,
    int? viewCount,
    String? comicCoverImageURL,
    DateTime? dateCreated,
    int? newChapterId,
    num? rating,
    int? countRating,
    int? countFollow,
    String? summary,
    String? comicSEOSummary,
    String? comicSEOTitle,
    String? comicSEOAlias,
    String? status,
    bool? isActive,
    bool? isFollow,
    List<Artist>? artists,
    List<Author>? authors,
    List<Genre>? genres,
  }) {
    return ComicDetail(
      comicDetailId: comicDetailId ?? this.comicDetailId,
      comicId: comicId ?? this.comicId,
      comicName: comicName ?? this.comicName,
      alternative: alternative ?? this.alternative,
      viewCount: viewCount ?? this.viewCount,
      comicCoverImageURL: comicCoverImageURL ?? this.comicCoverImageURL,
      dateCreated: dateCreated ?? this.dateCreated,
      newChapterId: newChapterId ?? this.newChapterId,
      rating: rating ?? this.rating,
      countRating: countRating ?? this.countRating,
      countFollow: countFollow ?? this.countFollow,
      summary: summary ?? this.summary,
      comicSEOSummary: comicSEOSummary ?? this.comicSEOSummary,
      comicSEOTitle: comicSEOTitle ?? this.comicSEOTitle,
      comicSEOAlias: comicSEOAlias ?? this.comicSEOAlias,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      isFollow: isFollow ?? this.isFollow,
      artists: artists ?? this.artists,
      authors: authors ?? this.authors,
      genres: genres ?? this.genres,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comicDetailId': comicDetailId,
      'comicId': comicId,
      'comicName': comicName,
      'alternative': alternative,
      'viewCount': viewCount,
      'comicCoverImageURL': comicCoverImageURL,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'newChapterId': newChapterId,
      'rating': rating,
      'countRating': countRating,
      'countFollow': countFollow,
      'summary': summary,
      'comicSEOSummary': comicSEOSummary,
      'comicSEOTitle': comicSEOTitle,
      'comicSEOAlias': comicSEOAlias,
      'status': status,
      'isActive': isActive,
      'isFollow': isFollow,
      'artists': artists.map((x) => x.toMap()).toList(),
      'authors': authors.map((x) => x.toMap()).toList(),
      'genres': genres.map((x) => x.toMap()).toList(),
    };
  }

  factory ComicDetail.fromMap(Map<String, dynamic> map) {
    return ComicDetail(
      comicDetailId:
          map['comicDetailId'] != null ? map['comicDetailId'] as int : null,
      comicId: map['comicId'] != null ? map['comicId'] as int : null,
      comicName: map['comicName'] != null ? map['comicName'] as String : null,
      alternative:
          map['alternative'] != null ? map['alternative'] as String : null,
      viewCount: map['viewCount'] != null ? map['viewCount'] as int : null,
      comicCoverImageURL: map['comicCoverImageURL'] != null
          ? map['comicCoverImageURL'] as String
          : null,
      dateCreated: map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'] as String)
          : null,
      newChapterId:
          map['newChapterId'] != null ? map['newChapterId'] as int : null,
      rating: map['rating'] != null ? map['rating'] as num : null,
      countRating:
          map['countRating'] != null ? map['countRating'] as int : null,
      countFollow:
          map['countFollow'] != null ? map['countFollow'] as int : null,
      summary: map['summary'] != null ? map['summary'] as String : null,
      comicSEOSummary: map['comicSEOSummary'] != null
          ? map['comicSEOSummary'] as String
          : null,
      comicSEOTitle:
          map['comicSEOTitle'] != null ? map['comicSEOTitle'] as String : null,
      comicSEOAlias:
          map['comicSEOAlias'] != null ? map['comicSEOAlias'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      isFollow: map['isFollow'] != null ? map['isFollow'] as bool : null,
      artists: List<Artist>.from(
        (map['artists'] as List<dynamic>).map<Artist>(
          (x) => Artist.fromMap(x as Map<String, dynamic>),
        ),
      ),
      authors: List<Author>.from(
        (map['authors'] as List<dynamic>).map<Author>(
          (x) => Author.fromMap(x as Map<String, dynamic>),
        ),
      ),
      genres: List<Genre>.from(
        (map['genres'] as List<dynamic>).map<Genre>(
          (x) => Genre.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ComicDetail.fromJson(String source) =>
      ComicDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      comicDetailId,
      comicId,
      comicName,
      alternative,
      viewCount,
      comicCoverImageURL,
      dateCreated,
      newChapterId,
      rating,
      countRating,
      countFollow,
      summary,
      comicSEOSummary,
      comicSEOTitle,
      comicSEOAlias,
      status,
      isActive,
      isFollow,
      artists,
      authors,
      genres,
    ];
  }
}
