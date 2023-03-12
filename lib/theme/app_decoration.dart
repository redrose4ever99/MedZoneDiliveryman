import 'package:flutter/material.dart';
import 'package:medzonedelivery/core/app_export.dart';

class AppDecoration {
  static BoxDecoration get outlineBluegray501 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.blueGray50,
          width: getHorizontalSize(
            1.00,
          ),
        ),
      );
  static BoxDecoration get fillMedzonebackground => BoxDecoration(
        color: ColorConstant.medzonebackground,
      );
  static BoxDecoration get fillWhiteA700 => BoxDecoration(
        color: ColorConstant.whiteA700,
      );
  static BoxDecoration get outlineBluegray50 => BoxDecoration(
        color: ColorConstant.whiteA700,
        border: Border.all(
          color: ColorConstant.blueGray50,
          width: getHorizontalSize(
            1.00,
          ),
        ),
      );
  static BoxDecoration get fillBluegray50 => BoxDecoration(
        color: ColorConstant.blueGray50,
      );
}

class BorderRadiusStyle {
  static BorderRadius roundedBorder8 = BorderRadius.circular(
    getHorizontalSize(
      8.00,
    ),
  );

  static BorderRadius roundedBorder11 = BorderRadius.circular(
    getHorizontalSize(
      11.00,
    ),
  );
}
