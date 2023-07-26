import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:news/controllers/news_controller.dart';
import 'package:news/models/news.dart';

class NewsUpdate extends StatefulWidget {
  const NewsUpdate({super.key});

  @override
  State createState() => _NewsUpdateState();
}

class _NewsUpdateState extends StateMVC<NewsUpdate> {
  late News _news;
  late NewsController _controller;

  _NewsUpdateState() : super(NewsController()) {
    _controller = controller as NewsController;
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is News, 'You must provide News args');
    _news = args as News;
    titleController.text = _news.title;
    textController.text = _news.text;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Изменение новости'),
        actions: [
          IconButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
              final news = News(
                _news.id,
                titleController.text,
                textController.text,
                null
              );
              _controller.updateNews(news.id, news, (status) {
                if (status is NewsUpdateSuccess) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Произошла ошибка при обновлении поста"))
                  );
                }
              });
            }
          },
          icon: const Icon(Icons.check, color: Colors.white,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: _buildContent(),
      )
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.face, color: Colors.cyanAccent,),
              hintText: 'Заголовок',
              hintStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 54, 232, 255)
                )
              ),
            ),
            controller: titleController,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Заголовок пустой';
              if (value.length < 3) return 'Заголовок должен быть не короче 3 символов';
              return null;
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: TextFormField(
              style: Theme.of(context).textTheme.labelSmall,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
                hintText: 'Содержание',
                enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.blueAccent
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 54, 232, 255)
                  )
                ),
              ),
              controller: textController,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Содержание пустое';
                return null;
              },
            ),
          )
        ],
      ),
    );
  }
}