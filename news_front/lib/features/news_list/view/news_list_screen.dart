import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:news/controllers/news_controller.dart';
import 'package:news/features/index.dart';
import 'package:news/models/news.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State createState() => _NewsListScreenState();
}

class _NewsListScreenState extends StateMVC<NewsListScreen> {

  _NewsListScreenState() : super(NewsController()) {
    _controller = controller as NewsController;
  }

  late NewsController _controller;

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Нововсти'),),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/news_add');
        },
      ),
    );
  }

  Widget _buildContent() {
    final state = _controller.currentState;
    if (state is NewsResultLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is NewsResultFailure){
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      final news = (state as NewsResultSuccess).newsList.news;
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: news.length,
          itemBuilder: (context, index) {
            return NewsListItem(news: news[index],);
          },
        ),
      );
    }
  }
}