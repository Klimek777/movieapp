import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/features/movie_flow/movie_flow.dart';
import 'package:movieapp/theme/custom_theme.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
  ));
});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie Recommendation',
        darkTheme: CustomTheme.darkTheme(context),
        themeMode: ThemeMode.dark,
        home: MovieFlow());
  }
}
