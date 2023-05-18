// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:hikicomic/data/models/chapter.dart';

class Comic extends Equatable {
  final int? comicId;

  final String? comicName;

  final String? alternative;

  final int? viewCount;

  final String? comicCoverImageURL;

  final DateTime? dateCreated;

  final bool? isActive;

  final int? newChapterId;

  final String? comicSEOAlias;

  final num? rating;

  final String? status;

  final int? readChapterId;

  final num? pointDay;

  final num? pointWeek;

  final num? pointMonth;

  final num? pointYear;

  final List<Chapter>? chapters;
  const Comic({
    this.comicId,
    this.comicName,
    this.alternative,
    this.viewCount,
    this.comicCoverImageURL,
    this.dateCreated,
    this.isActive,
    this.newChapterId,
    this.comicSEOAlias,
    this.rating,
    this.status,
    this.readChapterId,
    this.pointDay,
    this.pointWeek,
    this.pointMonth,
    this.pointYear,
    this.chapters,
  });

  Comic copyWith({
    int? comicId,
    String? comicName,
    String? alternative,
    int? viewCount,
    String? comicCoverImageURL,
    DateTime? dateCreated,
    bool? isActive,
    int? newChapterId,
    String? comicSEOAlias,
    num? rating,
    String? status,
    int? readChapterId,
    num? pointDay,
    num? pointWeek,
    num? pointMonth,
    num? pointYear,
    List<Chapter>? chapters,
  }) {
    return Comic(
      comicId: comicId ?? this.comicId,
      comicName: comicName ?? this.comicName,
      alternative: alternative ?? this.alternative,
      viewCount: viewCount ?? this.viewCount,
      comicCoverImageURL: comicCoverImageURL ?? this.comicCoverImageURL,
      dateCreated: dateCreated ?? this.dateCreated,
      isActive: isActive ?? this.isActive,
      newChapterId: newChapterId ?? this.newChapterId,
      comicSEOAlias: comicSEOAlias ?? this.comicSEOAlias,
      rating: rating ?? this.rating,
      status: status ?? this.status,
      readChapterId: readChapterId ?? this.readChapterId,
      pointDay: pointDay ?? this.pointDay,
      pointWeek: pointWeek ?? this.pointWeek,
      pointMonth: pointMonth ?? this.pointMonth,
      pointYear: pointYear ?? this.pointYear,
      chapters: chapters ?? this.chapters,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comicId': comicId,
      'comicName': comicName,
      'alternative': alternative,
      'viewCount': viewCount,
      'comicCoverImageURL': comicCoverImageURL,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'isActive': isActive,
      'newChapterId': newChapterId,
      'comicSEOAlias': comicSEOAlias,
      'rating': rating,
      'status': status,
      'readChapterId': readChapterId,
      'pointDay': pointDay,
      'pointWeek': pointWeek,
      'pointMonth': pointMonth,
      'pointYear': pointYear,
      'chapters': chapters?.map((x) => x.toMap()).toList(),
    };
  }

  factory Comic.fromMap(Map<String, dynamic> map) {
    return Comic(
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
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      newChapterId:
          map['newChapterId'] != null ? map['newChapterId'] as int : null,
      comicSEOAlias:
          map['comicSEOAlias'] != null ? map['comicSEOAlias'] as String : null,
      rating: map['rating'] != null ? map['rating'] as num : null,
      status: map['status'] != null ? map['status'] as String : null,
      readChapterId:
          map['readChapterId'] != null ? map['readChapterId'] as int : null,
      pointDay: map['pointDay'] != null ? map['pointDay'] as num : null,
      pointWeek: map['pointWeek'] != null ? map['pointWeek'] as num : null,
      pointMonth: map['pointMonth'] != null ? map['pointMonth'] as num : null,
      pointYear: map['pointYear'] != null ? map['pointYear'] as num : null,
      chapters: map['chapters'] != null
          ? List<Chapter>.from(
              (map['chapters'] as List<dynamic>).map<Chapter?>(
                (x) => Chapter.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comic.fromJson(String source) =>
      Comic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      comicId,
      comicName,
      alternative,
      viewCount,
      comicCoverImageURL,
      dateCreated,
      isActive,
      newChapterId,
      comicSEOAlias,
      rating,
      status,
      readChapterId,
      pointDay,
      pointWeek,
      pointMonth,
      pointYear,
      chapters,
    ];
  }
}
