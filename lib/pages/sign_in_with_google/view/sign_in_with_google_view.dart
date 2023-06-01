// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;

// class LoginPage extends StatelessWidget {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   Future<void> _handleGoogleSignIn() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser != null) {
//         // Gửi thông tin đăng nhập lên máy chủ ASP.NET Core
//         final idToken = googleUser.id;
//         final response = await http.post(
//           Uri.parse('http://localhost:5000/auth/login'),
//           body: idToken,
//           headers: {'Content-Type': 'text/plain'},
//         );

//         if (response.statusCode == 200) {
//           // Xử lý phản hồi thành công từ máy chủ
//         } else {
//           // Xử lý phản hồi thất bại từ máy chủ
//         }
//       } else {
//         // Xử lý thất bại hoặc người dùng đã hủy đăng nhập
//       }
//     } catch (error) {
//       // Xử lý lỗi đăng nhập
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           child: Text('Login with Google'),
//           onPressed: _handleGoogleSignIn,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfisLoggedIn();
  }

  _checkIfisLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    setState(() {
      _checking = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      print("tokens: ${accessToken.toJson()}");
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }

  _login() async {
    final LoginResult result =
        await FacebookAuth.instance.login(permissions: ['email']);

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance
          .getUserData(fields: "name,email,picture.width(200)");
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }
    setState(() {
      _checking = false;
    });
  }

  _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(_userData);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Facebook Auth Project')),
        body: _checking
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _userData != null
                      ? Text('name: ${_userData!['name']}')
                      : Container(),
                  _userData != null
                      ? Text('email: ${_userData!['email']}')
                      : Container(),
                  _userData != null
                      ? Container(
                          child: Image.network(
                              _userData!['picture']['data']['url']),
                        )
                      : Container(),
                  SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                      color: Colors.blue,
                      child: Text(
                        _userData != null ? 'LOGOUT' : 'LOGIN',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _userData != null ? _logout : _login)
                ],
              )),
      ),
    );
  }
}
