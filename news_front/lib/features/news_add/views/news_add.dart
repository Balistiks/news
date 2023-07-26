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

  _NewsAddState() : super(NewsController()) {
    _controller = controller as NewsController;
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить новость'),
        actions: [
          IconButton(onPressed: () {
            if (_formKey.currentState!.validate()) {
              final news = News(
                -1, titleController.text, textController.text, null
              );
              _controller!.addNews(news, _selectedImage, (status) {
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
          Row(
            children: [
              Text('Фото:', style: Theme.of(context).textTheme.bodyMedium),
              const Padding(padding: EdgeInsets.only(right: 20)),
              ElevatedButton(
                onPressed: () {
                  _pickImageFromCamera();
                },
                child: const Icon(Icons.camera),
              ),
              const Padding(padding: EdgeInsets.only(right: 20)),
              ElevatedButton(
                onPressed: () {
                  _pickImageFromGallery();
                },
                child: const Text('Выбрать из галереи'),
              ),
            ],
          ),
          _selectedImage != null ? Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Image.file(_selectedImage!, height: 250, width: 450)
              ],
            ),
          ) : Container(),
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

  Future _pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}