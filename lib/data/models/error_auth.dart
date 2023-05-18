// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hikicomic/data/models/response.dart';

class ErrorResponse extends BaseResponse {
  final String? validationErrors;
  final bool? isSuccessed;
  final String? message;
  final int? statusCode;
  final dynamic? resultObj;
  const ErrorResponse({
    this.validationErrors,
    this.isSuccessed,
    this.message,
    this.statusCode,
    this.resultObj,
  });

  ErrorResponse copyWith({
    String? validationErrors,
    bool? isSuccessed,
    String? message,
    int? statusCode,
    dynamic? resultObj,
  }) {
    return ErrorResponse(
      validationErrors: validationErrors ?? this.validationErrors,
      isSuccessed: isSuccessed ?? this.isSuccessed,
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      resultObj: resultObj ?? this.resultObj,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'validationErrors': validationErrors,
      'isSuccessed': isSuccessed,
      'message': message,
      'statusCode': statusCode,
      'resultObj': resultObj,
    };
  }

  factory ErrorResponse.fromMap(Map<String, dynamic> map) {
    return ErrorResponse(
      validationErrors: map['validationErrors'] != null
          ? map['validationErrors'] as dynamic
          : null,
      isSuccessed:
          map['isSuccessed'] != null ? map['isSuccessed'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
      statusCode: map['statusCode'] != null ? map['statusCode'] as int : null,
      resultObj: map['resultObj'] != null ? map['resultObj'] as dynamic : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromJson(String source) =>
      ErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      validationErrors,
      isSuccessed,
      message,
      statusCode,
      resultObj,
    ];
  }
}
