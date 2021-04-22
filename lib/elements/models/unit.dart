// Данные карточки полученные от сервера

import 'package:check_drivers/elements/models/status.dart';

class CardUnit {
  final String id;
  final String name;
  final String type;
  final String passDate;
  final String passTime;
  final String currentDate;
  final String currentTime;
  final String image;
  final Status status;

  CardUnit(this.id, this.name, this.passDate, this.passTime, this.image,
      this.currentDate, this.currentTime, this.status, this.type);

  CardUnit.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        type = json["object-type"],
        passTime = json["pass-time"],
        passDate = json["pass-date"],
        currentTime = json["event-time"],
        currentDate = json["event-date"],
        image = json["current-photo"],
        status = Status.fromJson(json["status"]);
}
