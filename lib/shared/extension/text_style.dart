import 'package:flutter/cupertino.dart';
import 'package:template_bloc/gen/fonts.gen.dart';

/// Base TextStyle mặc định — Manrope font, không có size/color/weight.
/// Dùng làm điểm khởi đầu cho mọi text style trong app.
const kTextStyle = TextStyle(fontFamily: FontFamily.manrope);

extension TextStyleExtension on TextStyle {
  // ── Font weight ───────────────────────────────────────────────────────────
  TextStyle get black => copyWith(fontWeight: FontWeight.w900);
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get extraLight => copyWith(fontWeight: FontWeight.w200);
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);

  // ── Font size ─────────────────────────────────────────────────────────────
  TextStyle size(double fontSize) => copyWith(fontSize: fontSize);

  // ── Color ─────────────────────────────────────────────────────────────────
  TextStyle withColor(Color color) => copyWith(color: color);

  // ── Font family ───────────────────────────────────────────────────────────
  TextStyle get manrope => copyWith(fontFamily: FontFamily.manrope);

  // ── Decorations ───────────────────────────────────────────────────────────
  TextStyle withLetterSpacing(double spacing) => copyWith(letterSpacing: spacing);
  TextStyle withHeight(double h) => copyWith(height: h);

  // ── Backwards compat ──────────────────────────────────────────────────────
  TextStyle newFontSize(double fontSize) => copyWith(fontSize: fontSize);
}
