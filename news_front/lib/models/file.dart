class FileModel {
  final int _id;
  final String _sha512hash;

  int get id => _id;
  String get sha512hash => _sha512hash;

  FileModel(this._id, this._sha512hash);

  Map<String,dynamic> toJson() => {
    'path': _sha512hash
  };

  FileModel.fromJson(Map<String,dynamic> json):
    _id = json['id'],
    _sha512hash = json['sha512hash'];
}

abstract class FileUpload {}
class FileUploadSuccess extends FileUpload {}
class FileUploadFailure extends FileUpload {}

abstract class FileDelete {}
class FileDeleteSuccess extends FileDelete {}
class FileDeleteFailure extends FileDelete {}