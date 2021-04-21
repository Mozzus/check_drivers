import 'dart:convert';
import 'dart:io';

import 'package:check_drivers/elements/models/item.dart';
import 'package:check_drivers/elements/models/list_units.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'models/status.dart';
import 'models/unit.dart';

class CardModel extends ChangeNotifier {
  // Список карточек
  final List<Item> _items = [];
  ListUnits _listUnits;
  int _position = 0;
  bool _isChange = false;
  CardUnit _unit;

  // static final String url =
  //     'https://my-json-server.typicode.com/mozzus/demo/card/';

  static final String url = 'http://caf2e148cf38.ngrok.io/api/v1/photos/check';
  static final String urlGet10 =
      'http://caf2e148cf38.ngrok.io/api/v1/events?limit=10&offset=0';

  // get currentPhoto => null;

  Future<CardUnit> postCardInformation(String type, String direction,
      [String photo]) async {
    // var formData = FormData.fromMap(
    //     {"photo": photo, "object-type": type, "direction-type": direction});
    try {
      var dio = Dio(BaseOptions(contentType: Headers.jsonContentType));
      // dio.options.headers['Content-Type'] = "application/json";
      // dio.options.headers['accept'] = "application/json";
      Response response = await dio.post(url, data: {
        "photo": photo,
        "object-type": type,
        "direction-type": direction
      });
      print(response.data);
      return CardUnit.fromJson(response.data);
    } on DioError catch (e) {
      print(e.response);
    }
  }

  void postFaceCarCheck(int id, String type, String direction, [String photo]) {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      postCardInformation(type, direction, photo).then((value) {
        _unit = value;
        getById(id).passDate = _unit.passDate;
        getById(id).passTime = _unit.passTime;
        getById(id).currentTime = _unit.currentTime;
        getById(id).currentDate = _unit.currentDate;
        getById(id).idOnServer = _unit.id;
        getById(id).statusResult = _unit.status.statusColor;
        getById(id).name = _unit.name;
        // final decodedBytes = base64Decode(_unit.image);
        // var file = File("1.png");
        // file.writeAsBytesSync(decodedBytes);
        // getById(id).currentPhoto = file;
        _isChange = true;
        notifyListeners();
      });
    });
  }

  Future<ListUnits> get10cards() async {
    try {
      var dio = Dio();
      Response response = await dio.get(urlGet10);
      print(response.data);
      return ListUnits.fromJson(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }

  void get10cardsCheck() {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      get10cards().then((value) {
        _listUnits = value;
        for (CardUnit x in _listUnits.list) {
          _items.add(new Item());
          getById(_items.length - 1).passDate = x.passDate;
          getById(_items.length - 1).passTime = x.passTime;
          getById(_items.length - 1).currentTime = x.currentTime;
          getById(_items.length - 1).currentDate = x.currentDate;
          getById(_items.length - 1).idOnServer = x.id;
          getById(_items.length - 1).statusResult = x.status.statusColor;
          getById(_items.length - 1).name = x.name;
        }

        // final decodedBytes = base64Decode(_unit.image);
        // var file = File("1.png");
        // file.writeAsBytesSync(decodedBytes);
        // getById(id).currentPhoto = file;
        _isChange = true;
        notifyListeners();
      });
    });
  }

  // Future<CardUnit> postCertificate(String certificate, String direction) async {
  //   var formData = FormData.fromMap(
  //       {"certificate": certificate, "direction-type": direction});
  //   try {
  //     var dio = Dio();
  //     Response response = await dio.get(url);
  //     print(response.data);
  //     return CardUnit.fromJson(response.data[0]);
  //   } on DioError catch (e) {
  //     print(e);
  //   }
  // }

  // void postCertificateCheck(int id, String certificate, String direction) {
  //   Future.delayed(Duration(milliseconds: 1000)).then((value) {
  //     postCertificate(certificate, direction).then((value) {
  //       _unit = value;
  //       getById(id).passDate = _unit.passDate;
  //       getById(id).passTime = _unit.passTime;
  //       getById(id).name = _unit.name;
  //       getById(id).idOnServer = _unit.id;
  //       // final decodedBytes = base64Decode(_unit.image);
  //       // var file = File("1.png");
  //       // file.writeAsBytesSync(decodedBytes);
  //       // getById(id).currentPhoto = file;
  //       _isChange = true;
  //       notifyListeners();
  //     });
  //   });
  // }

  // Future<CardUnit> getCardInformation() async {
  //   try {
  //     var dio = Dio();
  //     Response response = await dio.get(url);
  //     print(response.data);
  //     return CardUnit.fromJson(response.data[0]);
  //   } on DioError catch (e) {
  //     print(e);
  //   }
  // }

  CardUnit getUnit() => _unit;

  Item getById(int id) => _items.elementAt(id);

  int getLength() => _items.length;

  bool getState() => _isChange;

  // void changeState() {
  //   Future.delayed(Duration(milliseconds: 1000)).then((value) {
  //     getCardInformation().then((value) {
  //       _unit = value;
  //       _canChange = true;
  //       notifyListeners();
  //     });
  //   });
  // }

  void setImageToCard(File file) {
    _items.elementAt(_position).currentPhoto = file;
    ++_position;
    notifyListeners();
  }

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeLastItem() {
    _items.removeAt(_position);
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
