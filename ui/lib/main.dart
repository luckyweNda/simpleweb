import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleweb/counter_state.dart';
import 'package:simpleweb/login_state.dart';
import 'package:simpleweb/main_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginState(),
      ),
      ChangeNotifierProvider(
        create: (_) => CounterState(),
      ),
    ],
    child: const MainApp(),
  ));
}
