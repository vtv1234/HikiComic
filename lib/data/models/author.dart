// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final int? authorId;
  final String? authorName;
  final String? alternative;
  final String? summary;
  final String? authorSEOSummary;
  final String? authorSEOTitle;
  final DateTime? dateCreated;
  final bool? isActive;
  final String? authorSEOAlias;
  const Author({
    this.authorId,
    this.authorName,
    this.alternative,
    this.summary,
    this.authorSEOSummary,
    this.authorSEOTitle,
    this.dateCreated,
    this.isActive,
    this.authorSEOAlias,
  });

  Author copyWith({
    int? authorId,
    String? authorName,
    String? alternative,
    String? summary,
    String? authorSEOSummary,
    String? authorSEOTitle,
    DateTime? dateCreated,
    bool? isActive,
    String? authorSEOAlias,
  }) {
    return Author(
      authorId: authorId ?? this.authorId,
      authorName: authorName ?? this.authorName,
      alternative: alternative ?? this.alternative,
      summary: summary ?? this.summary,
      authorSEOSummary: authorSEOSummary ?? this.authorSEOSummary,
      authorSEOTitle: authorSEOTitle ?? this.authorSEOTitle,
      dateCreated: dateCreated ?? this.dateCreated,
      isActive: isActive ?? this.isActive,
      authorSEOAlias: authorSEOAlias ?? this.authorSEOAlias,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authorId': authorId,
      'authorName': authorName,
      'alternative': alternative,
      'summary': summary,
      'authorSEOSummary': authorSEOSummary,
      'authorSEOTitle': authorSEOTitle,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'isActive': isActive,
      'authorSEOAlias': authorSEOAlias,
    };
  }

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      authorId: map['authorId'] != null ? map['authorId'] as int : null,
      authorName:
          map['authorName'] != null ? map['authorName'] as String : null,
      alternative:
          map['alternative'] != null ? map['alternative'] as String : null,
      summary: map['summary'] != null ? map['summary'] as String : null,
      authorSEOSummary: map['authorSEOSummary'] != null
          ? map['authorSEOSummary'] as String
          : null,
      authorSEOTitle: map['authorSEOTitle'] != null
          ? map['authorSEOTitle'] as String
          : null,
      dateCreated: map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'] as String)
          : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      authorSEOAlias: map['authorSEOAlias'] != null
          ? map['authorSEOAlias'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Author.fromJson(String source) =>
      Author.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      authorId,
      authorName,
      alternative,
      summary,
      authorSEOSummary,
      authorSEOTitle,
      dateCreated,
      isActive,
      authorSEOAlias,
    ];
  }
}
