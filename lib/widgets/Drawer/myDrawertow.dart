// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:medzonedelivery/classes/DeliveryMan.dart';
import 'package:medzonedelivery/core/utils/color_constant.dart';
import 'package:medzonedelivery/pages/Auth/presentation/Login.dart';

class myDrawertow extends StatelessWidget {
  const myDrawertow({
    Key? key,
    required this.deliveryMan,
  }) : super(key: key);

  final DeliveryMan deliveryMan;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            Container(
              color: ColorConstant.medzonebackground,
              child: DrawerHeader(
                child: Column(
                  children: [
                    Container(
                      color: ColorConstant.medzonebackground,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: ColorConstant.whiteA700,
                              child: Icon(Icons.person,
                                  color: ColorConstant.medzonebackground),
                              //Text
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "MedZone",
                          ),
                          const Text(
                            "info@medzonesyria.com",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
                thickness: .06,
                color: ColorConstant.medzonebackground,
                height: 0.3),
            ListTile(
              iconColor: ColorConstant.medzonebackground,
              leading: const Icon(Icons.person),
              title: Text(
                deliveryMan.name.toString(),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: ColorConstant.medzonebackground,
              leading: const Icon(Icons.phone),
              title: Text(
                deliveryMan.mobile.toString(),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              iconColor: ColorConstant.medzonebackground,
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                'خروج',
              ),
              onTap: () {
                Get.to(() => Login());
              },
            ),
          ],
        ));
  }
}
