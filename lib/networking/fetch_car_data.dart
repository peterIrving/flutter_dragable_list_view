import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_example/models/car_json.dart';
import 'package:flutter_ui_example/models/car_model.dart';

class FetchCarDataAPI {
  Future<Car> fetchCar() async {
    try {

      await Future.delayed(Duration(seconds: 2));

      final jsonResult = json.decode(carJson);
      Car car = Car.fromJson(jsonResult);
      return car;

    } catch (e) {
      print("error 'fetching' data ${e.toString()}");
    }
  }
}
