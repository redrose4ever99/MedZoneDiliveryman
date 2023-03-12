// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:medzonedelivery/core/app_export.dart';

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {this.shape,
      this.padding,
      this.variant,
      this.alignment,
      this.margin,
      this.width,
      this.height,
      this.child,
      this.onTap});

  IconButtonShape? shape;

  IconButtonPadding? padding;

  IconButtonVariant? variant;

  Alignment? alignment;

  EdgeInsetsGeometry? margin;

  double? width;

  double? height;

  Widget? child;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildIconButtonWidget(),
          )
        : _buildIconButtonWidget();
  }

  _buildIconButtonWidget() {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: IconButton(
        iconSize: getSize(height ?? 0),
        padding: EdgeInsets.all(0),
        icon: Container(
          alignment: Alignment.center,
          width: getSize(width ?? 0),
          height: getSize(height ?? 0),
          padding: _setPadding(),
          decoration: _buildDecoration(),
          child: child,
        ),
        onPressed: onTap,
      ),
    );
  }

  _buildDecoration() {
    return BoxDecoration(
      color: _setColor(),
      borderRadius: _setBorderRadius(),
    );
  }

  _setPadding() {
    switch (padding) {
      case IconButtonPadding.PaddingAll14:
        return getPadding(
          all: 13,
        );
      default:
        return getPadding(
          all: 9,
        );
    }
  }

  _setColor() {
    switch (variant) {
      case IconButtonVariant.FillCyan300:
        return ColorConstant.cyan300;
      default:
        return ColorConstant.blueGray50;
    }
  }

  _setBorderRadius() {
    switch (shape) {
      case IconButtonShape.RoundedBorder15:
        return BorderRadius.circular(
          getHorizontalSize(
            15.00,
          ),
        );
      case IconButtonShape.RoundedBorder8:
        return BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        );
      case IconButtonShape.CircleBorder18:
        return BorderRadius.circular(
          getHorizontalSize(
            18.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            21.00,
          ),
        );
    }
  }
}

enum IconButtonShape {
  RoundedBorder21,
  RoundedBorder15,
  RoundedBorder8,
  CircleBorder18,
}

enum IconButtonPadding {
  PaddingAll9,
  PaddingAll14,
}

enum IconButtonVariant {
  FillBluegray50,
  FillCyan300,
}
