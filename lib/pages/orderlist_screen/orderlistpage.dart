import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medzonedelivery/classes/DeliveryMan.dart';
import 'package:medzonedelivery/core/app_export.dart';
import 'package:medzonedelivery/pages/Auth/presentation/Login.dart';
import 'package:medzonedelivery/pages/Auth/presentation/login2.dart';
import 'package:medzonedelivery/pages/orderdetails_screen/orderdetails_screen.dart';
import 'package:medzonedelivery/pages/orderdetails_screen/orderdetails_screen2.dart';
import 'package:medzonedelivery/widgets/Drawer/myDrawer.dart';
import 'package:medzonedelivery/widgets/app_bar/appbar_image.dart';
import 'package:intl/intl.dart' as intl;
import '../../classes/DioConnection.dart';
import '../../widgets/custom_button.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key, required this.deliveryMan});
  final DeliveryMan deliveryMan;
  @override
  State<OrderList> createState() => _OrderListState(deliveryMan);
}

class _OrderListState extends State<OrderList> {
  final DeliveryMan man;
  var f = intl.NumberFormat(",###,###,###,###,###", "ar_sy");
  TextEditingController _notDeliverController = TextEditingController();
  _OrderListState(this.man);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
// final Animation animation = AnimatedListState();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHieght = MediaQuery.of(context).size.height;

