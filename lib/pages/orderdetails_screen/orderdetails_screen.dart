import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:medzonedelivery/classes/DeliveryMan.dart';
import 'package:medzonedelivery/classes/DioConnection.dart';
import 'package:medzonedelivery/classes/Order.dart';
import 'package:flutter/material.dart';
import 'package:medzonedelivery/core/app_export.dart';
import 'package:medzonedelivery/pages/orderlist_screen/orderlistpage.dart';
import 'package:medzonedelivery/widgets/Drawer/myDrawer.dart';
import 'package:medzonedelivery/widgets/app_bar/appbar_image.dart';
import 'package:medzonedelivery/widgets/app_bar/custom_app_bar.dart';
import 'package:medzonedelivery/widgets/custom_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderdetailsScreen extends StatelessWidget {
  const OrderdetailsScreen(
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
        bottom: false,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            appBar: CustomAppBar(
                backgroundColor: ColorConstant.whiteA700,
                height: screenHieght * 0.5,
                leadingWidth: 45,
                leading: Container(
                  height: getSize(24.00),
                  width: getSize(24.00),
                  padding: getPadding(
                    all: 2,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: AppbarImage(
                        height: getSize(24.00),
                        width: getSize(24.00),
                        svgPath: ImageConstant.imgArrowdownGray700,
                        margin: getMargin(right: 21, top: 23, bottom: 16),
                        onTap: () => onTapArrowdown(context)),
                  ),
                ),
                centerTitle: true,
                title: Scrollbar(
                  child: SingleChildScrollView(
                    child: Container(
                      margin: getMargin(
                        all: 5,
                      ),
                      padding: getPadding(top: 2),
                      child: Column(children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text("تفاصيل الطلب",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.right,
                              style: AppStyle.txtInterSemiBold16),
                        ),
                        const SizedBox(
                          height: 10, // <-- SEE HERE
                        ),
                        Wrap(
                          children: [
                            Text(order.customer_full_name.toString(),
                                style: AppStyle.txtInterSemiBold16),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(order.status.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHieght * 0.0015,
                        ),
                        TextField(
                            decoration: InputDecoration.collapsed(
                              hintText:
                                  " المركز:   ${order.customer_business_name}",
                              hintStyle: AppStyle.txtInterSemi2Bold,
                            ),
                            cursorColor: ColorConstant.whiteA700,
                            minLines: 1, // <-- SEE HERE
                            maxLines: 5,
                            style: AppStyle.txtInterSemi2Bold // <-- SEE HERE
                            ),
                        Row(
                          children: [
                            SizedBox(
                              width: width / 2,
                              child: Row(
                                children: [
                                  Text("موبايل: ",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: AppStyle.txtInterSemiBold),
                                  Text(order.customer_mobile ?? "غير مدخل",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: AppStyle.txtInterSemiBold),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text("أرضي: ",
                                    style: AppStyle.txtInterSemiBold),
                                Text(order.customer_land_phone ?? "غير مدخل",
                                    style: AppStyle.txtInterSemiBold),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenHieght * 0.0015,
                        ),
                        TextField(
                            decoration: InputDecoration.collapsed(
                                hintText:
                                    " منطقة:   ${order.customer_area}   قطاع:  ${order.customer_sector}"),

                            keyboardType: TextInputType.multiline,
                            cursorColor: ColorConstant.whiteA700,
                            minLines: 1, // <-- SEE HERE
                            maxLines: 5,
                            style: AppStyle.txtInterSemi2Bold // <-- SEE HERE
                            ),
                        TextField(
                          decoration: InputDecoration.collapsed(
                              hintText:
                                  "${order.customer_street}   علام:  ${order.customer_marker}"),
                          keyboardType: TextInputType.multiline,
                          cursorColor: ColorConstant.whiteA700,
                          style: AppStyle.txtInterSemi2Bold,
                          minLines: 1, // <-- SEE HERE
                          maxLines: 5, // <-- SEE HERE
                        ),
                        SizedBox(
                          height: screenHieght * 0.015,
                        ),
                        TextField(
                          decoration: InputDecoration.collapsed(
                            hintText:
                                " تفاصيل العنوان:   ${order.customer_details_address}",
                            hintStyle: AppStyle.txtInterSemi2BoldBrawn,
                          ),
                          keyboardType: TextInputType.multiline,
                          cursorColor: ColorConstant.whiteA700,
                          style: AppStyle.txtInterSemiBold,
                          minLines: 1, // <-- SEE HERE
                          maxLines: 5, // <-- SEE HERE
                        ),
                        SizedBox(
                          height: screenHieght * 0.015,
                        ),
                        TextField(
                          decoration: InputDecoration.collapsed(
                            hintText:
                                " ملاحظة :   ${order.customer_notes ?? "لايوجد .."}",
                            hintStyle: TextStyle(
                                color: ColorConstant.black900,
                                fontWeight: FontWeight.w700),
                          ),
                          keyboardType: TextInputType.multiline,
                          cursorColor: ColorConstant.whiteA700,
                          minLines: 1, // <-- SEE HERE
                          maxLines: 5,

                          onChanged: (text) {}, // <-- SEE HERE
                        ),
                      ]),
                    ),
                  ),
                )),
            body: orderContent(f),
            bottomNavigationBar: Padding(
                padding: getPadding(left: 20, right: 20, bottom: 26),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: getPadding(top: 4, bottom: 4),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("الاجمالي",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: AppStyle.txtInterMediumRed),
                                Padding(
                                    padding: getPadding(top: 1),
                                    child: Text(
                                        f.format(double.parse(
                                                order.total.toString())) +
                                            " ل.س",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.right,
                                        style: AppStyle.txtInterSemiBold18))
                              ])),
                      Visibility(
                          visible: _isShow(),
                          child: CustomButton(
                            height: getHorizontalSize(50),
                            width: getVerticalSize(120),
                            text: "تسليم الطلب",
                            onTap: () =>
                                onTapDeliveryState(context, order.id ?? 0, 1),
                          )),
                    ])),
            drawer: myDrawer(
              deliveryMan: deliveryMan,
            ), //Drawer
          ),
        ));
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(
                                    bottom: 2,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: width / 4,
                                            child: Text(
                                              items[index].offer ?? "",
                                              overflow:
                                              TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style: AppStyle
                                                  .txtInterSemiBold16,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 4,
                                            child: Text(
                                              items[index].amount ?? "",
                                              overflow:
                                              TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style: AppStyle
                                                  .txtInterSemiBold16,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 4,
                                            child: Text(
                                              f.format(double.parse(
                                                  items[index].price)),
                                              overflow:
                                              TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                              style: AppStyle
                                                  .txtInterSemiBold16,
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

  alertErorre(BuildContext context) {
    Fluttertoast.showToast(msg: "حاول مجددا ");
  }
}
