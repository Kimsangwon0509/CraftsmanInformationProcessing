import 'dart:convert';

import 'package:craftsman_information_processing/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _isLoading = true;
  String question = ''' 
  1. 아래는 C언어의 2차원 배열 형태이다. field의 경우 2차원 배열 형태는 예시처럼 출력되므로, 이를 참고하여 mines의 2차원 배열 형태를 작성하시오.
  ''';
  bool clickedYn = false;
  int currentQuestionNo = 0;
  String questionImgUrl = '';
  String answer = '';
  String answerImgUrl = '';
  dynamic jsonResponse;
  String testOrder = '';

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await _jsonLoad();
    });
    super.initState();
  }

  Future<void> _jsonLoad() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    testOrder = args['testOrder'];
    String jsonString = await rootBundle.loadString('assets/json/${args['testOrder']}.json');
    print(args);
    jsonResponse = json.decode(jsonString);
    await _onLoad();
  }

  Future<void> _onLoad() async {
    setState(() => _isLoading = true);
    List<dynamic> data = jsonResponse;
    Map<String, dynamic> currentData = data[currentQuestionNo] as Map<String, dynamic>;
    question = currentData['question'] ?? '';
    questionImgUrl = currentData['questionImg'] ?? '';
    answer = currentData['answer'] ?? '';
    answerImgUrl = currentData['answerImg'] ?? '';

    print(data[currentQuestionNo]);
    print(jsonResponse);
    print(questionImgUrl);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: LoadingWidget(
        isLoading: _isLoading,
        builder: (_) => SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(question),
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      child: Stack(
                        children: <Widget>[
                          Image.asset(
                            'assets/img/$testOrder/question/${currentQuestionNo + 1}.png',
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (currentQuestionNo != 0)
                      InkWell(
                        onTap: () async {
                          currentQuestionNo = currentQuestionNo - 1;
                          await _onLoad();
                          setState(() {});
                        },
                        child: Container(
                          child: Text('이전'),
                        ),
                      ),
                    SizedBox(),
                    if (currentQuestionNo != 20)
                      InkWell(
                        onTap: () async {
                          currentQuestionNo = currentQuestionNo + 1;
                          await _onLoad();
                          setState(() {});
                        },
                        child: Container(
                          child: Text('다음'),
                        ),
                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
