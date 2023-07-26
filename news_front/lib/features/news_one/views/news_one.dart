import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:news/controllers/news_controller.dart';
import 'package:news/models/file.dart';
import 'package:news/models/news.dart';

class NewsOne extends StatefulWidget {
  const NewsOne({super.key});

  @override
  State createState() => _NewsOneState();
}

class _NewsOneState extends StateMVC<NewsOne> {
  late NewsController _controller;

  _NewsOneState() : super(NewsController()) {
    _controller = controller as NewsController;
  }

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is int, 'You must provide int args');
    int id = args as int;
    _controller.getOneNews(id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новость')),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    final state = _controller.currentResState;
    debugPrint(state.toString());
    if (state is NewsResLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is NewsResFailure) {
      return Center(
        child: Text(
          state.error,
          textAlign: TextAlign.center,
        ),
      );
    } else {
      final news = (state as NewsResSuccess).news;
      final file = news.file as FileModel?;
      return Center(
        child: Container(
          width: 400,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.grey.withOpacity(0.5), width: 0.3)
          ),
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          news.title,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        file != null ? Image.network('http://localhost:3002/file/get?id=${file.sha512hash}', width: 150, height: 100,) : Container(),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/news_update', arguments: news);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent
                          ),
                          child: const Icon(Icons.article_outlined, color: Color.fromARGB(255, 157, 50, 42)),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        ElevatedButton(
                          onPressed: () {
                            _controller.deleteNews(news.id, (status) {
                              if (status is NewsDeleteSuccess) {
                                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Произошла ошибка при удалении поста"))
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent
                          ),
                          child: const Icon(Icons.delete, color: Color.fromARGB(255, 157, 50, 42)),
                        )
                      ],
                    )
                  ]),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  news.text,
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}