    return SafeArea(
        top: false,
        bottom: false,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: DefaultTabController(
                length: 2,
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Scaffold(
                        appBar: AppBar(
                            backgroundColor: const Color(0xff13b9a1),
                            elevation: 15,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(30),
                              ),
                            ),
                            bottom: TabBar(
                                labelPadding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * .158),
                                labelColor: ColorConstant.whiteA700,
                                unselectedLabelColor: ColorConstant.black900,
                                isScrollable: true, //<-- Unselected text
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        8), // Creates border
                                    color: ColorConstant.medzonebackground),
                                padding: getPadding(bottom: 10),
                                // ignore: prefer_const_literals_to_create_immutables
                                tabs: [
                                  const Tab(
                                    child: Text(
                                      "قيد الإنجاز",
                                      style: TextStyle(
                                          fontFamily: 'arabi',height:1.7,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  const Tab(
                                    child: Text(
                                      "تعذر الإنجاز",
                                      style: TextStyle(
                                          fontFamily: 'arabi',height:1.7,
                                          fontSize:18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ]),
                            leading: IconButton(
                              icon: const Icon(Icons.navigate_before_sharp),
                              onPressed: () {
                                onTapArrowdown(context);
                              },
                            ),

                            /*    leading: AppbarImage(
                            height: getSize(24.00),
                            width: getSize(24.00),
                            svgPath: ImageConstant.imgArrowdownGray700,
                            margin: getMargin(right: 21, top: 16, bottom: 10),
                            onTap: () => onTapArrowdown(context)),*/
                            centerTitle: true,
                            title: Text(
                              "قائمة الطلبات",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'arabi',height:1.7,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black),
                            )),
                        body: TabBarView(children: [
                          underZone(screenWidth),
                          outerZone(screenWidth),

                        ]))))));
  }


  Padding underZone(double screenWidth) {
    return Padding(
      padding: getPadding(
        right: 5,
        left: 5,
        top: 0,
      ),
      child: Container(
        //for first tab
        height: getHorizontalSize(200),
        color: ColorConstant.blueGray50,

        child: Container(
            child: FutureBuilder(
                future: DioConnection.new().getData(man),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: const Center(
                        child: Text("جاري التحميل ...",
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 30,
                                fontWeight: FontWeight.w700)),
                      ),
                    );
                  } else {
                    var items = snapshot.data;

                    return ListView.builder(
                        itemCount: items == null ? 0 : items.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            // When the user taps the button, show a snackbar.
                              onTap: () {
                                onTapGotoDetails(context, items[index]);
                              },
                              child: Visibility(
                                visible:
                                _isShow(items[index].status.toString()),
                                child: Container( decoration: BoxDecoration(


                                    color: ColorConstant.whiteA700,
                                    border: Border.all(
                                        color: ColorConstant.greenForNew, width: 7),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(10))),
                                  padding: getPadding(all: 5),
                                  margin: getMargin(top: 5, left: 2, right: 2, bottom: 4),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,

                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [


                                      Padding(
                                        padding: getPadding(
                                          right: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

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
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(

                                                        padding: getPadding(
                                                          left: 5,
                                                          right: 5,
                                                          bottom: 2,
                                                        ),
                                                        child: Row(

                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:screenWidth*0.5,


                                                              decoration: BoxDecoration(
                                                                color: ColorConstant.whiteA700,

                                                              ),
                                                              padding: getPadding(all: 5),
                                                              margin: getMargin(top: 5, left: 2, right: 2, bottom: 4),

                                                              child: Padding(
                                                                padding: getPadding(
                                                                  left: 5,
                                                                ),
                                                                child: Text(
                                                                  items[index]
                                                                      .customer_full_name,
                                                                  style: TextStyle(fontSize: 17,color: ColorConstant.black900,fontFamily: 'arabi',height:1.7),
                                                                ), ),
                                                            ),
                                                            SizedBox(width:screenWidth*0.06)
                                                            , Container(
                                                              width:screenWidth*0.27,


                                                              decoration: BoxDecoration(
                                                                  color: ColorConstant.whiteA700,

                                                                  border: Border.all(
                                                                      color: ColorConstant.pinkForNew, width: 3),
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius.circular(30),
                                                                      bottomRight: Radius.circular(10))),
                                                              padding: getPadding(all: 5),
                                                              margin: getMargin(top: 5, left: 2, right: 2, bottom: 4),

                                                              child: Padding(
                                                                padding: getPadding(
                                                                  left: 5,
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    items[index].status.toString(),
                                                                    style: TextStyle(fontSize: 12,height: 1.7, color: ColorConstant.red600,fontFamily: 'arabi'),
                                                                  ),
                                                                ), ),
                                                            ),


                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: getPadding(
                                                          left: 5,
                                                          right: 5,
                                                          bottom: 2,
                                                        ),
                                                        child: Text(
                                                            items[index]
                                                                .code
                                                                .toString(),
                                                            style:TextStyle(fontSize: 18,color:Colors.grey)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: getPadding(
                                                      top: 10,
                                                      bottom: 5,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        CustomImageView(
                                                          svgPath: ImageConstant
                                                              .imgLocation26x28,
                                                          height: getSize(
                                                            15.00,
                                                          ),
                                                          width: getSize(
                                                            15.00,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 3),
                                                        Text(
                                                          // ignore: prefer_interpolation_to_compose_strings
                                                          items[index]
                                                              .customer_area
                                                              .toString() +
                                                              " " +
                                                              items[index]
                                                                  .customer_street
                                                                  .toString(),

                                                          style: TextStyle(
                                                              fontSize: 14,fontFamily: 'arabi',height:1.7),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 2,
                                          right: 8,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgCalendar15x15,color: ColorConstant.medzonebackground,
                                              height: getSize(
                                                20.00,
                                              ),
                                              width: getSize(
                                                20.00,
                                              ),
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              items[index]
                                                  .order_date
                                                  .toString()
                                                  .substring(0, 10),
                                              style: TextStyle(fontSize: 17,color: ColorConstant.black900),
                                            ),
                                            SizedBox(
                                              width: getSize(30),
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 5,
                                                right: 5,
                                              ),
                                              child: Text(
                                                f.format(double.parse(
                                                    items[index].total)),
                                                style: TextStyle(fontSize: 17,color: ColorConstant.orange700),
                                              ),
                                            ),
                                            Container(
                                              height: getSize(
                                                20.00,
                                              ),
                                              width: getSize(
                                                34.00,
                                              ),

                                              child: Align
                                                (alignment: Alignment.topRight
                                                  ,child: Text ('ل.س', style:TextStyle(fontSize: 13,color:Colors.grey  ,fontFamily: 'arabi',height:1.7))),

                                            ),

                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: getPadding(
                                          top: 7,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(

                                              height: screenWidth*0.13,
                                              width:screenWidth*0.4,
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: ElevatedButton(
                                                  child: Text("تم التسليم",style:TextStyle(fontSize: 20,fontWeight: FontWeight.w900)),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: ColorConstant.medzonebackground,
                                                    elevation: 0,
                                                  ),
                                                  onPressed: () {onTapnotDeliveryState(
                                                      context,
                                                      items[index].id,
                                                      1,
                                                      index);},
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: screenWidth*0.13,
                                              width:screenWidth*0.4,
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: ElevatedButton(

                                                  child: Text("تعذر التسليم",
                                                      style:TextStyle(fontSize: 16, fontFamily:'arabi',fontWeight: FontWeight.w900)

                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: ColorConstant.dangerButton,
                                                    elevation: 0,
                                                  ),
                                                  onPressed: () {onTapnotDeliveryState(
                                                      context,
                                                      items[index].id,
                                                      0,
                                                      index);},
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),






                                    ],
                                  ),
                                ),
                              ));
                        });
                  }
                })),
      ),
    );
  }



  Padding outerZone(double screenWidth) {
    return Padding(
      padding: getPadding(
        right: 5,
        left: 5,
        top: 0,
      ),
      child: Container(
        //for first tab
        height: getHorizontalSize(200),
        color: ColorConstant.blueGray50,

        child: Container(
            child: FutureBuilder(
                future: DioConnection.new().getData(man),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: const Center(
                        child: Text("جاري التحميل ...",
                            style: TextStyle(
                            fontFamily:'arabi',
                                fontSize: 30,
                                fontWeight: FontWeight.w700)),
                      ),
                    );
                  } else {
                    var items = snapshot.data;

                    return ListView.builder(
                        itemCount: items == null ? 0 : items.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            // When the user taps the button, show a snackbar.
                              onTap: () {
                                onTapGotoDetails(context, items[index]);
                              },
                              child: Visibility(
                                visible:
                                _isCouldNot(items[index].status.toString()),
                                child: Container( decoration: BoxDecoration(


                                  color: ColorConstant.whiteA700,
                                  border: Border.all(
                                      color: ColorConstant.greenForNew, width: 7),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      bottomRight: Radius.circular(10))),
                            padding: getPadding(all: 5),
                            margin: getMargin(top: 5, left: 2, right: 2, bottom: 4),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,

                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [


                                      Padding(
                                        padding: getPadding(
                                          right: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,

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
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(

                                                          padding: getPadding(
                                                            left: 5,
                                                            right: 5,
                                                            bottom: 2,
                                                          ),
                                                        child: Row(

                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              width:screenWidth*0.5,


                                                              decoration: BoxDecoration(
                                                                  color: ColorConstant.whiteA700,

                                                               ),
                                                              padding: getPadding(all: 5),
                                                              margin: getMargin(top: 5, left: 2, right: 2, bottom: 4),

                                                              child: Padding(
                                                                padding: getPadding(
                                                                  left: 5,
                                                                ),
                                                                child: Text(
                                                                  items[index]
                                                                      .customer_full_name,
                                                                  style: TextStyle(fontSize: 17,color: ColorConstant.black900,fontFamily: 'arabi',height:1.7),
                                                                ), ),
                                                            ),
                                                          SizedBox(width:screenWidth*0.06)
                                                          , Container(
                                                             width:screenWidth*0.27,


                                                             decoration: BoxDecoration(

                                                               color: ColorConstant.whiteA700,

                                                               border: Border.all(
                                                                   color: ColorConstant.pinkForNew, width: 3),
                                                               borderRadius: BorderRadius.only(
                                                                   topLeft: Radius.circular(40),
                                                                   bottomRight: Radius.circular(8))),
                                                             padding: getPadding(all: 5),
                                                             margin: getMargin(top: 5, left: 2, right: 2, bottom: 4),

                                                             child: Padding(
                                                               padding: getPadding(
                                                                 left: 5,
                                                               ),
                                                               child: Text(
                                                                 items[index].status.toString(),
                                                                 style: TextStyle(fontSize: 14,color: ColorConstant.red600,fontFamily: 'arabi',height:1.7),
                                                               ), ),
                                                           ),


                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: getPadding(
                                                          left: 5,
                                                          right: 5,
                                                          bottom: 2,
                                                        ),
                                                        child: Text(
                                                          items[index]
                                                              .code
                                                              .toString(),
                                                         style:TextStyle(fontSize: 16,color:Colors.grey,fontFamily:'arabi')
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: getPadding(
                                                      top: 10,
                                                      bottom: 5,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        CustomImageView(
                                                          svgPath: ImageConstant
                                                              .imgLocation26x28,
                                                          height: getSize(
                                                            15.00,
                                                          ),
                                                          width: getSize(
                                                            15.00,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 3),
                                                        Text(
                                                          // ignore: prefer_interpolation_to_compose_strings
                                                          items[index]
                                                              .customer_area
                                                              .toString() +
                                                              " " +
                                                              items[index]
                                                                  .customer_street
                                                                  .toString(),

                                                          style: TextStyle(
                                                              fontSize: 14,fontFamily: 'arabi',height:1.7),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          top: 2,
                                          right: 8,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            CustomImageView(
                                              svgPath: ImageConstant
                                                  .imgCalendar15x15,color: ColorConstant.medzonebackground,
                                              height: getSize(
                                                20.00,
                                              ),
                                              width: getSize(
                                                20.00,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              items[index]
                                                  .order_date
                                                  .toString()
                                                  .substring(0, 10),
                                              style: TextStyle(fontSize: 16,color: ColorConstant.black900,fontFamily:'arabi',),
                                            ),
                                            SizedBox(
                                              width: getSize(30),
                                            ),
                                            Padding(
                                              padding: getPadding(
                                                left: 5,
                                                right: 5,
                                              ),
                                              child: Text(
                                                f.format(double.parse(
                                                    items[index].total)),
                                                style: TextStyle(fontSize: 16,color: ColorConstant.orange700,fontFamily:'arabi',),
  ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height: getSize(
                                                 24.00,
                                                ),
                                                width: getSize(
                                                  34.00,
                                                ),

                                                decoration: BoxDecoration(

                                                  borderRadius:
                                                  BorderRadius.circular(
                                                    getHorizontalSize(
                                                      3.00,
                                                    ),
                                                  ),
                                                ),
                                                child: Center(child: Text ('ل.س', style:TextStyle(fontSize: 13,color:Colors.grey  ,fontFamily: 'arabi',height:1.7))),

                                              ),
                                            ),

                                          ],
                                        ),
                                      ),


                                      Padding(
                                        padding: getPadding(
                                          top: 7,
                                        ),
                                        child: Container(

                                          height: screenWidth*0.13,
                                          width:screenWidth*0.4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: ElevatedButton(
                                              child: Text("تم التسليم",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w900 ,fontFamily: 'arabi',height:1.7)),
                                              style: ElevatedButton.styleFrom(


                                                /* MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.zero,
                                                      side: BorderSide(color: Colors.red)
                                                  ) ),*/

                                                backgroundColor: ColorConstant.medzonebackground,
                                                elevation: 0,
                                              ),
                                              onPressed: () {onTapnotDeliveryState(
                                                  context,
                                                  items[index].id,
                                                  1,
                                                  index);},
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        });
                  }
                })),
      ),
    );
  }





  void onTapGotoDetails(BuildContext context, item) {
    Get.to(() => OrderdetailsScreen2(order: item, deliveryMan: man));
  }

  onTapDeliveryState(BuildContext context, int id, int status, int i) async {

    bool result = await DioConnection().updateState(id, status, man);

    if (result) {
      // ignore: use_build_context_synchronously
      if (status == 1) alertDelivered(context);
      // ignore: use_build_context_synchronously
      if (status == 0) alerNotDileverd(context);
      setState(() {});
      // key.currentState!.removeItem(context, (context, animation) => null)
    } else {
      // ignore: use_build_context_synchronously
      print('error');
    }
  }
  onTapnotDeliveryState(BuildContext context, int id, int status, int i) async {

    AlertDialog(
      title: Text('TextField in Dialog'),
      content: TextField(
        onChanged: (value) {
        },
        controller: _notDeliverController,
        decoration: InputDecoration(hintText: "Text Field in Dialog"),
      ),
    );


    bool result = await DioConnection().updateState(id, status, man);

    if (result) {
      // ignore: use_build_context_synchronously
      if (status == 1) alertDelivered(context);
      // ignore: use_build_context_synchronously
      if (status == 0) alerNotDileverd(context);
      setState(() {});
      // key.currentState!.removeItem(context, (context, animation) => null)
    } else {
      // ignore: use_build_context_synchronously
      print('error');
    }
  }

  void removeItem(int index, AnimatedRemovedItemBuilder builder, s,
      {Duration duration = const Duration(seconds: 2)}) {
    _listKey.currentState!.removeItem(index, builder, duration: duration);
  }

  alerNotDileverd(BuildContext context) {
    Fluttertoast.showToast(
        msg: 'تمت العملية بنجاح',
        backgroundColor: ColorConstant.medzonebackground);
  }

  alertDelivered(BuildContext context) {
    Fluttertoast.showToast(
        msg: 'تعذر التوصيل', backgroundColor: ColorConstant.medzonebackground);
  }

  onTapArrowdown(BuildContext context) {
    Get.to(() => Login2());
  }

  bool _isShow(String string) {
    bool b = true;
    print(string);
    if ((string == "تم الدفع") | (string == "تعذر التوصيل")) b = false;
    return b;
  }

  bool _isCouldNot(String string) {
    if (string == 'تعذر التوصيل') {
      return true;
    } else {
      return false;
    }
  }

  void resumeOrderChange() {




  }
}
