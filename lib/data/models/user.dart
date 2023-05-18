// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final String? userName;
  final String? email;
  final DateTime? dob;
  final String? genderName;
  final bool? isActive;
  final String? userImageURL;
  final bool? lockoutEnabled;
  final List<String>? roles;

  static const empty = User();
  const User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.userName,
    this.email,
    this.dob,
    this.genderName,
    this.isActive,
    this.userImageURL,
    this.lockoutEnabled,
    this.roles,
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? userName,
    String? email,
    DateTime? dob,
    String? genderName,
    bool? isActive,
    String? userImageURL,
    bool? lockoutEnabled,
    List<String>? roles,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      genderName: genderName ?? this.genderName,
      isActive: isActive ?? this.isActive,
      userImageURL: userImageURL ?? this.userImageURL,
      lockoutEnabled: lockoutEnabled ?? this.lockoutEnabled,
      roles: roles ?? this.roles,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'email': email,
      'dob': dob?.millisecondsSinceEpoch,
      'genderName': genderName,
      'isActive': isActive,
      'userImageURL': userImageURL,
      'lockoutEnabled': lockoutEnabled,
      'roles': roles,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      dob: map['dob'] != null ? DateTime.parse(map['dob'] as String) : null,
      genderName:
          map['genderName'] != null ? map['genderName'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      userImageURL:
          map['userImageURL'] != null ? map['userImageURL'] as String : null,
      lockoutEnabled:
          map['lockoutEnabled'] != null ? map['lockoutEnabled'] as bool : null,
      roles: map['roles'] != null
          ? List<String>.from((map['roles'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      firstName,
      lastName,
      phoneNumber,
      userName,
      email,
      dob,
      genderName,
      isActive,
      userImageURL,
      lockoutEnabled,
      roles,
    ];
  }
}
