import 'dart:async';
import 'dart:convert';

import 'package:hikicomic/data/models/error_auth.dart';
import 'package:hikicomic/data/models/response.dart';

import 'package:hikicomic/utils/apis.dart';
import 'package:hikicomic/utils/utils.dart';
import 'package:http/http.dart' as http;

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final utils = Utils();
  final controller = StreamController<AuthenticationStatus>();
  Stream<AuthenticationStatus> get status async* {
    //await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* controller.stream;
  }

  Future<Map<String, dynamic>> login(
      {required String email,
      required String password,
      required bool rememberMe}) async {
    final response = await http.post(
      Uri.parse(Apis.login),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {"email": email, "password": password, "rememberMe": rememberMe}),
    );
    // if (response.statusCode == 200) {
    final jsonResult = jsonDecode(response.body);
    if (jsonResult['isSuccessed'] == true) {
      final result = BaseResponse(
          isSuccessed: jsonResult['isSuccessed'] as bool,
          message: jsonResult['message'],
          statusCode: jsonResult['statusCode'] as int,
          ressultObj: jsonResult['resultObj'] as String);
      return {'isSuccessed': true, 'result': result};
    }
    return {'isSuccessed': false, 'result': ErrorResponse.fromMap(jsonResult)};
  }

  Future<void> logOut() async {
    await utils.deleteAllSecureData();

    controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => controller.close();
  Future<Map<String, dynamic>> register(
      {required String email,
      required String password,
      required String confirmPassword}) async {
    final response = await http.post(
      Uri.parse(Apis.register),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword
      }),
    );
    // if (response.statusCode == 200) {
    final jsonResult = jsonDecode(response.body);
    if (jsonResult['isSuccessed'] == true) {
      final result = BaseResponse(
          isSuccessed: jsonResult['isSuccessed'] as bool,
          message: jsonResult['message'],
          statusCode: jsonResult['statusCode'] as int,
          ressultObj: jsonResult['resultObj'] as dynamic);
      return {'isSuccessed': true, 'result': result};
    }
    return {'isSuccessed': false, 'result': ErrorResponse.fromMap(jsonResult)};
  }

  Future<Map<String, dynamic>> verifyEmail(
      {required String email,
      required String password,
      required String otp}) async {
    final response = await http.post(
      Uri.parse(Apis.verifyEmail),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password, "otp": otp}),
    );
    // if (response.statusCode == 200) {
    final jsonResult = jsonDecode(response.body);
    if (jsonResult['isSuccessed'] == true) {
      final result = BaseResponse(
          isSuccessed: jsonResult['isSuccessed'] as bool,
          message: jsonResult['message'],
          statusCode: jsonResult['statusCode'] as int,
          ressultObj: jsonResult['resultObj'] as dynamic);
      return {'isSuccessed': true, 'result': result};
    }
    return {'isSuccessed': false, 'result': ErrorResponse.fromMap(jsonResult)};
  }

  Future<Map<String, dynamic>> resendEmailVerification({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse(Apis.resendEmailVerification),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );
    // if (response.statusCode == 200) {
    final jsonResult = jsonDecode(response.body);
    if (jsonResult['isSuccessed'] == true) {
      final result = BaseResponse(
          isSuccessed: jsonResult['isSuccessed'] as bool,
          message: jsonResult['message'],
          statusCode: jsonResult['statusCode'] as int,
          ressultObj: jsonResult['resultObj'] as dynamic);
      return {'isSuccessed': true, 'result': result};
    }
    return {'isSuccessed': false, 'result': ErrorResponse.fromMap(jsonResult)};
  }

  Future<Map<String, dynamic>> forgotPassword({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('${Apis.forgotPassword}?email=${email.replaceAll("@", "%40")}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email}),
    );
    // if (response.statusCode == 200) {
    final jsonResult = jsonDecode(response.body);
    if (jsonResult['isSuccessed'] == true) {
      final result = BaseResponse(
          isSuccessed: jsonResult['isSuccessed'] as bool,
          message: jsonResult['message'],
          statusCode: jsonResult['statusCode'] as int,
          ressultObj: jsonResult['resultObj'] as dynamic);
      return {'isSuccessed': true, 'result': result};
    }
    return {'isSuccessed': false, 'result': ErrorResponse.fromMap(jsonResult)};
  }

  Future<Map<String, dynamic>> verifyForgotPassword(
      {required String email, required String otp}) async {
    final response = await http.post(
      Uri.parse(Apis.verifyForgotPassword),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "otp": otp}),
    );
    // if (response.statusCode == 200) {
    final jsonResult = jsonDecode(response.body);
    if (jsonResult['isSuccessed'] == true) {
      final result = BaseResponse(
          isSuccessed: jsonResult['isSuccessed'] as bool,
          message: jsonResult['message'],
          statusCode: jsonResult['statusCode'] as int,
          ressultObj: jsonResult['resultObj'] as dynamic);
      return {'isSuccessed': true, 'result': result};
    }
    return {'isSuccessed': false, 'result': ErrorResponse.fromMap(jsonResult)};
  }
}
