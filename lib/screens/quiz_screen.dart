import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final ValueNotifier<bool> _isDataFetched = ValueNotifier(false);
  late List<questions> _quizData;

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  Future<String> _loadAsset() async {
    String quizString = await rootBundle.loadString('assets/quiz.json');
    _isDataFetched.value = true;
    return quizString;
  }

  void _loadQuizData() async {
    String jsonString = await _loadAsset();
    final List<dynamic> jsonList = json.decode(jsonString);
    _quizData = jsonList.map((json) => questions.fromJson(json)).toList();
    setState(() {});
  }

  void _checkAnswer(String chosenAnswer) {
    print("Correct answer: ${_quizData[_currentQuestionIndex]}");
    print("Chosen answer: $chosenAnswer");

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
    }
  }

  @override
  Widget build(BuildContext context) {
    print('QuizScreen build ${_isDataFetched.value}');
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: _isDataFetched,
          builder: (context, value, child) => !value
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                    children: [
                      const SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          child: Text(
                            _quizData[_currentQuestionIndex].question ?? '',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .40,
                            child: ElevatedButton(
                              onPressed: () => _checkAnswer(
                                _quizData[_currentQuestionIndex].a ?? '',
                              ),
                              child: Text(
                                _quizData[_currentQuestionIndex].a ?? '',
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .40,
                            child: ElevatedButton(
                              onPressed: () => _checkAnswer(
                                _quizData[_currentQuestionIndex].b ?? '',
                              ),
                              child: Text(
                                _quizData[_currentQuestionIndex].b ?? '',
                                style: TextStyle(
                                  fontSize: 50.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .40,
                            child: ElevatedButton(
                              onPressed: () => _checkAnswer(
                                _quizData[_currentQuestionIndex].c ?? '',
                              ),
                              child: Text(
                                _quizData[_currentQuestionIndex].c ?? '',
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .40,
                            child: ElevatedButton(
                              onPressed: () => _checkAnswer(
                                _quizData[_currentQuestionIndex].d ?? '',
                              ),
                              child: Text(
                                _quizData[_currentQuestionIndex].d ?? '',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Text('Score: $_score'),
                    ],
                  ),
              )),
    );
  }
}
