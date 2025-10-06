import 'package:flutter/material.dart';

abstract class Fonts {
  static String get poppinsExtraBold => 'Poppins-ExtraBold';
  static String get poppinsSemiBold => 'Poppins-SemiBold';
  static String get poppinsRegular => 'Poppins-Regular';
  static String get poppinsMedium => 'Poppins-Medium';
  static String get poppinsBold => 'Poppins-Bold';
  static String get poppinsLight => 'Poppins-Light';
  static String get poppinsExtraLight => 'Poppins-ExtraLight';
  static String get poppinsThin => 'Poppins-Thin';

  static String get poppinsExtraBoldItalic => 'Poppins-ExtraBoldItalic';
  static String get poppinsSemiBoldItalic => 'Poppins-SemiBoldItalic';
  static String get poppinsItalic => 'Poppins-Italic';
  static String get poppinsMediumItalic => 'Poppins-MediumItalic';
  static String get poppinsBoldItalic => 'Poppins-BoldItalic';
  static String get poppinsLightItalic => 'Poppins-LightItalic';
  static String get poppinsExtraLightItalic => 'Poppins-ExtraLightItalic';
  static String get poppinsThinItalic => 'Poppins-ThinItalic';
}

abstract class ColorsConstants {
  static Color get accentOrange => const Color(0xffF5490F);
  static Color get urlBlue => const Color(0xff1A90FF);
  static Color get warningRed => const Color(0xFFF63837);
  static Color get defaultBlack => const Color(0xFF0D0A08);
  static Color get textBlack => const Color(0xFF797979);
  static Color get defaultWhite => const Color(0xFFFFFFFF);
  static Color get onSurfaceGrey => const Color(0xFF999999);
  static Color get surfaceOrange => const Color(0xFFFFDCD0);
  static Color get onSurfaceOrange => const Color(0xFFF4E6E3);
  static Color get correctGreen => const Color(0xff22F662);
}

class TextStyles {
  // normal fonts
  static TextStyle get poppinsExtraBold => TextStyle(
    fontFamily: Fonts.poppinsExtraBold,
    fontWeight: FontWeight.w800,
  );
  static TextStyle get poppinsBold =>
      TextStyle(fontFamily: Fonts.poppinsBold, fontWeight: FontWeight.w700);
  static TextStyle get poppinsSemiBold =>
      TextStyle(fontFamily: Fonts.poppinsSemiBold, fontWeight: FontWeight.w600);
  static TextStyle get poppinsMedium =>
      TextStyle(fontFamily: Fonts.poppinsMedium, fontWeight: FontWeight.w500);
  static TextStyle get poppinsRegular =>
      TextStyle(fontFamily: Fonts.poppinsRegular, fontWeight: FontWeight.w400);
  static TextStyle get poppinsLight =>
      TextStyle(fontFamily: Fonts.poppinsLight, fontWeight: FontWeight.w300);
  static TextStyle get poppinsExtraLight =>
      TextStyle(fontFamily: Fonts.poppinsLight, fontWeight: FontWeight.w300);

  // italic fonts
  static TextStyle get poppinsExtraBoldItalic => TextStyle(
    fontFamily: Fonts.poppinsExtraBoldItalic,
    fontWeight: FontWeight.w800,
  );
  static TextStyle get poppinsBoldItalic => TextStyle(
    fontFamily: Fonts.poppinsBoldItalic,
    fontWeight: FontWeight.w700,
  );
  static TextStyle get poppinsSemiBoldItalic => TextStyle(
    fontFamily: Fonts.poppinsSemiBoldItalic,
    fontWeight: FontWeight.w600,
  );
  static TextStyle get poppinsMediumItalic => TextStyle(
    fontFamily: Fonts.poppinsMediumItalic,
    fontWeight: FontWeight.w500,
  );
  static TextStyle get poppinsRegularItalic =>
      TextStyle(fontFamily: Fonts.poppinsItalic, fontWeight: FontWeight.w400);
  static TextStyle get poppinsLightItalic => TextStyle(
    fontFamily: Fonts.poppinsLightItalic,
    fontWeight: FontWeight.w300,
  );
  static TextStyle get poppinsExtraLightItalic => TextStyle(
    fontFamily: Fonts.poppinsLightItalic,
    fontWeight: FontWeight.w300,
  );
}

extension TextStyleHelpers on TextStyle {
  TextStyle get accentOrange => copyWith(color: ColorsConstants.accentOrange);
  TextStyle get surfaceOrange => copyWith(color: ColorsConstants.surfaceOrange);
  TextStyle get onSurfaceOrange =>
      copyWith(color: ColorsConstants.onSurfaceOrange);
  TextStyle get urlBlue => copyWith(color: ColorsConstants.urlBlue);
  TextStyle get defaultBlack => copyWith(color: ColorsConstants.defaultBlack);
  TextStyle get onSurfaceGrey => copyWith(color: ColorsConstants.onSurfaceGrey);
  TextStyle get defaultWhite => copyWith(color: ColorsConstants.defaultWhite);
  TextStyle get textBlack => copyWith(color: ColorsConstants.textBlack);
  TextStyle get warningRed => copyWith(color: ColorsConstants.warningRed);
}
