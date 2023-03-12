// ignore: duplicate_ignore
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:medzonedelivery/classes/DioConnection.dart';
import 'package:medzonedelivery/classes/DeliveryMan.dart';
import 'package:medzonedelivery/pages/orderlist_screen/orderlistpage.dart';
import 'package:medzonedelivery/widgets/custom_button.dart';
import 'package:medzonedelivery/widgets/custom_text_form_field.dart';
import 'package:medzonedelivery/core/app_export.dart';

// ignore_for_file: must_be_immutable

class Login extends StatelessWidget {
  TextEditingController phoneFormController = TextEditingController();

  TextEditingController codeFormController = TextEditingController();

  Login({super.key});

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
              resizeToAvoidBottomInset: false,
              body: MediaQuery.of(context).orientation == Orientation.portrait
                  ? Stack(children: [
                      Container(
                          width: size.width,
                          padding: getPadding(
                              left: 15, top: 35, right: 15, bottom: 35),
                          child:
                              colomnpage(screenHieght, screenWidth, context)),
                    ])
                  : Container(
                      height: size.height,
                      padding:
                          getPadding(left: 15, top: 15, right: 15, bottom: 15),
                      child:
                          colomnpageLand(screenHieght, screenWidth, context))),
        ));
  }

  Column colomnpage(
      double screenHieght, double screenWidth, BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(height: screenHieght * .1),
      SizedBox(
        width: screenWidth * 0.8,
        height: screenHieght * 0.2,
        child: FittedBox(
          child: CustomImageView(
              imagePath: ImageConstant.medzone,
              fit: BoxFit.fill,
              margin: getMargin(top: 40)),
        ),
      ),
      Padding(
          padding: getPadding(top: 24),
          child: Text(" مرحبا بك في  MedZone",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtPoppinsBold16
                  .copyWith(letterSpacing: getHorizontalSize(0.50)))),
      CustomTextFormField(
          width: 343,
          focusNode: FocusNode(),
          controller: phoneFormController,
          hintText: "أدخل رقما مثل 0991231234",
          margin: getMargin(top: 28),
          textInputType: TextInputType.phone,
          prefix: Container(
              margin: getMargin(left: 16, top: 12, right: 10, bottom: 12),
              child: CustomImageView(svgPath: ImageConstant.imgCall)),
          prefixConstraints: BoxConstraints(maxHeight: getVerticalSize(48.00))),
      CustomTextFormField(
          width: 343,
          controller: codeFormController,
          hintText: "ادخل الرمز",
          margin: getMargin(top: 8),
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
              margin: getMargin(left: 16, top: 12, right: 10, bottom: 12),
              child: CustomImageView(svgPath: ImageConstant.imgLock)),
          prefixConstraints: BoxConstraints(maxHeight: getVerticalSize(48.00)),
          isObscureText: true),
      CustomButton(
        height: 57,
        width: 343,
        text: "دخول",
        margin: getMargin(top: 27),
        fontStyle: ButtonFontStyle.InterSemiBold14Gray700,
        onTap: () {
          print("taped now");
          login(phoneFormController.text, codeFormController.text, context);
        },
      ),
    ]);
  }

  Center colomnpageLand(
      double screenHieght, double screenWidth, BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          width: screenWidth * 0.3,
          height: screenHieght * 0.3,
          child: FittedBox(
            child: CustomImageView(
                imagePath: ImageConstant.medzone,
                fit: BoxFit.fill,
                margin: getMargin(top: 40)),
          ),
        ),
        Padding(
            padding: getPadding(top: 4),
            child: Text(" مرحبا بك في  MedZone",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtPoppinsBold16
                    .copyWith(letterSpacing: getHorizontalSize(0.50)))),
        CustomTextFormField(
            width: 343,
            controller: phoneFormController,
            hintText: "أدخل رقما مثل 0991231234",
            margin: getMargin(top: 5),
            textInputType: TextInputType.phone,
            prefix: Container(
                margin: getMargin(left: 16, top: 12, right: 10, bottom: 12),
                child: CustomImageView(svgPath: ImageConstant.imgCall)),
            prefixConstraints:
                BoxConstraints(maxHeight: getVerticalSize(48.00))),
        CustomTextFormField(
            width: 343,
            controller: codeFormController,
            hintText: "أدخل الرمز",
            margin: getMargin(top: 1),
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            prefix: Container(
                margin: getMargin(left: 16, top: 12, right: 10, bottom: 12),
                child: CustomImageView(svgPath: ImageConstant.imgLock)),
            prefixConstraints:
                BoxConstraints(maxHeight: getVerticalSize(48.00)),
            isObscureText: true),
        CustomButton(
          height: 53,
          width: 350,
          text: "دخول",
          margin: getMargin(top: 5),
          fontStyle: ButtonFontStyle.InterSemiBold14Gray700,
          onTap: () {
            print("taped now");
            login(phoneFormController.text, codeFormController.text, context);
          },
        ),
      ]),
    );
  }

  void login(String mobile, password, BuildContext context) async {
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

  alertFirst(BuildContext context) {
    Fluttertoast.showToast(
      msg: "خطأ في البيانات المدخلة",
    );
  }

  alertEmptyPhone(BuildContext context) {
    Fluttertoast.showToast(
      msg: "رقم الهاتف 10 خانات  ",
    );
  }

  onTapOrderList(BuildContext context, DeliveryMan man) {
    print(man.id);

    Get.to(() => OrderList(
          deliveryMan: man,
        ));
  }

  String? validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }
}
