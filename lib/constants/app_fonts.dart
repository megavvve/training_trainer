import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyles {
  static TextStyle get h1 => GoogleFonts.inter(
    fontSize: 24.sp, 
    fontWeight: FontWeight.w700,
    height: 1.29,
  );

  static TextStyle get h2 => GoogleFonts.inter(
    fontSize: 20.sp, 
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static TextStyle get h3 => GoogleFonts.inter(
    fontSize: 16.sp, 
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static TextStyle get text => GoogleFonts.inter(
    fontSize: 14.sp, 
    fontWeight: FontWeight.w400,
    height: 1.43,
  );

  static TextStyle get textMed => GoogleFonts.inter(
    fontSize: 14.sp, 
    fontWeight: FontWeight.w500,
    height: 1.43,
  );

  static TextStyle get textBold => GoogleFonts.inter(
    fontSize: 14.sp, 
    fontWeight: FontWeight.w700,
    height: 1.43,
  );

  static TextStyle get textSmall => GoogleFonts.inter(
    fontSize: 12.sp, 
    fontWeight: FontWeight.w400,
    height: 1.42,
  );

  static TextStyle get textSmallMed => GoogleFonts.inter(
    fontSize: 12.sp, 
    fontWeight: FontWeight.w500,
    height: 1.42,
  );

  static TextStyle get textSmallBold => GoogleFonts.inter(
    fontSize: 12.sp, 
    fontWeight: FontWeight.w700,
    height: 1.42,
  );

  static TextStyle get desk => GoogleFonts.inter(
    fontSize: 10.sp, 
    fontWeight: FontWeight.w400,
    height: 1.4,
  );

  static TextStyle get deskMed => GoogleFonts.inter(
    fontSize: 10.sp, 
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static TextStyle get deskBold => GoogleFonts.inter(
    fontSize: 10.sp, 
    fontWeight: FontWeight.w700,
    height: 1.4,
  );
}
