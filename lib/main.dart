import 'package:craftsman_information_processing/screens/main_screen.dart';
import 'package:craftsman_information_processing/screens/quiz_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '타이틀',
      theme: ThemeData(
        primaryColor: Color(0xFF7C4DFF),
      ),
      onGenerateRoute: (RouteSettings settings) {
        //Fimber.d('onGenerateRoute() call: name=${settings.name}, arguments=${settings.arguments}');
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const MainScreen(), settings: settings);
          case '/quiz_screen':
            return MaterialPageRoute(builder: (_) => const QuizScreen(), settings: settings);
          default:
            return null;
        }
      },
    );
  }
}
