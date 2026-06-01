import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Unified typography system using Google Fonts Inter.
/// Redesigned scale: 24/20/18/16 body, 14 small, 12 caption.
abstract class TextStyles {
  /// Display — 24pt / bold (for hero sections)
  static TextStyle get display =>
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, height: 1.3);

  /// Heading 1 — 20pt / bold
  static TextStyle get h1 =>
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700, height: 1.3);

  /// Heading 2 — 18pt / semibold
  static TextStyle get h2 =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, height: 1.35);

  /// Heading 3 — 16pt / semibold
  static TextStyle get h3 =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, height: 1.4);

  /// Heading 4 — 14pt / semibold
  static TextStyle get h4 =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4);

  /// Body text — 15pt / regular
  static TextStyle get text =>
      GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400, height: 1.5);

  /// Body text semibold — 15pt / semibold
  static TextStyle get textSemi =>
      GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, height: 1.5);

  /// Body text regular — 15pt / regular (same as text)
  static TextStyle get textReg =>
      GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400, height: 1.6);

  /// Small text regular — 13pt / regular
  static TextStyle get textSReg =>
      GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, height: 1.5);

  /// Small text — 13pt / regular
  static TextStyle get textSmall =>
      GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, height: 1.45);

  /// Small text bold — 13pt / bold
  static TextStyle get textSBold =>
      GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, height: 1.5);

  /// Small text semibold — 13pt / semibold
  static TextStyle get textSSemi =>
      GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, height: 1.5);

  /// Caption semibold — 11pt / semibold
  static TextStyle get deskSemi =>
      GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, height: 1.4);

  /// Caption medium — 11pt / medium
  static TextStyle get deskMed =>
      GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500, height: 1.4);
}
