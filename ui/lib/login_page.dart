import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:simpleweb/login_state.dart';
import 'package:simpleweb/misc/response_struct.dart';

class LoginBlock extends StatefulWidget {
  const LoginBlock({super.key});

  @override
  State<LoginBlock> createState() => _LoginBlockState();
}

class _LoginBlockState extends State<LoginBlock> {
  bool _handlingLogin = false;
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void _loginButtonCallback(BuildContext context) {
    Map<String, dynamic> jsonData = {
      'email': _emailTextController.text,
      'password': _passwordTextController.text
    };
    String jsonString = jsonEncode(jsonData);

    http
        .post(
      Uri.parse("http://127.0.0.1:8080/login"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonString,
    )
        .then((response) {
      if (response.statusCode != 200) {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Text("Fail to login"),
          ),
        );
      } else {
        final result = LoginResponse.fromString(response.body);
        Provider.of<LoginState>(context)
            .updateUser(result.username, result.email);
        context.go("/");
      }

      setState(() {
        _handlingLogin = false;
      });
    });
    setState(() {
      _handlingLogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailTextController,
          decoration: const InputDecoration(labelText: "Enter your email"),
        ),
        TextField(
          controller: _passwordTextController,
          decoration: const InputDecoration(labelText: "Enter your password"),
          obscureText: true,
        ),
        _handlingLogin
            ? CircularProgressIndicator()
            : TextButton(
                onPressed: () {
                  _loginButtonCallback(context);
                },
                child: Text("Login")),
      ],
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: LoginBlock()),
    );
  }
}
