import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/models/news.dart';

const String SERVER = "http://localhost:3002";

class Repository {
  Future<NewsList> fetchNews() async {
    final url = Uri.parse("$SERVER/news");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return NewsList.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed request");
    }
  }

  Future<NewsAdd> addNews(News news) async {
    final url = Uri.parse("$SERVER/news");
    final response = await http.post(url, body: news.toJson());
    if (response.statusCode == 200) {
      return NewsAddSuccess();
    } else {
      return NewsAddFailure();
    }
  }

  Future<News> getOneNews(int id) async {
    final url = Uri.parse('$SERVER/news/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return News.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed request");
    }
  }

  Future<NewsDelete> deleteNews(int id) async {
    final url = Uri.parse('$SERVER/news/$id');
    final response = await http.delete(url);
    if (response.statusCode == 204) {
      return NewsDeleteSuccess();
    } else {
      return NewsDeleteFailure();
    }
  }

  Future<NewsUpdate> updateNews(int id, News news) async {
    final url = Uri.parse('$SERVER/news/$id');
    final response = await http.put(url, body: news.toJson());
    if (response.statusCode == 200) {
      return NewsUpdateSuccess();
    } else {
      return NewsUpdateFailure();
    }
  }
}
