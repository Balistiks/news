class FileModel {
  final int _id;
  final String _path;

  int get id => _id;
  String get path => _path;

  FileModel(this._id, this._path);

  Map<String,dynamic> toJson() => {
    'path': _path
  };

  FileModel.fromJson(Map<String,dynamic> json):
    _id = json['id'],
    _path = json['path'];
}

abstract class FileUpload {}
class FileUploadSuccess extends FileUpload {}
class FileUploadFailure extends FileUpload {}