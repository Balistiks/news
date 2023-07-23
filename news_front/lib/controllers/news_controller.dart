import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:news/data/repository.dart';
import 'package:news/models/news.dart';

class NewsController extends ControllerMVC {
  final Repository repo = Repository();

  NewsController();

  NewsResult currentState = NewsResultLoading();
  NewsRes currentResState = NewsResLoading();

  void init() async {
    try {
      final newsList = await repo.fetchNews();
      setState(() => currentState = NewsResultSuccess(newsList));
    } catch (error) {
      setState(() => currentState = NewsResultFailure('Нет интернета'));
    }
  }

  void addNews(News news, void Function(NewsAdd) callback) async {
    try {
      final result = await repo.addNews(news);
      callback(result);
    } catch (error) {
      callback(NewsAddFailure());
    }
  }

  void getOneNews(int id) async {
    try {
      final news = await repo.getOneNews(id);
      setState(() => currentResState = NewsResSuccess(news));
    } catch (error) {
      setState(() => currentResState = NewsResFailure('Нет интернета'));
    }
  }

  void deleteNews(int id, void Function(NewsDelete) callback) async {
    try {
      final result = await repo.deleteNews(id);
      callback(result);
    } catch (error) {
      callback(NewsDeleteFailure());
    }
  }

  void updateNews(int id, News news, void Function(NewsUpdate) callback) async {
    try {
      final result = await repo.updateNews(id, news);
      callback(result);
    } catch (error) {
      callback(NewsUpdateFailure());
    }
  }
}