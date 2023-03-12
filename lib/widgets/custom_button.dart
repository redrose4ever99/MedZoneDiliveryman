// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medzonedelivery/core/app_export.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/size_utils.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {super.key,
      this.shape,
      this.padding,
      this.variant,
      this.fontStyle,
      this.alignment,
      this.margin,
      this.onTap,
      this.width,
      this.height,
      this.text,
      this.prefixWidget,
      this.suffixWidget});

  ButtonShape? shape;

  ButtonPadding? padding;

  ButtonVariant? variant;

  ButtonFontStyle? fontStyle;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  VoidCallback? onTap;

  double? width;

  double? height;

  String? text;

  Widget? prefixWidget;

  Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment!,
            child: _buildButtonWidget(),
          )
        : _buildButtonWidget();
  }

  _buildButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: ElevatedButton(
        onPressed: onTap,
        style: _buildTextButtonStyle(),
        child: _buildButtonWithOrWithoutIcon(),
      ),
    );
  }

  _buildButtonWithOrWithoutIcon() {
    if (prefixWidget != null || suffixWidget != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          prefixWidget ?? SizedBox(),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: _setFontStyle(),
          ),
          suffixWidget ?? SizedBox(),
        ],
      );
    } else {
      return Text(
        text ?? "",
        textAlign: TextAlign.center,
        style: _setFontStyle(),
      );
    }
  }

  _buildTextButtonStyle() {
    return TextButton.styleFrom(
      fixedSize: Size(
        getHorizontalSize(width ?? 0),
        getVerticalSize(height ?? 0),
      ),
      padding: _setPadding(),
      backgroundColor: _setColor(),
      side: _setTextButtonBorder(),
      shape: RoundedRectangleBorder(
        borderRadius: _setBorderRadius(),
      ),
    );
  }

  _setPadding() {
    switch (padding) {
      case ButtonPadding.PaddingAll6:
        return getPadding(
          all: 6,
        );
      default:
        return getPadding(
          all: 15,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case ButtonVariant.FillWhiteA700:
        return ColorConstant.whiteA700;
      case ButtonVariant.FillBluegray50:
        return ColorConstant.blueGray50;
      case ButtonVariant.OutlineWhiteA700:
        return null;
      default:
        return ColorConstant.medzonebackground;
    }
  }

  _setTextButtonBorder() {
    switch (variant) {
      case ButtonVariant.OutlineWhiteA700:
        return BorderSide(
          color: ColorConstant.whiteA700,
          width: getHorizontalSize(
            2.00,
          ),
        );
      default:
        return null;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case ButtonShape.Square:
        return BorderRadius.circular(0);
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        );
    }
  }

  _setFontStyle() {
    switch (fontStyle) {
      case ButtonFontStyle.InterSemiBold14Teal300:
        return TextStyle(
          color: ColorConstant.teal300,
          fontSize: getFontSize(
            18,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.InterSemiBold12:
        return TextStyle(
          color: ColorConstant.whiteA700,
          backgroundColor: ColorConstant.medzonebackground,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );
      case ButtonFontStyle.InterSemiBold14Gray700:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            15,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );
      default:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        );
    }
  }
}

enum ButtonShape {
  Square,
  RoundedBorder8,
}

enum ButtonPadding {
  // ignore: constant_identifier_names
  PaddingAll15,
  // ignore: constant_identifier_names
  PaddingAll6,
}

enum ButtonVariant {
  // ignore: constant_identifier_names
  FillCyan300,
  // ignore: constant_identifier_names
  OutlineWhiteA700,
  // ignore: constant_identifier_names
  FillWhiteA700,
  // ignore: constant_identifier_names
  FillBluegray50,
}

enum ButtonFontStyle {
  InterSemiBold14,
  InterSemiBold14Teal300,
  InterSemiBold12,
  InterSemiBold14Gray700,
}
