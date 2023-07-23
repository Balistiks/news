import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:news/controllers/news_controller.dart';
import 'package:news/models/news.dart';

class NewsAdd extends StatefulWidget {
  const NewsAdd({super.key});

  @override
  State createState() => _NewsAddState();
}

class _NewsAddState extends StateMVC {
  late NewsController? _controller;
  late XFile? _file;

  _NewsAddState() : super(NewsController()) {
    _controller = controller as NewsController;
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _getImageFromPhotoLibrary(context) {
    _getFile(ImageSource.gallery, context);
  }

  Future<void> _getFile(ImageSource source, BuildContext context) async {
    try {
      final XFile? file = await ImagePicker().pickMedia();
      setState(() {
        _file = file;
        _showBottomSheet(context);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    
  }

  void _showBottomSheet(context) {
    if (_file != null) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return Center(
                child: LimitedBox(
              maxHeight: 300,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Image.file(File(_file!.path));
                },
              ),
            ));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить новость'),
        actions: [
          IconButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
              final news = News(
                -1, titleController.text, textController.text
              );
              _controller!.addNews(news, (status) {
                if(status is NewsAddSuccess) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Произошла ошибка при добавлении поста"))
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
      ),
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