import 'dart:convert';

import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final int? commentId;
  final int? parentCommentId;
  final DateTime? dateCreated;
  final String? stringDateCreated;
  final String? appUserId;
  final String? userName;
  final String? urlImageUser;
  final int? comicId;
  final int? chapterId;
  final int? like;
  final int? dislike;
  final String? commentContent;
  final bool? isDeleted;
  final List<Comment>? childComments;
  const Comment({
    this.commentId,
    this.parentCommentId,
    this.dateCreated,
    this.stringDateCreated,
    this.appUserId,
    this.userName,
    this.urlImageUser,
    this.comicId,
    this.chapterId,
    this.like,
    this.dislike,
    this.commentContent,
    this.isDeleted,
    this.childComments,
  });

  Comment copyWith({
    int? commentId,
    int? parentCommentId,
    DateTime? dateCreated,
    String? stringDateCreated,
    String? appUserId,
    String? userName,
    String? urlImageUser,
    int? comicId,
    int? chapterId,
    int? like,
    int? dislike,
    String? commentContent,
    bool? isDeleted,
    List<Comment>? childComments,
  }) {
    return Comment(
      commentId: commentId ?? this.commentId,
      parentCommentId: parentCommentId ?? this.parentCommentId,
      dateCreated: dateCreated ?? this.dateCreated,
      stringDateCreated: stringDateCreated ?? this.stringDateCreated,
      appUserId: appUserId ?? this.appUserId,
      userName: userName ?? this.userName,
      urlImageUser: urlImageUser ?? this.urlImageUser,
      comicId: comicId ?? this.comicId,
      chapterId: chapterId ?? this.chapterId,
      like: like ?? this.like,
      dislike: dislike ?? this.dislike,
      commentContent: commentContent ?? this.commentContent,
      isDeleted: isDeleted ?? this.isDeleted,
      childComments: childComments ?? this.childComments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentId': commentId,
      'parentCommentId': parentCommentId,
      'dateCreated': dateCreated?.millisecondsSinceEpoch,
      'stringDateCreated': stringDateCreated,
      'appUserId': appUserId,
      'userName': userName,
      'urlImageUser': urlImageUser,
      'comicId': comicId,
      'chapterId': chapterId,
      'like': like,
      'dislike': dislike,
      'commentContent': commentContent,
      'isDeleted': isDeleted,
      'childComments': childComments?.map((x) => x.toMap()).toList(),
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      commentId: map['commentId'] != null ? map['commentId'] as int : null,
      parentCommentId:
          map['parentCommentId'] != null ? map['parentCommentId'] as int : null,
      dateCreated: map['dateCreated'] != null
          ? DateTime.parse(map['dateCreated'] as String)
          : null,
      stringDateCreated: map['stringDateCreated'] != null
          ? map['stringDateCreated'] as String
          : null,
      appUserId: map['appUserId'] != null ? map['appUserId'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      urlImageUser:
          map['urlImageUser'] != null ? map['urlImageUser'] as String : null,
      comicId: map['comicId'] != null ? map['comicId'] as int : null,
      chapterId: map['chapterId'] != null ? map['chapterId'] as int : null,
      like: map['like'] != null ? map['like'] as int : null,
      dislike: map['dislike'] != null ? map['dislike'] as int : null,
      commentContent: map['commentContent'] != null
          ? map['commentContent'] as String
          : null,
      isDeleted: map['isDeleted'] != null ? map['isDeleted'] as bool : null,
      childComments: map['childComments'] != null
          ? List<Comment>.from(
              (map['childComments'] as List<dynamic>).map<Comment?>(
                (x) => Comment.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      commentId,
      parentCommentId,
      dateCreated,
      stringDateCreated,
      appUserId,
      userName,
      urlImageUser,
      comicId,
      chapterId,
      like,
      dislike,
      commentContent,
      isDeleted,
      childComments,
    ];
  }
}
