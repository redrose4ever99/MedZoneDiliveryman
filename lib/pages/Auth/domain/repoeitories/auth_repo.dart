import 'package:flutter/material.dart';

import '../../../../classes/DeliveryMan.dart';

abstract class AuthRepo {
  Future<List<DeliveryMan>> login(@required String mobile, @required String Code);
}
