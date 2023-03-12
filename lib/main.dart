import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medzonedelivery/classes/DeliveryMan.dart';
import 'package:medzonedelivery/pages/Auth/presentation/Login.dart';
import 'package:medzonedelivery/pages/Auth/presentation/login2.dart';
import 'package:medzonedelivery/pages/orderlist_screen/orderlistpage.dart';
import 'package:medzonedelivery/widgets/custom_image_view.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'core/utils/color_constant.dart';
import 'core/utils/image_constant.dart';
import 'core/utils/size_utils.dart';
import 'pages/Auth/presentation/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'MedZone Delevary',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? identifier;
  String _identifier = 'Unknown';

  @override
  void initState() {
    super.initState;
    initUniqueIdentifierState();
    print("in the meddle");
    startSplashScreenTimer();
  } // initUniqueIdentifierState();

  // print("in the meddle");
  // startSplashScreenTimer();
  startSplashScreenTimer() async {
    // Because we using Timer and it is a Future Object, we used async keyword
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationTologine);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHieght = MediaQuery.of(context).size.height;
    return SafeArea(
      top: false,
      bottom: false,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: ColorConstant.whiteA700,
            body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/images/pattern.png"),
    fit: BoxFit.cover,
    ),
    ),


              width: screenWidth,
              height: screenHieght,
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 5 / 4,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenWidth,
                        height: screenHieght * 0.3,
                        child: FittedBox(
                          child: CustomImageView(
                              imagePath: ImageConstant.medzone,
                              fit: BoxFit.fill,
                              margin: getMargin(top: 40)),
                        ),
                      ),
                      CircularProgressIndicator(
                        color: ColorConstant.medzonebackground,
                        backgroundColor: Colors.white70,
                      ),
                    ]),
              ),
            )),
      ),
    );
  }

  Future<void> initUniqueIdentifierState() async {
    try {
      identifier = await UniqueIdentifier.serial;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      _identifier = identifier!;
    });
  }

  void navigationTologine() {
    //  DeliveryMan man = new DeliveryMan();
    // man.id = 2;
    // Get.to(() => OrderList(
    //    deliveryMan: man,
    //  ));

    //TabScreen
    // Get.to(() => TabScreen());
    Get.to(() => LogInMaster());
  }
}
