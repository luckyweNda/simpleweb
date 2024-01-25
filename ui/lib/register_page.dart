import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleweb/login_state.dart';
import 'package:simpleweb/misc/response_struct.dart';

class RegisterBlock extends StatefulWidget {
  const RegisterBlock({super.key});

  @override
  State<RegisterBlock> createState() => _RegisterBlockState();
}

class _RegisterBlockState extends State<RegisterBlock> {
  bool _handlingRegister = false;
  final _usernameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void _handleRegister(BuildContext context) {
    var apiUrl = 'http://127.0.0.1:8080/register';
    var data = {
      'username': _usernameTextController.text,
      'email': _emailTextController.text,
      'password': _passwordTextController.text,
    };

    var jsonData = jsonEncode(data);

    http
        .post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    )
        .then((response) {
      if (response.statusCode != 200) {
        showDialog(
          context: context,
          builder: (context) => const Dialog(
            child: Text("Register fail"),
          ),
        );
      } else {
        final result = LoginResponse.fromString(response.body);
        Provider.of<LoginState>(context)
            .updateUser(result.username, result.email);
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('token', result.token);
        });
        context.go("/");
      }

      setState(() {
        _handlingRegister = false;
      });
    });

    setState(() {
      _handlingRegister = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _usernameTextController,
          decoration: const InputDecoration(labelText: "Enter a username"),
        ),
        TextField(
          controller: _emailTextController,
          decoration: const InputDecoration(labelText: "Enter a email"),
        ),
        TextField(
          controller: _passwordTextController,
          decoration: const InputDecoration(labelText: "Password"),
          obscureText: true,
        ),
        _handlingRegister
            ? const CircularProgressIndicator()
            : Row(
                children: [
                  TextButton(
                      onPressed: () {
                        _handleRegister(context);
                      },
                      child: const Text("Register")),
                  TextButton(
                      onPressed: () => context.go("/"),
                      child: const Text("Go back"))
                ],
              ),
      ],
    );
  }
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: RegisterBlock(),
      ),
    );
  }
}
