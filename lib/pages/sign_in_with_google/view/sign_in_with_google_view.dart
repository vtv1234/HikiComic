import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Gửi thông tin đăng nhập lên máy chủ ASP.NET Core
        final idToken = googleUser.id;
        final response = await http.post(
          Uri.parse('http://localhost:5000/auth/login'),
          body: idToken,
          headers: {'Content-Type': 'text/plain'},
        );

        if (response.statusCode == 200) {
          // Xử lý phản hồi thành công từ máy chủ
        } else {
          // Xử lý phản hồi thất bại từ máy chủ
        }
      } else {
        // Xử lý thất bại hoặc người dùng đã hủy đăng nhập
      }
    } catch (error) {
      // Xử lý lỗi đăng nhập
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Login with Google'),
          onPressed: _handleGoogleSignIn,
        ),
      ),
    );
  }
}
