// ignore: file_names
// ignore: file_names
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:medzonedelivery/classes/HomeItems.dart';
import 'DeliveryMan.dart';

import 'Order.dart';

class DioConnection {
  Future<List<Order>> getData(DeliveryMan man) async {
    var response = await Dio().get('http://med.ma5znsyria.com/personOrders',
        queryParameters: <String, dynamic>{'id': man.id});

    // ignore: avoid_print
    print(response.statusCode);
    if (response.statusCode == 200) {
      final list = response.data["data"] as List<dynamic>;

      return list.map((e) => Order.fromJson(e)).toList();
    } else {
      return List.empty();
    }
  }

  Future<DeliveryMan> login(String mobile, code) async {
    DeliveryMan x = DeliveryMan();
    try {
      var response = await Dio().get('https://med.ma5znsyria.com/person',
          queryParameters: <String, dynamic>{
            'mobile': mobile,
            'code': code,
            'device_id': 0
          });
      if (response.statusCode == 200) {
        var data = response.data["data"];

        DeliveryMan x = DeliveryMan();
        x = DeliveryMan.fromJson(data);

        return x;
        //insert data into ModelClass
      } else {
        return x;
      }
    } catch (e) {
      return x;
    }
  }

  Future<bool> updateState(int id, int status, DeliveryMan man) async {
    try {
      var response = await Dio().get('http://med.ma5znsyria.com/editOrder',
          queryParameters: <String, dynamic>{
            'id': id,
            'status': status,
          });
      if (response.statusCode == 200) {
        //insert data into ModelClass
        return true;
      } else {
        // show error

        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<List<HomeItems>> ReadTestJsonData() async {
    final jsondata = await rootBundle.loadString('lib/jsonfile/orders.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => HomeItems.fromJson(e)).toList();
  }
}
