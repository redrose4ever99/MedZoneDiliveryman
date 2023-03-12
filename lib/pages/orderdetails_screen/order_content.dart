import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:medzonedelivery/classes/DeliveryMan.dart';
import 'package:medzonedelivery/classes/Order.dart';
import 'package:medzonedelivery/core/utils/color_constant.dart';
import 'package:medzonedelivery/core/utils/size_utils.dart';
import 'package:medzonedelivery/theme/app_style.dart';
import 'package:intl/intl.dart' as intl;

class Products extends StatefulWidget {
  const Products({super.key, required this.order, required this.deliveryMan});

  final Order order;
  final DeliveryMan deliveryMan;

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late final Order order;

  @override
  Widget build(BuildContext context) {
    var f = intl.NumberFormat(",###,###,###,###,###", "ar_sy");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Container(
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
      )),
    );
  }
}
