import 'dart:io';

class Item {
  String _id = "";
  bool _isEnter = false;
  String _type = "Driver";
  String _direction = "";
  File _currentPhoto;
  bool _hasFace = false;
  String _eventDate = "";
  String _eventTime = "";
  String _name = "";

  // Item(int id) {
  //   _id = id.toString();
  // }

  get isEnter => _isEnter;
  get id => _id;
  get direction => _direction;
  get type => _type;
  get hasFace => _hasFace;
  get currentPhoto => _currentPhoto;

  set isEnter(bool isEnter) {
    this._isEnter = isEnter;
    _direction = _isEnter ? "Enter" : "Exit";
  }

  set type(String type) {
    this._type = type;
  }

  set currentPhoto(File file) {
    this._currentPhoto = new File(file.path);
  }

  // set id(String id) => this._id = id;
  set hasFace(bool hasFace) => this._hasFace = hasFace;
}
