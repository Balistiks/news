import 'package:flutter/material.dart';
import 'package:news/models/file.dart';
import 'package:news/models/news.dart';

class NewsListItem extends StatelessWidget {
  const NewsListItem({
    super.key,
    this.news
  });

  final News? news;

  @override
  Widget build(BuildContext context) {
    var file = news?.file as FileModel?;
    return Container(
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
            child: Column(
              children: [
                Text(
                  news!.title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                file != null ? Image.network('http://localhost:3002/file/get?id=${file.sha512hash}', width: 150, height: 100,) : Container(),
              ],
            )
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              news!.text,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/news_one', arguments: news!.id);
              },
              child: const Text('Узнать больше')
            ),
          )
        ],
      ),
    );
  }
}