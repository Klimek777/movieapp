import 'package:flutter/material.dart';
import 'package:movieapp/features/movie_flow/movie_flow.dart';
import 'package:movieapp/theme/custom_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie Recommendation',
        darkTheme: CustomTheme.darkTheme(context),
        themeMode: ThemeMode.dark,
        home: const MovieFlow());
  }
}
