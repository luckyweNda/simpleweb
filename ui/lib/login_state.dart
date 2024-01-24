import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum EnumLoginState {
  init,
  noLogin,
  hasLogined,
}

class LoginState with ChangeNotifier {
  EnumLoginState _loginState = EnumLoginState.init;

  EnumLoginState get loginState => _loginState;

  void updateState(EnumLoginState state) {
    _loginState = state;
    notifyListeners();
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  void authenticateToken(String token) {
    http.get(
      Uri.parse('http://127.0.0.1:8080/login'),
      headers: {
        HttpHeaders.authorizationHeader: "token",
      },
    ).then((response) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      // TODO: handle token auth response
    });
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      final token = prefs.getString("token");
      if (token == null) {
        Provider.of<LoginState>(context, listen: false)
            .updateState(EnumLoginState.noLogin);
      } else {
        authenticateToken(token);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = context.watch<LoginState>().loginState;
    switch (status) {
      case EnumLoginState.init:
        return const Text('initing');
      case EnumLoginState.noLogin:
        return _NoLogin();
      case EnumLoginState.hasLogined:
        return const Text('login');
      default:
        throw UnimplementedError();
    }
  }
}

class _NoLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(onPressed: () => context.go("/login"), child: const Text("Login")),
        const Text('or'),
        TextButton(
            onPressed: () => context.go("/register"), child: const Text("Register"))
      ],
    );
  }
}
