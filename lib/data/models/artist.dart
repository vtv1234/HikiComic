import 'dart:convert';

import 'package:equatable/equatable.dart';

class Artist extends Equatable {
  final int? artistId;
  final String? artistName;
  final String? alternative;
  final String? summary;
  final String? artistSEOSummary;
  final String? artistSEOTitle;
  final String? artistSEOAlias;
  final DateTime? dateCreated;
  final bool? isActive;
  const Artist({
    this.artistId,
    this.artistName,
    this.alternative,
    this.summary,
    this.artistSEOSummary,
    this.artistSEOTitle,
    this.artistSEOAlias,
    this.dateCreated,
    this.isActive,
  });

  Artist copyWith({
    int? artistId,
    String? artistName,
    String? alternative,
    String? summary,
    String? artistSEOSummary,
    String? artistSEOTitle,
    String? artistSEOAlias,
    DateTime? dateCreated,
    bool? isActive,
  }) {
    return Artist(
      artistId: artistId ?? this.artistId,
      artistName: artistName ?? this.artistName,
      alternative: alternative ?? this.alternative,
      summary: summary ?? this.summary,
      artistSEOSummary: artistSEOSummary ?? this.artistSEOSummary,
      artistSEOTitle: artistSEOTitle ?? this.artistSEOTitle,
      artistSEOAlias: artistSEOAlias ?? this.artistSEOAlias,
      dateCreated: dateCreated ?? this.dateCreated,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'artistId': artistId,
      'artistName': artistName,
      'alternative': alternative,
      'summary': summary,
      'artistSEOSummary': artistSEOSummary,
      'artistSEOTitle': artistSEOTitle,
      'artistSEOAlias': artistSEOAlias,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'isActive': isActive,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      artistId: map['artistId'] != null ? map['artistId'] as int : null,
      artistName:
          map['artistName'] != null ? map['artistName'] as String : null,
      alternative:
          map['alternative'] != null ? map['alternative'] as String : null,
      summary: map['summary'] != null ? map['summary'] as String : null,
      artistSEOSummary: map['artistSEOSummary'] != null
          ? map['artistSEOSummary'] as String
          : null,
      artistSEOTitle: map['artistSEOTitle'] != null
          ? map['artistSEOTitle'] as String
          : null,
      artistSEOAlias: map['artistSEOAlias'] != null
          ? map['artistSEOAlias'] as String
          : null,
      dateCreated: map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'] as String)
          : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Artist.fromJson(String source) =>
      Artist.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      artistId,
      artistName,
      alternative,
      summary,
      artistSEOSummary,
      artistSEOTitle,
      artistSEOAlias,
      dateCreated,
      isActive,
    ];
  }
}
