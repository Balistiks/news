import 'package:flutter/material.dart';
import 'package:news/models/file.dart';

class News {
  final int _id;
  final String _title;
  final String _text;
  final Object? _file;

  int get id => _id;
  String get title => _title;
  String get text => _text;
  Object? get file => _file;

  News(this._id, this._title, this._text, this._file);

  Map<String,dynamic> toJson() => {
    'title': _title,
    'text': _text
  };

  News.fromJson(Map<String, dynamic> json) :
    _id = json['id'],
    _title = json['title'],
    _text = json['text'],
    _file = json['File'] != null ? FileModel.fromJson(json['File']) : null;
}

class NewsList {
  final List<News> news = [];

  NewsList.fromJson(List<dynamic> jsonItems) {
    for (var jsonItem in jsonItems) {
      debugPrint(jsonItem.toString());
      news.add(News.fromJson(jsonItem));
    }
  }
}

abstract class NewsRes {}
class NewsResSuccess extends NewsRes {
  final News news;
  NewsResSuccess(this.news);
}
class NewsResFailure extends NewsRes {
  final String error;
  NewsResFailure(this.error);
}
class NewsResLoading extends NewsRes {
  NewsResLoading();
}


abstract class NewsResult {}
class NewsResultSuccess extends NewsResult {
  final NewsList newsList;
  NewsResultSuccess(this.newsList);
}
class NewsResultFailure extends NewsResult {
  final String error;
  NewsResultFailure(this.error);
}
class NewsResultLoading extends NewsResult {
  NewsResultLoading();
}


abstract class NewsAdd {}
class NewsAddSuccess extends NewsAdd {}
class NewsAddFailure extends NewsAdd {}


abstract class NewsDelete {}
class NewsDeleteSuccess extends NewsDelete {}
class NewsDeleteFailure extends NewsDelete {}


abstract class NewsUpdate {}
class NewsUpdateSuccess extends NewsUpdate {}
class NewsUpdateFailure extends NewsUpdate {}
