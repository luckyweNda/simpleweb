import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterState with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increaseCount(int number) {
    _count += number;
    notifyListeners();
  }

  void decreaseCount(int number) {
    _count -= number;
    notifyListeners();
  }
}

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('${context.watch<CounterState>().count}');
  }
}
