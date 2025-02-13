import 'package:flutter/material.dart';
import 'theme/theme.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/new_event/step_1.dart';
import 'screens/new_event/step_2.dart';
import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Control',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}