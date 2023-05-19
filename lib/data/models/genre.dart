import 'dart:convert';

import 'package:equatable/equatable.dart';

class Genre extends Equatable {
  final int? genreId;
  final String? genreName;
  final String? genreParentId;
  final bool? isShowHome;
  final String? summary;
  final String? genreSEOSummary;

  final String? genreSEOTitle;
  final String? genreSEOAlias;
  final String? genreImageURL;
  final bool? isActive;
  final DateTime? dateCreated;
  const Genre({
    this.genreId,
    this.genreName,
    this.genreParentId,
    this.isShowHome,
    this.summary,
    this.genreSEOSummary,
    this.genreSEOTitle,
    this.genreSEOAlias,
    this.genreImageURL,
    this.isActive,
    this.dateCreated,
  });

  Genre copyWith({
    int? genreId,
    String? genreName,
    String? genreParentId,
    bool? isShowHome,
    String? summary,
    String? genreSEOSummary,
    String? genreSEOTitle,
    String? genreSEOAlias,
    String? genreImageURL,
    bool? isActive,
    DateTime? dateCreated,
  }) {
    return Genre(
      genreId: genreId ?? this.genreId,
      genreName: genreName ?? this.genreName,
      genreParentId: genreParentId ?? this.genreParentId,
      isShowHome: isShowHome ?? this.isShowHome,
      summary: summary ?? this.summary,
      genreSEOSummary: genreSEOSummary ?? this.genreSEOSummary,
      genreSEOTitle: genreSEOTitle ?? this.genreSEOTitle,
      genreSEOAlias: genreSEOAlias ?? this.genreSEOAlias,
      genreImageURL: genreImageURL ?? this.genreImageURL,
      isActive: isActive ?? this.isActive,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'genreId': genreId,
      'genreName': genreName,
      'genreParentId': genreParentId,
      'isShowHome': isShowHome,
      'summary': summary,
      'genreSEOSummary': genreSEOSummary,
      'genreSEOTitle': genreSEOTitle,
      'genreSEOAlias': genreSEOAlias,
      'genreImageURL': genreImageURL,
      'isActive': isActive,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
    };
  }

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      genreId: map['genreId'] != null ? map['genreId'] as int : null,
      genreName: map['genreName'] != null ? map['genreName'] as String : null,
      genreParentId:
          map['genreParentId'] != null ? map['genreParentId'] as String : null,
      isShowHome: map['isShowHome'] != null ? map['isShowHome'] as bool : null,
      summary: map['summary'] != null ? map['summary'] as String : null,
      genreSEOSummary: map['genreSEOSummary'] != null
          ? map['genreSEOSummary'] as String
          : null,
      genreSEOTitle:
          map['genreSEOTitle'] != null ? map['genreSEOTitle'] as String : null,
      genreSEOAlias:
          map['genreSEOAlias'] != null ? map['genreSEOAlias'] as String : null,
      genreImageURL:
          map['genreImageURL'] != null ? map['genreImageURL'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      dateCreated: map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Genre.fromJson(String source) =>
      Genre.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      genreId,
      genreName,
      genreParentId,
      isShowHome,
      summary,
      genreSEOSummary,
      genreSEOTitle,
      genreSEOAlias,
      genreImageURL,
      isActive,
      dateCreated,
    ];
  }
}
