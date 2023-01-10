import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String question = ''' 
  1. 아래는 C언어의 2차원 배열 형태이다. field의 경우 2차원 배열 형태는 예시처럼 출력되므로, 이를 참고하여 mines의 2차원 배열 형태를 작성하시오.
  ''';
  bool clickedYn = false;
  int currentQuestion = 0;

  @override
  void initState() {
    Future.delayed(Duration.zero, () => _onLoad());
    super.initState();
  }

  Future<void> _onLoad() async {
    ModalRoute.of(context)!.settings.arguments;
    String jsonString = await rootBundle.loadString('assets/json/2022_3.json');
    final jsonResponse = json.decode(jsonString);
    List<dynamic> data = jsonResponse;
    print(data[0]);
    print(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(question),
            ClipRRect(
              child: Stack(
                children: <Widget>[
                  Image.asset('assets/question_2023_1.png'),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                clickedYn = true;
                setState(() {});
              },
              child: Container(
                child: clickedYn ? Text('눌러서 정답을 확인하세요') : Text('정답'),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                child: Text('다음'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                child: Text('홈으로'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
