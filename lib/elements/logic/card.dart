import 'dart:io';

import 'package:check_drivers/elements/models/item.dart';
import 'package:check_drivers/elements/models/list_units.dart';
import 'package:check_drivers/elements/logic/requests.dart';
import 'package:flutter/material.dart';

import '../models/unit.dart';

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

        // Для отображения ссылочного фото
        //   if (_unit.image != null) {

        //   print(_unit.image);
        //   Uint8List _base64;

        //   _base64 = Base64Decoder().convert(_unit.image);

        //   getById(id).referencePhoto = _base64;
        // }
        getById(id).isGotFromAPI = true;
        notifyListeners();
      });
    });
  }

  void get10cardsCheck() {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      Request.get10cards().then((value) {
        if (value == null) return;
        _listUnits = value;
        for (CardUnit x in _listUnits.list) {
          if (!_items.contains(x.id)) {
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
        }

        notifyListeners();
      });
    });
  }

  void getCurrentCardCheck(int id, String idOnServer) {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      if (getById(id).type == "driver") {
        Request.getCurrentDriverCard(idOnServer).then((value) {
          _unit = value;
          getById(id).passDate = _unit.passDate;
          getById(id).passTime = _unit.passTime;
          getById(id).name = _unit.name;
          getById(id).currentTime = _unit.currentTime;
          getById(id).currentDate = _unit.currentDate;
          getById(id).statusResult = _unit.status.statusText;
          getById(id).statusColor = _unit.status.statusColor;
          getById(id).isGotFromAPI = true;
          notifyListeners();
        });
      } else {
        Request.getCurrentCarCard(idOnServer).then((value) {
          _unit = value;
          getById(id).passDate = _unit.passDate;
          getById(id).passTime = _unit.passTime;
          getById(id).currentTime = _unit.currentTime;
          getById(id).currentDate = _unit.currentDate;
          getById(id).statusResult = _unit.status.statusText;
          getById(id).statusColor = _unit.status.statusColor;
          getById(id).isGotFromAPI = true;
          notifyListeners();
        });
      }
    });
  }

  void postCertificateDriverCheck(int id, String certificate, String direction,
      [String photo]) {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      Request.postQRCertificateDriver(certificate, direction)
          .then((value) async {
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
        getById(id).isGotFromAPI = true;
        notifyListeners();
      });
    });
  }

  void postCertificateCarCheck(int id, String certificate, String direction,
      [String photo]) {
    Future.delayed(Duration(milliseconds: 1000)).then((value) {
      Request.postQRCertificateCarNumber(certificate, direction)
          .then((value) async {
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
        getById(id).isGotFromAPI = true;
        notifyListeners();
      });
    });
  }

  CardUnit getUnit() => _unit;

  Item getById(int id) => _items.elementAt(id);

  int getLength() => _items.length;

  void setImageToCard(File file, Item item) {
    item.currentPhoto = file;
    notifyListeners();
  }

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}
