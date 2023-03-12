import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medzonedelivery/classes/DeliveryMan.dart';
import 'package:medzonedelivery/classes/DioConnection.dart';
import 'package:medzonedelivery/core/utils/color_constant.dart';
import 'package:medzonedelivery/core/utils/size_utils.dart';
import 'package:medzonedelivery/pages/orderlist_screen/orderlistpage.dart';

class LogInMaster extends StatefulWidget {
  const LogInMaster({super.key});

  @override
  State<LogInMaster> createState() => _LogInMasterState();
}

class _LogInMasterState extends State<LogInMaster> {
  TextEditingController phoneFormController = TextEditingController();

  TextEditingController codeFormController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHieght = MediaQuery.of(context).size.height;
    bool passwordVisible = false;
    bool _obscureText = true;
    String _password;

    return logContainer(screenHieght, passwordVisible, context);
  }

  SafeArea logContainer(
      double screenHieght, bool passwordVisible, BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: ColorConstant.blue50,
              appBar: AppBar(
                elevation: 15,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(30),
                  ),
                ),
                backgroundColor: ColorConstant.medzonebackground,
                title: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                      fontFamily: 'Inter', fontWeight: FontWeight.w700),
                ),
                systemOverlayStyle: SystemUiOverlayStyle.light,
              ),
              body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/pattern.png"),
                      fit: BoxFit.cover,
                    ),
                  ),

                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: getPadding(top: screenHieght * 0.1),
                        child: Center(
                          child: Container(
                              width: 250,
                              height: 200,
                              /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                              child: Image.asset('assets/images/medzone.png')),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10, bottom: 10),
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 18),
                          controller: phoneFormController,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: ColorConstant.medzonebackground),
                              ),
                              labelText: 'الرقم',
                              labelStyle: TextStyle(
                                  fontSize: 20,
                                  color: ColorConstant.medzonebackground),
                              hintText: "أدخل رقما مثل 0991231234",
                              suffixIcon: IconButton(
                                icon: Icon(Icons.call),
                                onPressed: () {},
                              ),
                              // icon:Icon(Icons.call),
                              hintStyle: TextStyle(fontSize: 18)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10, bottom: 0),
                        //padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextField(
                          controller: codeFormController,
                          style: TextStyle(fontSize: 18),
                          obscureText: false,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: ColorConstant.medzonebackground),
                              ),
                              labelText: 'الرمز',
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(
                                    () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ),
                              alignLabelWithHint: false,
                              filled: true,
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  color: ColorConstant.medzonebackground),
                              hintText: "أدخل الرمز",
                              hintStyle: TextStyle(fontSize: 18)),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                            color: ColorConstant.medzonebackground,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              login(phoneFormController.text,
                                  codeFormController.text, context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorConstant.medzonebackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  //border radius equal to or more than 50% of width
                                )),
                            icon: const Icon(Icons.login),
                            label: const Text('دخول',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w700))),
                      ),
                      SizedBox(
                        height: screenHieght * 0.1,
                      ),
                      Text('مرحبا بك في MedZone',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.indigo900))
                    ],
                  ),
                ),
              ),
            )));
  }

  void login(String mobile, password, BuildContext context) async {
    print(password);
    print(mobile);
    showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: CircularProgressIndicator(
            color: ColorConstant.medzonebackground,
            backgroundColor: Colors.white70,
          ));
        });

    DeliveryMan list = DeliveryMan();
    try {
      list = await DioConnection.new().login(mobile, password);
      print(list.toString());
      if (list.id == null) {
        // ignore: use_build_context_synchronously
        alertFirst(context);
        Navigator.of(context).pop();
        //insert data into ModelClass
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();

        // ignore: use_build_context_synchronously
        onTapOrderList(context, list);

        // show error
      }
    } catch (e) {
      // alertFirst(context);
      Navigator.of(context).pop();
    }
  }

  onTapOrderList(BuildContext context, DeliveryMan man) {
    print(man.id);

    Get.to(() => OrderList(
          deliveryMan: man,
        ));
  }

  alertFirst(BuildContext context) {
    Fluttertoast.showToast(
      msg: "خطأ في البيانات المدخلة",
    );
  }
}
