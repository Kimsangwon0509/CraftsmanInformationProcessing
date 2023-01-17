import 'package:craftsman_information_processing/screens/main_screen.dart';
import 'package:craftsman_information_processing/screens/practical_quiz_screen.dart';
import 'package:craftsman_information_processing/screens/practical_test_list_screen.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios': '[YOUR iOS AD UNIT ID]',
        'android': 'ca-app-pub-7769105461946347/3412621075',
      }
    : {
        'ios': 'ca-app-pub-3940256099942544/2934735716',
        'android': 'ca-app-pub-3940256099942544/6300978111',
      };

void main() {
  Fimber.plantTree(DebugTree());
  // app code here ...

  // DebugTree options for time elapsed
  // by default DebugTree will output timestamp of the VM/Flutter app
  // to enable elapsed time since planting the tree log
  Fimber.plantTree(DebugTree.elapsed());
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
        Fimber.d('onGenerateRoute() call: name=${settings.name}, arguments=${settings.arguments}');
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const MainScreen(), settings: settings);
          case '/practical_test_list_screen':
            return MaterialPageRoute(builder: (_) => const PracticalTestListScreen(), settings: settings);
          case '/practical_quiz_screen':
            return MaterialPageRoute(builder: (_) => const QuizScreen(), settings: settings);
          default:
            return null;
        }
      },
    );
  }
}
