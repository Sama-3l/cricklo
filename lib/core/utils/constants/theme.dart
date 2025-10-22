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

// abstract class ColorsConstants {
//   static Color get accentOrange => const Color(0xffF5490F);
//   static Color get urlBlue => const Color(0xff1A90FF);
//   static Color get warningRed => const Color(0xFFF63837);
//   static Color get defaultBlack => const Color(0xFF0D0A08);
//   static Color get textBlack => const Color(0xFF797979);
//   static Color get defaultWhite => const Color(0xFFFFFFFF);
//   static Color get onSurfaceGrey => const Color(0xFFEEEEEE);
//   static Color get surfaceOrange => const Color(0xFFF6D0C5);
//   static Color get onSurfaceOrange => const Color(0xFFF4E6E3);
//   static Color get correctGreen => const Color(0xff22F662);

//   static Color get scorerCenter => const Color(0xffF3D750);

//   static Color get wagonWheelField => const Color(0xff419B44);
//   static Color get wagonWheelPitch => const Color(0xffFFC21F);
//   static Color get wagonWheelStatBackground => const Color(0xff2E3C43);
//   static Color get wagonWheelStat1s => const Color(0xffB5B6B7);
//   static Color get wagonWheelStat2s => const Color(0xff3F51B5);
//   static Color get wagonWheelStat3s => const Color(0xff9C28B1);
//   static Color get wagonWheelStat4s => const Color(0xffFFEB3C);
//   static Color get wagonWheelStat6s => const Color(0xffFE5722);
// }

abstract class ColorsConstants {
  static bool isDarkMode = false;

  static Color get accentOrange =>
      isDarkMode ? const Color(0xffFF784E) : const Color(0xffF5490F);
  static Color get urlBlue =>
      isDarkMode ? const Color(0xff64B5F6) : const Color(0xff1A90FF);
  static Color get warningRed =>
      isDarkMode ? const Color(0xFFEF5350) : const Color(0xFFF63837);
  static Color get defaultBlack =>
      isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF0D0A08);
  static Color get textBlack =>
      isDarkMode ? const Color(0xFFCCCCCC) : const Color(0xFF797979);
  static Color get defaultWhite =>
      isDarkMode ? const Color(0xFF121212) : const Color(0xFFFFFFFF);
  static Color get onSurfaceGrey =>
      isDarkMode ? const Color(0xFF333333) : const Color(0xFFEEEEEE);
  static Color get surfaceOrange =>
      isDarkMode ? const Color(0xFF442C25) : const Color(0xFFF6D0C5);
  static Color get onSurfaceOrange =>
      isDarkMode ? const Color(0xFF3B2E2B) : const Color(0xFFF4E6E3);
  static Color get correctGreen =>
      isDarkMode ? const Color(0xff00E676) : const Color(0xff22F662);

  static Color get scorerCenter =>
      isDarkMode ? const Color(0xffD7C230) : const Color(0xffF3D750);

  static Color get wagonWheelField =>
      isDarkMode ? const Color(0xff336633) : const Color(0xff419B44);
  static Color get wagonWheelPitch =>
      isDarkMode ? const Color(0xffD4A21A) : const Color(0xffFFC21F);
  static Color get wagonWheelStatBackground =>
      isDarkMode ? const Color(0xff1E272B) : const Color(0xff2E3C43);
  static Color get wagonWheelStat1s =>
      isDarkMode ? const Color(0xff999999) : const Color(0xffB5B6B7);
  static Color get wagonWheelStat2s =>
      isDarkMode ? const Color(0xff5C6BC0) : const Color(0xff3F51B5);
  static Color get wagonWheelStat3s =>
      isDarkMode ? const Color(0xffBA68C8) : const Color(0xff9C28B1);
  static Color get wagonWheelStat4s =>
      isDarkMode ? const Color(0xffFFEB3C) : const Color(0xffFFEB3C);
  static Color get wagonWheelStat6s =>
      isDarkMode ? const Color(0xffFF7043) : const Color(0xffFE5722);
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
