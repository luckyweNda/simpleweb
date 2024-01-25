import 'dart:convert';

class LoginResponse {
  bool ok;
  String token;
  String username;
  String email;

  LoginResponse({
    required this.ok,
    required this.token,
    required this.username,
    required this.email,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> json) {
    return LoginResponse(
      ok: json['ok'],
      token: json['token'],
      username: json['username'],
      email: json['email'],
    );
  }

  factory LoginResponse.fromString(String jsonString) {
    Map<String, dynamic> jsonData = jsonDecode(jsonString);

    return LoginResponse(
      ok: jsonData['ok'],
      token: jsonData['token'],
      username: jsonData['username'],
      email: jsonData['email'],
    );
  }
}
