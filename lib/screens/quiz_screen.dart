import 'package:flutter/material.dart';
import 'package:quiz_app/model/model.dart';
import 'dart:convert';
class QuizScreen extends StatefulWidget {
  const QuizScreen(String s, {Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  late List<questions> _quizData;

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  void _loadQuizData() async {
    final jsonString = await DefaultAssetBundle.of(context).loadString('assets/quiz_data.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    _quizData = jsonList.map((json) => questions.fromJson(json)).toList();
    setState(() {});
  }

  void _checkAnswer(String chosenAnswer) {
    if (_quizData[_currentQuestionIndex].answer == chosenAnswer) {
      setState(() {
        _score++;
      });
    }

    // Move to the next question
    if (_currentQuestionIndex < _quizData.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_quizData == null) {
      return CircularProgressIndicator();
    }

    return Scaffold(
      appBar: AppBar(title: Text('Quiz App')),
      body: Column(
        children: [
          Text(
            _quizData[_currentQuestionIndex].question ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(onPressed: () => _checkAnswer(_quizData[_currentQuestionIndex].a ?? ''), child: Text(_quizData[_currentQuestionIndex].a ?? '')),
          ElevatedButton(onPressed: () => _checkAnswer(_quizData[_currentQuestionIndex].b ?? ''), child: Text(_quizData[_currentQuestionIndex].b ?? '')),
          ElevatedButton(onPressed: () => _checkAnswer(_quizData[_currentQuestionIndex].c ?? ''), child: Text(_quizData[_currentQuestionIndex].c ?? '')),
          ElevatedButton(onPressed: () => _checkAnswer(_quizData[_currentQuestionIndex].d ?? ''), child: Text(_quizData[_currentQuestionIndex].d ?? '')),
          Text('Score: $_score'),
        ],
      ),
    );
  }
}