import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news/controllers/file_controller.dart';
import 'package:news/models/file.dart';
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

  Future<NewsAdd> addNews(News news, File? file) async {
    final url = Uri.parse("$SERVER/news");
    final response = await http.post(url, body: news.toJson());
    final newsFromJson = News.fromJson(json.decode(response.body));
    if (file != null) {
      FileController().uploadFile(file, newsFromJson.id, (p0) {});
    }
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

  Future<FileUpload> uploadFile(File file, int id) async {
    final url = Uri.parse('$SERVER/file/upload');
    var length = await file.length();
    debugPrint(length.toString());
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      }, body: jsonEncode({'file': file.readAsBytesSync(), 'newsId': id}));
    // var stream = file.openRead();
    // var length = await file.length();

    // var url = Uri.parse('$SERVER/file/upload');
    // var request = http.MultipartRequest('POST', url);
    // request.fields['title'] = 'Static title';
    // var multipart = http.MultipartFile('image', stream, length);
    // request.files.add(multipart);
    // var response = await request.send();

    if (response.statusCode == 200) {
      return FileUploadSuccess();
    } else {
      return FileUploadFailure();
    }
  }

  Future<FileDelete> deleteFile(String id) async {
    final url = Uri.parse('$SERVER/file/delete?id=$id');
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      return FileDeleteSuccess();
    } else {
      return FileDeleteFailure();
    }
    // final response = await http.post(url, body: news.toJson());
    // final newsFromJson = News.fromJson(json.decode(response.body));
    // if (file != null) {
    //   FileController().uploadFile(file, newsFromJson.id, (p0) {});
    // }
    // if (response.statusCode == 200) {
    //   return NewsAddSuccess();
    // } else {
    //   return NewsAddFailure();
    // }
  }
}
