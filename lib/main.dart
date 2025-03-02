import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/theme.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/new_event_form/new_event_form.dart';
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
      supportedLocales: const [
        Locale('es'),
        Locale('en', 'US')
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      home: NewEventForm(),
    );
  }
}