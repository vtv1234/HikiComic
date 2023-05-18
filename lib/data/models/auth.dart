// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class Auth {
//   final String? token;
//   final String? dateExpire;
//   Auth({
//     this.token,
//     this.dateExpire,
//   });

//   Auth copyWith({
//     String? token,
//     String? dateExpire,
//   }) {
//     return Auth(
//       token: token ?? this.token,
//       dateExpire: dateExpire ?? this.dateExpire,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'token': token,
//       'dateExpire': dateExpire,
//     };
//   }

//   factory Auth.fromMap(Map<String, dynamic> map) {
//     return Auth(
//       token: map['re'] != null ? map['token'] as String : null,
//       dateExpire: map['dateExpire'] != null ? map['dateExpire'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Auth.fromJson(String source) => Auth.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'Auth(token: $token, dateExpire: $dateExpire)';

//   @override
//   bool operator ==(covariant Auth other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.token == token &&
//       other.dateExpire == dateExpire;
//   }

//   @override
//   int get hashCode => token.hashCode ^ dateExpire.hashCode;
// }
