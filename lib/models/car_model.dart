import 'dart:math';

import 'package:flutter_ui_example/utils/date_formatter.dart';
import 'package:intl/intl.dart';

class Car {
  String id;
  String name;
  String propertyName;
  List<Visit> visits;

  Car(this.id, this.name, this.propertyName, this.visits);

  Car.fromJson(Map<String, dynamic> json) {
    print("Car.fromJson");
    id = json["id"];
    name = json["name"];
    propertyName = json["propertyName"];
    print("before parsing visits");
    print(json);
    visits =
        (json["virtualVisits"] as List).map((i) => Visit.fromJson(i)).toList();
  }
}

class Visit {
  String id;
  String date;
  String time;
  DateTime timestamp;
  int healthPercentage;
  bool healthTrend;

  Visit(this.id, this.date, this.time);

  String get getDate {
    return date;
  }

  String get getTime {
    return time;
  }

  DateTime get getTimeStamp{
    return timestamp;
  }

  Visit.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    date = DateFormatter.getDateFromString(json["createdAt"]);
    time = DateFormatter.getTimeFromString(json["createdAt"]);
    timestamp = DateTime.parse(json["createdAt"]);
    healthPercentage = Random().nextInt(100);
    healthTrend = Random().nextBool();
  }

}
