import 'dart:convert';
import 'dart:io';

import 'package:check_drivers/elements/models/item.dart';
import 'package:check_drivers/elements/models/list_units.dart';
import 'package:check_drivers/elements/requests.dart';
import 'package:flutter/material.dart';

import 'models/unit.dart';

class CardModel extends ChangeNotifier {
  // Список карточек
  final List<Item> _items = [];
  ListUnits _listUnits;
  int _position = 0;
  CardUnit _unit;

  void postFaceCarCheck(int id, String type, String direction, [String photo]) {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      Request.postCardInformation(type, direction, photo).then((value) {
        _unit = value;
        getById(id).passDate = _unit.passDate;
        getById(id).passTime = _unit.passTime;
        getById(id).currentTime = _unit.currentTime;
        getById(id).currentDate = _unit.currentDate;
        getById(id).idOnServer = _unit.id;
        getById(id).statusResult = _unit.status.statusText;
        getById(id).statusColor = _unit.status.statusColor;
        getById(id).name = _unit.name;
        getById(id).type = _unit.type;
        // final decodedBytes = base64Decode(_unit.image);
        // var file = File("1.png");
        // file.writeAsBytesSync(decodedBytes);
        // getById(id).currentPhoto = file;
        getById(id).isGotFromAPI = true;
        notifyListeners();
      });
    });
  }

  void get10cardsCheck() {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      Request.get10cards().then((value) {
        _listUnits = value;
        for (CardUnit x in _listUnits.list) {
          _items.add(new Item());
          getById(_items.length - 1).passDate = x.passDate;
          getById(_items.length - 1).passTime = x.passTime;
          getById(_items.length - 1).currentTime = x.currentTime;
          getById(_items.length - 1).currentDate = x.currentDate;
          getById(_items.length - 1).idOnServer = x.id;
          getById(_items.length - 1).statusResult = x.status.statusText;
          getById(_items.length - 1).statusColor = x.status.statusColor;
          getById(_items.length - 1).name = x.name;
          getById(_items.length - 1).type = x.type;
          getById(_items.length - 1).isGotFromAPI = true;
        }

        // final decodedBytes = base64Decode(_unit.image);
        // var file = File("1.png");
        // file.writeAsBytesSync(decodedBytes);
        // getById(id).currentPhoto = file;
        notifyListeners();
      });
    });
  }

  void getCurrentCardCheck(int id, String idOnServer) {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      Request.getCurrentCard(idOnServer).then((value) {
        _unit = value;
        getById(id).passDate = _unit.passDate;
        getById(id).passTime = _unit.passTime;
        getById(id).currentTime = _unit.currentTime;
        getById(id).currentDate = _unit.currentDate;
        getById(id).idOnServer = _unit.id;
        getById(id).statusResult = _unit.status.statusText;
        getById(id).statusColor = _unit.status.statusColor;
        getById(id).name = _unit.name;
        getById(id).type = _unit.type;
        // final decodedBytes = base64Decode(_unit.image);
        // var file = File("1.png");
        // file.writeAsBytesSync(decodedBytes);
        // getById(id).currentPhoto = file;
        getById(id).isGotFromAPI = true;
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

  // void changeState() {
  //   Future.delayed(Duration(milliseconds: 1000)).then((value) {
  //     getCardInformation().then((value) {
  //       _unit = value;
  //       _canChange = true;
  //       notifyListeners();
  //     });
  //   });
  // }

  void setImageToCard(File file, Item item) {
    item.currentPhoto = file;
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
