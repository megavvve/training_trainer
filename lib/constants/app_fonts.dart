import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Unified typography system using Google Fonts Inter.
/// Mirrors the uikit.md reference from the design system.
abstract class TextStyles {
  /// Heading 1 — 21pt / bold
  static TextStyle get h1 =>
      GoogleFonts.inter(fontSize: 21, fontWeight: FontWeight.w700, height: 1.4);

  /// Heading 2 — 18pt / bold
  static TextStyle get h2 =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, height: 1.4);

  /// Heading 3 — 16pt / semibold
  static TextStyle get h3 =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, height: 1.4);

  /// Heading 4 — 14pt / semibold
  static TextStyle get h4 =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4);

  /// Body text — 14pt / regular
  static TextStyle get text => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.42,
  );

  /// Body text semibold — 14pt / semibold
  static TextStyle get textSemi =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, height: 1.6);

  /// Body text regular — 14pt / regular (same line height as semi)
  static TextStyle get textReg =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, height: 1.6);

  /// Small text regular — 12pt / regular
  static TextStyle get textSReg =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, height: 1.6);

  /// Small text — 12pt / regular
  static TextStyle get textSmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.42,
  );

  /// Small text bold — 12pt / bold
  static TextStyle get textSBold =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, height: 1.6);

  /// Small text semibold — 12pt / semibold
  static TextStyle get textSSemi =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, height: 1.6);

  /// Desk semibold — 10pt / semibold
  static TextStyle get deskSemi =>
      GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, height: 1.4);

  /// Desk medium — 10pt / medium
  static TextStyle get deskMed =>
      GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, height: 1.4);
}
