import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:medzonedelivery/classes/DeliveryMan.dart';
import 'package:medzonedelivery/classes/DioConnection.dart';
import 'package:medzonedelivery/classes/Order.dart';
import 'package:flutter/material.dart';
import 'package:medzonedelivery/core/app_export.dart';
import 'package:medzonedelivery/pages/orderlist_screen/orderlistpage.dart';

import 'package:fluttertoast/fluttertoast.dart';

class OrderdetailsScreen2 extends StatelessWidget {
  const OrderdetailsScreen2(
      {super.key, required this.order, required this.deliveryMan});

  final Order order;
  final DeliveryMan deliveryMan;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHieght = MediaQuery.of(context).size.height;
    var f = intl.NumberFormat(",###,###,###,###,###", "ar_sy");
    return SafeArea(
        top: false,
        //navigate_before_sharp
        bottom: false,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ColorConstant.whiteA700,
                appBar: AppBar(
                  backgroundColor: ColorConstant.medzonebackground,
                  elevation: 15,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.navigate_before_sharp),
                    onPressed: () {
                      onTapArrowdown(context);
                    },
                  ),
                  title: const Text('تفاصيل الطلب',
                      style:
                          TextStyle(fontSize: 18, fontFamily: 'arabi')),
                  // ignore: prefer_const_literals_to_create_immutables
                  actions: [
                    const Icon(Icons.inventory_2_outlined),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(' '))
                  ],
                  //backgroundColor: const Color(0xff13b9a1),
                ),
                body: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    // ignore: prefer_const_constructors
                    Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.whiteA700,
                          border: Border.all(
                              color: ColorConstant.greenForNew, width: 7),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(5))),
                      padding: getPadding(all: 5),
                      margin: getMargin(top: 5, left: 2, right: 2, bottom: 4),
                      // ignore: prefer_const_constructors
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            // ignore: prefer_const_constructors
                            leading: Icon(Icons.person,
                                color: ColorConstant.medzonebackground,
                                size: 30),
                            title: Wrap(
                              children: [
                                Text(
                                  " الدكتور: ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: ColorConstant.black900),
                                ),
                                Text(
                                  order.customer_full_name.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: ColorConstant.black900),
                                ),
                              ],
                            ),
                            subtitle: Wrap(
                              children: [
                                Text(
                                  " المركز:  ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: ColorConstant.black900),
                                ),
                                Text(
                                  order.customer_business_name.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'arabi',
                                      color: ColorConstant.black900),
                                ),
                              ],
                            ),
                            // ignore: prefer_const_constructors
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(order.status.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'arabi',
                                    color: ColorConstant.medzonebackground)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.whiteA700,
                          border: Border.all(
                              color: ColorConstant.yellowForNuwar, width: 8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(5))),

                      margin: getMargin(top: 5, left: 2, right: 2, bottom: 4),
                      padding: getPadding(all: 5),
                      // ignore: prefer_const_constructors
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            // ignore: prefer_const_constructors
                            leading: Icon(
                              Icons.call,
                              color: Colors.blue,
                              size: 30,
                            ),
                            title: Wrap(
                              children: [
                                InkWell(
                                  onTap: () {
                                    callCustomer();
                                  },
                                  child: Text(
                                    order.customer_mobile?? 'لايوجد رقم موبايل',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'arabi',
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(width: 25),
                                Text(
                                  order.customer_land_phone ?? "لايوجد هاتف أرضي",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'arabi',
                                      color: ColorConstant.black900),
                                ),
                              ],
                            ),

                            // ignore: prefer_const_constructors
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.whiteA700,
                          border: Border.all(
                              color: ColorConstant.greenForNew, width: 8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(5))),

                      margin: getMargin(top: 5, left: 2, right: 2, bottom: 4),
                      padding: getPadding(all: 5),
                      // ignore: prefer_const_constructors
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            // ignore: prefer_const_constructors
                            leading: Icon(
                              Icons.ac_unit,
                              color: ColorConstant.orange700,
                              size: 30,
                            ),

                            subtitle: Padding(

                              padding: getPadding(  top:2),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        spacing: 4,
                                        children: [
                                          Text(
                                            " العنوان:   ${order.customer_area}",
                                            style: const TextStyle(
                                                fontFamily: 'arabi',
                                                fontSize: 16, color: Colors.black),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            order.customer_street.toString(),
                                            style: const TextStyle(
                                                fontFamily: 'arabi',

                                                fontSize: 16, color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        spacing: 4,
                                        children: [
                                          Text(
                                            " قطاع:   ${order.customer_sector}",
                                            style: const TextStyle(
                                                fontFamily: 'arabi',
                                                fontSize: 16,   height: 1.7, color: Colors.black),
                                          ),
                                          SizedBox(width: 15),
                                          Text(
                                            order.customer_marker.toString(),
                                            style: const TextStyle(
                                                fontFamily: 'arabi',
                                                fontSize: 16,
                                                height: 1.7,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      spacing: 4,
                                      children: [
                                        CustomImageView(
                                          svgPath: ImageConstant.imgLocation26x28,
                                          color: ColorConstant.orange700,
                                          height: getSize(
                                            18.00,
                                          ),
                                          width: getSize(
                                            18.00,
                                          ),
                                        ),
                                        const SizedBox(width: 1),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            " تفاصيل العنوان: ",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                height: 1.7,
                                                fontFamily: 'arabi',
                                                color: Colors.black),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            order.customer_details_address
                                                .toString(),
                                            style: const TextStyle(
                                                height: 1.7,
                                                fontFamily: 'arabi',
                                                fontSize: 16, color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ignore: prefer_const_constructors
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          border:
                              Border.all(color: ColorConstant.blue50, width: 5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomRight: Radius.circular(5))),

                      margin: getMargin(top: 2, left: 2, right: 2, bottom: 4),
                      // ignore: prefer_const_constructors
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            // ignore: prefer_const_constructors
                            leading: Icon(
                              Icons.note,
                              color: ColorConstant.medzonebackground,
                            ),
                            title: Align(
                              alignment: Alignment.topRight,
                              child: Wrap(
                                children: [
                                  Text(
                                    'ملاحظة :',
                                    style: TextStyle(
                                        fontSize: 16,
                                        height: 1.7,
                                        fontFamily: 'arabi',

                                        color: ColorConstant.black900),
                                  ),
                                  Text(
                                    order.customer_notes.toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        height: 1.7,
                                        fontFamily: 'arabi',
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),

                            // ignore: prefer_const_constructors
                          ),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.teal50,
                          border: Border.all(color: Colors.white60, width: 4),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(5))),

                      margin: getMargin(top: 2, left: 2, right: 2, bottom: 4),
                      // ignore: prefer_const_constructors
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ListTile(
                            // ignore: prefer_const_constructors
                            leading: Icon(
                              Icons.production_quantity_limits,
                              color: ColorConstant.medzonebackground,
                            ),
                            title: Text(
                              'قائمة المواد ',
                              style: TextStyle(
                                  fontSize: 22,
                                  height: 1.7,
                                  color: ColorConstant.black900),
                            ),
                            subtitle: Text(
                              'المنتج',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.black),
                            ),
                            // ignore: prefer_const_constructors
                          ),
                        ],
                      ),
                    ),
                  ]),
                  // simpleCard(),
                ))));
  }

  orderContent(intl.NumberFormat f) {
    return Container(
      color: ColorConstant.whiteA700,
      child: FutureBuilder(
          future: order.getProductList(order),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: Text("جاري التحميل ..."),
              );
            } else {
              var items = snapshot.data;

              return ListView.builder(
                  itemCount: items == null ? 0 : items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: ColorConstant.greenForNew,
                          border: Border.all(color: Colors.white60, width: 4),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      margin: getMargin(top: 2, left: 2, right: 2, bottom: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: getPadding(
                              right: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    bottom: 2,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: width / 4,
                                            child: Text(
                                              items[index].offer ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style:
                                                  AppStyle.txtInterSemiBold16,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 4,
                                            child: Text(
                                              items[index].amount ?? "",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style:
                                                  AppStyle.txtInterSemiBold16,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 4,
                                            child: Text(
                                              f.format(double.parse(
                                                  items[index].price)),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style:
                                                  AppStyle.txtInterSemiBold16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }

  ListTile mylistTile(double screenWidth) {
    return ListTile(
        leading: Image.asset('assets/images/med.png'),
        trailing: Text("34,600"),
        title: Row(
          children: [
            Container(
                width: screenWidth * 0.3,
                padding: EdgeInsets.only(top: 3),
                height: 30,
                decoration: BoxDecoration(color: Colors.greenAccent),
                child: Text(
                  "اسم المنتج",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                )),
            Container(
                width: screenWidth * 0.2,
                padding: EdgeInsets.only(top: 3),
                height: 30,
                decoration: BoxDecoration(color: Colors.tealAccent),
                child: Text(
                  "4",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                )),
          ],
        ));
  }

  alertFirst(BuildContext context) {
    Fluttertoast.showToast(
      msg: "this is first alert",
    );
  }

  bool _isShow() {
    if (order.status.toString() == 'تم الدفع') {
      return false;
    } else {
      return true;
    }
  }

  onTapArrowdown(BuildContext context) {
    Get.to(() => OrderList(
          deliveryMan: deliveryMan,
        ));
  }

  onTapDeliveryState(BuildContext context, int id, int status) async {
    bool result =
        await DioConnection.new().updateState(id, status, deliveryMan) as bool;

    if (result) {
      Fluttertoast.showToast(
          msg: 'تمت العملية بنجاح',
          backgroundColor: ColorConstant.medzonebackground);

      Get.to(() => OrderList(
            deliveryMan: deliveryMan,
          ));
    } else
      Fluttertoast.showToast(
          msg: 'تعذر التسليم',
          backgroundColor: ColorConstant.medzonebackground);
  }

  alertstatus(BuildContext context, status) {
    String stas = '';
    if (status == 1) stas = 'تم التسليم';
    if (status == 0) stas = 'تعذر التسليم';
    Fluttertoast.showToast(msg: " تم تغيير الحالة الى $stas");
  }

  alertErorre(BuildContext context) {
    Fluttertoast.showToast(msg: "حاول مجددا ");
  }

  void callCustomer() {}
}
