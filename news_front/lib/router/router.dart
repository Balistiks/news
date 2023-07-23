import 'package:news/features/index.dart';
import 'package:news/features/news_one/views/news_one.dart';
import 'package:news/features/news_update/views/news_update.dart';

final routes = {
  '/': (context) => const NewsListScreen(),
  '/news_one': (context) => const NewsOne(),
  '/news_update': (context) => const NewsUpdate(),
  '/news_add': (context) => const NewsAdd()
};