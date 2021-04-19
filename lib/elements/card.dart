import 'dart:io';

import 'package:check_drivers/elements/item.dart';
import 'package:flutter/material.dart';

class CardModel extends ChangeNotifier {
  // Список карточек
  final List<Item> _items = [];
  int _position = 0;

  Item getById(int id) => _items.elementAt(id);

  int getLength() => _items.length;

  void changeItemType(String type) {
    _items.elementAt(0).type = type;
    notifyListeners();
  }

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
