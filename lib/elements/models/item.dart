import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

// Основная информация по карточке
class Item {
  String _idOnServer = "";
  bool _isEnter = false;
  String _type = "";
  String _direction = "";
  File _currentPhoto;
  String _passDate = "";
  String _passTime = "";
  String _currentDate = "";
  String _currentTime = "";
  String _name = "";
  String _image = "";
  String _statusResult = "";

  get isEnter => _isEnter;
  get idOnServer => _idOnServer;
  get name => _name;
  get passDate => _passDate;
  get passTime => _passTime;
  get currentDate => _currentDate;
  get currentTime => _currentTime;
  get direction => _direction;
  get type => _type;
  get currentPhoto => _currentPhoto;
  get image => _image;
  get statusResult => _statusResult;

  set name(String name) {
    this._name = name;
  }

  set idOnServer(String id) {
    this._idOnServer = id;
  }

  set passTime(String time) {
    this._passTime = time;
  }

  set passDate(String date) {
    this._passDate = date;
  }

  set currentTime(String time) {
    this._currentTime = time;
  }

  set currentDate(String date) {
    this._currentDate = date;
  }

  set image(String image) {
    this._image = image;
  }

  set isEnter(bool isEnter) {
    this._isEnter = isEnter;
    _direction = _isEnter ? "Enter" : "Exit";
  }

  set type(String type) {
    this._type = type;
  }

  set statusResult(String text) {
    this._statusResult = text;
  }

  set currentPhoto(File file) {
    this._currentPhoto = new File(file.path);
  }

  String base64Encode(List<int> bytes) => base64.encode(bytes);
  Uint8List base64Decode(String source) => base64.decode(source);
}
