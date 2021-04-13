import 'dart:io';

import 'package:check_drivers/elements/item.dart';
import 'package:flutter/material.dart';

class CardModel extends ChangeNotifier {
  /// Internal, private state of the cart.
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

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Item item) {
    _items.add(item);

    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeLastItem() {
    _items.removeAt(_position);
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
