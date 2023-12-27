import 'package:flutter/material.dart';

import '../prefrence/sharedpreference.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefManager.init(); // initialize here ! important
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Learning application for interview process',
            theme: ThemeData(
              useMaterial3: true
            ),
      home: LoginScreen(),
    );
  }
}
