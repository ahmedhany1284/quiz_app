import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/layout/home_layout.dart';
import 'package:quiz_app/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        home: HomeLayout(),
      ),
    );
  }
}

class QuizProvider extends ChangeNotifier {
  int _score = 0;

  int get score => _score;

  void increaseScore() {
    _score++;
    notifyListeners();
  }

  void resetScore() {
    _score = 0;
    notifyListeners();
  }
}
