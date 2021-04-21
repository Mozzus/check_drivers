import 'package:check_drivers/elements/models/unit.dart';

class ListUnits {
  final List<CardUnit> list;

  ListUnits(this.list);
  ListUnits.fromJson(Map<String, dynamic> json)
      : list = (json["items"] as List)
            .map((i) => new CardUnit.fromJson(i))
            .toList();
}
