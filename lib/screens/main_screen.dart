import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('정보처리'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 335,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF000000),
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/practical_test_list_screen');
                  },
                  child: Center(
                    child: Text(
                      '필기 기출문제',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 335,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF000000),
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/practical_test_list_screen');
                  },
                  child: Center(
                    child: Text(
                      '실기 기출문제',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
