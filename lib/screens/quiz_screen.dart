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
  bool questionImgUrlYn = false;
  String answer = '';
  bool answerImgUrlYn = false;
  late List<dynamic> data;
  dynamic jsonResponse;
  String testYearAndOrder = '';
  String testYear = '';
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
    testYearAndOrder = args['testOrder'];
    List<String> tmp = testYearAndOrder.split('_');
    testYear = tmp[0];
    testOrder = tmp[1];
    String jsonString = await rootBundle.loadString('assets/json/${args['testOrder']}.json');
    jsonResponse = json.decode(jsonString);
    data = jsonResponse;
    print(data);
    await _onLoad();
  }

  Future<void> _onLoad() async {
    setState(() => _isLoading = true);
    clickedYn = false;
    Map<String, dynamic> currentData = data[currentQuestionNo] as Map<String, dynamic>;
    question = currentData['question'] ?? '';
    questionImgUrlYn = currentData['questionImgYn'] ?? false;
    answer = currentData['answer'] ?? '';
    answerImgUrlYn = currentData['answerImg'] ?? false;
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$testYear년도 $testOrder회차'),
      ),
      body: LoadingWidget(
        isLoading: _isLoading,
        builder: (_) => SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    width: double.maxFinite,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${currentQuestionNo + 1}번 문제.'),
                          Text(question),
                          SizedBox(
                            height: 10,
                          ),
                          if (questionImgUrlYn)
                            ClipRRect(
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/img/$testYearAndOrder/question/${currentQuestionNo + 1}.png',
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentQuestionNo != 0)
                        ElevatedButton(
                            onPressed: () async {
                              currentQuestionNo = currentQuestionNo - 1;
                              await _onLoad();
                              setState(() {});
                            },
                            child: Text('이전')),
                      SizedBox(),
                      if (currentQuestionNo < data.length - 1)
                        ElevatedButton(
                          onPressed: () async {
                            currentQuestionNo = currentQuestionNo + 1;
                            await _onLoad();
                            setState(() {});
                          },
                          child: Text('다음'),
                        ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    clickedYn = !clickedYn;
                    setState(() {});
                  },
                  child: Container(
                    child: clickedYn
                        ? Column(
                            children: [
                              Text(answer),
                            ],
                          )
                        : Text('정답 확인'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
