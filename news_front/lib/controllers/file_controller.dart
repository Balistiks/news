import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:news/data/repository.dart';
import 'package:news/models/file.dart';

class FileController extends ControllerMVC {
  final Repository repo = Repository();

  FileController();

  void uploadFile(File file, int id, void Function(FileUpload) callback) async {
    try {
      final result = await repo.uploadFile(file, id);
      callback(result);
    } catch (error) {
      debugPrint(error.toString());
      callback(FileUploadFailure());
    }
  }

  void deleteFile(String id, void Function(FileDelete) callback) async {
    try {
      final result = await repo.deleteFile(id);
      callback(result);
    } catch (error) {
      callback(FileDeleteFailure());
    }
  }
}