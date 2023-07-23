import 'package:flutter/material.dart';
import 'package:news/router/router.dart';
import 'package:news/theme/theme.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Новости',
      theme: mainTheme,
      routes: routes,
    );
  }
}