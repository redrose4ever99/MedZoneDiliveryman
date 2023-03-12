import 'package:medzonedelivery/pages/Auth/domain/repoeitories/auth_repo.dart';

import 'package:medzonedelivery/classes/DeliveryMan.dart';
import 'package:medzonedelivery/classes/Order.dart';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<List<DeliveryMan>> login(String mobile, String code) async {
    try {
      var response = await Dio().get('https://med.ma5znsyria.com/person',
          queryParameters: <String, dynamic>{
            'mobile': mobile,
            'code': code,
          });
      if (response.statusCode == 200) {
        var data = response.data["data"][0];

        final list = response.data["data"] as List<dynamic>;
        print(response.data["data"][0]);
        return list.map((e) => DeliveryMan.fromJson(e)).toList();
        //insert data into ModelClass
      } else {
        print("faild login");
        return List.empty();
      }
    } catch (e) {
      return List.empty();
    }
  }
}
