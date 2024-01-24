import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simpleweb/counter_state.dart';
import 'package:simpleweb/login_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _increaseOne() {
    Provider.of<CounterState>(context, listen: false).increaseCount(1);
  }

  void _decreaseOne() {
    Provider.of<CounterState>(context, listen: false).decreaseCount(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
            children: [Expanded(child: Text('SimpleWeb')), LoginWidget()]),
      ),
      body: Center(
          child: Column(
        children: [
          const CounterWidget(),
          TextButton(onPressed: _increaseOne, child: const Text('+1')),
          TextButton(onPressed: _decreaseOne, child: const Text('-1')),
        ],
      )),
    );
  }
}
