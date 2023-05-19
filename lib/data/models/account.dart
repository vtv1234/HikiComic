import 'dart:convert';

import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String? appUserId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? dob;
  final String? phoneNumber;
  final String? userImageURL;
  final String? genderName;
  final String? nickname;
  final int? coinsLeft;
  final int? coinsSpent;
  final int? coinsDeposited;
  final int? coinsReceived;
  final String? moreInfo;
  final num? experienced;
  final DateTime? dateModified;
  const Account({
    this.appUserId,
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    this.phoneNumber,
    this.userImageURL,
    this.genderName,
    this.nickname,
    this.coinsLeft,
    this.coinsSpent,
    this.coinsDeposited,
    this.coinsReceived,
    this.moreInfo,
    this.experienced,
    this.dateModified,
  });

  Account copyWith({
    String? appUserId,
    String? firstName,
    String? lastName,
    String? email,
    DateTime? dob,
    String? phoneNumber,
    String? userImageURL,
    String? genderName,
    String? nickname,
    int? coinsLeft,
    int? coinsSpent,
    int? coinsDeposited,
    int? coinsReceived,
    String? moreInfo,
    num? experienced,
    DateTime? dateModified,
  }) {
    return Account(
      appUserId: appUserId ?? this.appUserId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userImageURL: userImageURL ?? this.userImageURL,
      genderName: genderName ?? this.genderName,
      nickname: nickname ?? this.nickname,
      coinsLeft: coinsLeft ?? this.coinsLeft,
      coinsSpent: coinsSpent ?? this.coinsSpent,
      coinsDeposited: coinsDeposited ?? this.coinsDeposited,
      coinsReceived: coinsReceived ?? this.coinsReceived,
      moreInfo: moreInfo ?? this.moreInfo,
      experienced: experienced ?? this.experienced,
      dateModified: dateModified ?? this.dateModified,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'appUserId': appUserId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dob': dob?.millisecondsSinceEpoch,
      'phoneNumber': phoneNumber,
      'userImageURL': userImageURL,
      'genderName': genderName,
      'nickname': nickname,
      'coinsLeft': coinsLeft,
      'coinsSpent': coinsSpent,
      'coinsDeposited': coinsDeposited,
      'coinsReceived': coinsReceived,
      'moreInfo': moreInfo,
      'experienced': experienced,
      'dateModified': dateModified?.millisecondsSinceEpoch,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      appUserId: map['appUserId'] != null ? map['appUserId'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      dob: map['dob'] != null ? DateTime.parse(map['dob'] as String) : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      userImageURL:
          map['userImageURL'] != null ? map['userImageURL'] as String : null,
      genderName:
          map['genderName'] != null ? map['genderName'] as String : null,
      nickname: map['nickname'] != null ? map['nickname'] as String : null,
      coinsLeft: map['coinsLeft'] != null ? map['coinsLeft'] as int : null,
      coinsSpent: map['coinsSpent'] != null ? map['coinsSpent'] as int : null,
      coinsDeposited:
          map['coinsDeposited'] != null ? map['coinsDeposited'] as int : null,
      coinsReceived:
          map['coinsReceived'] != null ? map['coinsReceived'] as int : null,
      moreInfo: map['moreInfo'] != null ? map['moreInfo'] as String : null,
      experienced:
          map['experienced'] != null ? map['experienced'] as num : null,
      dateModified: map['dateModified'] != null
          ? DateTime.parse(map['dateModified'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      appUserId,
      firstName,
      lastName,
      email,
      dob,
      phoneNumber,
      userImageURL,
      genderName,
      nickname,
      coinsLeft,
      coinsSpent,
      coinsDeposited,
      coinsReceived,
      moreInfo,
      experienced,
      dateModified,
    ];
  }
}
