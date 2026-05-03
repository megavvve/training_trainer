import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyles {
  static TextStyle get h1 => TextStyle(
    fontSize: 24.sp, 
    fontWeight: FontWeight.w700,
    height: 1.29,
  );

  static TextStyle get h2 => TextStyle(
    fontSize: 20.sp, 
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static TextStyle get h3 => TextStyle(
    fontSize: 16.sp, 
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static TextStyle get text => TextStyle(
    fontSize: 14.sp, 
    fontWeight: FontWeight.w400,
    height: 1.43,
  );

  static TextStyle get textMed => TextStyle(
    fontSize: 14.sp, 
    fontWeight: FontWeight.w500,
    height: 1.43,
  );

  static TextStyle get textBold => TextStyle(
    fontSize: 14.sp, 
    fontWeight: FontWeight.w700,
    height: 1.43,
  );

  static TextStyle get textSmall => TextStyle(
    fontSize: 12.sp, 
    fontWeight: FontWeight.w400,
    height: 1.42,
  );

  static TextStyle get textSmallMed => TextStyle(
    fontSize: 12.sp, 
    fontWeight: FontWeight.w500,
    height: 1.42,
  );

  static TextStyle get textSmallBold => TextStyle(
    fontSize: 12.sp, 
    fontWeight: FontWeight.w700,
    height: 1.42,
  );

  static TextStyle get desk => TextStyle(
    fontSize: 10.sp, 
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static TextStyle get deskMed => TextStyle(
    fontSize: 10.sp, 
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static TextStyle get deskBold => TextStyle(
    fontSize: 10.sp, 
    fontWeight: FontWeight.w700,
    height: 1.4,
  );
}
