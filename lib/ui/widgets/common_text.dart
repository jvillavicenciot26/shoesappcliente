import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:shoesappclient/ui/general/brand_color.dart';

class BaseText extends StatelessWidget {
  String text;
  double fontSize;
  Color? color;
  FontWeight? fontWeight;
  double? height;
  int? maxLines;
  TextOverflow? textOverflow;
  TextDecoration? textDecoration;

  BaseText(
      {required this.text,
      required this.fontSize,
      this.color,
      this.fontWeight,
      this.height,
      this.maxLines,
      this.textOverflow,
      this.textDecoration});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? BrandColor.primaryFontColor,
        fontWeight: fontWeight,
        height: height,
        overflow: textOverflow,
        decoration: textDecoration,
      ),
    );
  }
}

class H1 extends StatelessWidget {
  String text;
  Color? color;
  double? height;

  H1({required this.text, this.color, this.height});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 28.0,
      color: color,
      fontWeight: FontWeight.w700,
      height: height,
    );
  }
}

class H2 extends StatelessWidget {
  String text;
  Color? color;
  double? height;
  FontWeight? fontWeight;

  H2({required this.text, this.color, this.height, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 24.0,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w600,
      height: height,
    );
  }
}

class H3 extends StatelessWidget {
  String text;
  Color? color;
  double? height;

  H3({required this.text, this.color, this.height});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 20.0,
      color: color,
      fontWeight: FontWeight.w500,
      height: height,
    );
  }
}

class H4 extends StatelessWidget {
  String text;
  Color? color;
  double? height;
  FontWeight? fontWeight;

  H4({
    required this.text,
    this.color,
    this.height,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 18.0,
      color: color,
      fontWeight: fontWeight ?? FontWeight.w500,
      height: height,
    );
  }
}

class H5 extends StatelessWidget {
  String text;
  Color? color;
  double? height;
  int? maxLines;
  TextOverflow? textOverflow;
  FontWeight? fontWeight;

  H5({
    required this.text,
    this.color,
    this.height,
    this.maxLines,
    this.textOverflow,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 14.0,
      color: color,
      fontWeight: fontWeight,
      height: height,
      maxLines: maxLines,
      textOverflow: textOverflow,
    );
  }
}

class H6 extends StatelessWidget {
  String text;
  Color? color;
  double? height;
  TextDecoration? textDecoration;

  H6({
    required this.text,
    this.color,
    this.height,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontSize: 12.0,
      color: color,
      fontWeight: FontWeight.w500,
      height: height,
      textDecoration: textDecoration,
    );
  }
}
