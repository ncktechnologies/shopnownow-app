import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final textTheme = Theme.of(navigatorKey.currentState!.context).textTheme;
final screenSize = MediaQuery.of(navigatorKey.currentState!.context).size;
// final UniqueKey scaffoldKey = UniqueKey();

Duration requestDuration = const Duration(seconds: 60);

bool isFirstTime = true;

RegExp onlyTextValues = RegExp(r'[a-zA-Z]');

bool isEmail(String? email) {
  if (email == null || email.isEmpty) {
    return false;
  } else {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = RegExp(p);

    return regExp.hasMatch(email);
  }
}

bool isPassword(String password) {
  String pattern = r'^(?=.*?[a-zA-Z0-9]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(password);
}

bool isValidName(String? name) {
  if (name == null || name.isEmpty) {
    return false;
  } else {
    String n = r"^[\\p{L} .'-]+$";
    RegExp regExp = RegExp(n);

    return regExp.hasMatch(name);
  }
}

String? validateField(String? text, {required String result}) {
  if (text == null || text.isEmpty) {
    return result;
  } else {
    return null;
  }
}

// Spacing
const double kPadding = 5;
const double kSmallPadding = 10;
const double kRegularPadding = 15;
const double kMediumPadding = 20;
const double kMicroPadding = 24;
const double kMacroPadding = 30;
const double kLargePadding = 40;
const double kFullPadding = 60;
const double kSupremePadding = 100;

const double kWidthRatio = 0.9;
const double kIconSize = 24;

double kCalculatedWidth(Size size) => size.width * kWidthRatio;

double kCalculatedMargin(Size size) => size.width * (1 - kWidthRatio) / 2;

// Colors
// Brand Colors
const Color kPrimaryColor = Color(0xffFC0303);
const Color kTextInputBorderColor = Color(0xffD0D5DD);
const Color kLight400 = Color(0xffFDFDFD);
const Color kPrimaryWhite = Colors.white;
const Color kLight300 = Color(0xffF4F4F4);
const Color kGrey200 = Color(0xff98A2B3);
const Color kSecondaryColor = Color(0xffFFF4F0);
const Color kDarkColor300 = Color(0xff344054);
const Color kGrey800 = Color(0xffA6A6A6);
const Color kGrey600 = Color(0xff475367);
const Color kPurple50 = Color(0xff101928);
const Color kDividerColor = Color(0xffE4E7EC);
const Color kDarkColor400 = Color(0xff303030);
const Color kBright700 = Color(0xffF6F6F6);
const Color kDarkColor = Color(0xff1B1818);
const Color kDark200 = Color(0xff645D5D);
const Color k200 = Color(0xffF0F2F5);
const Color kGrey400 = Color(0xff514A4A);
const Color kLight700 = Color(0xff667185);
const Color kLightAsh200 = Color(0xffFAFCFF);
const Color kGrey700 = Color(0xffFAFAFA);
const Color kBlack900 = Color(0xff22292E);
const Color kLight100 = Color(0xffA8A8A8);
const Color kYellow = Color(0xffEB8B23);
const Color kLight800 = Color(0xffFFF5D2);
const Color kLight900 = Color(0xffEDEDED);
const Color kLightGrey100 = Color(0xffF2F3F3);
const Color kBlack100 = Color(0xff292D32);
const Color kToastColor2 = Color(0xff099137);
const Color kSuccess = Color(0xffE7F6EC);
const Color kGrey100 = Color(0xffD1D3D4);
const Color kBright100 = Color(0xffF2F8F5);
const Color kGrey500 = Color(0xffFCFCFC);
const Color kDarkPurpleColor = Color(0xff202223);
const Color kLight200 = Color(0xff5C5F62);
const Color kPurple100 = Color(0xff475467);
const Color kGreen300 = Color(0xff04802E);
const Color kDarkPurple = Color(0xff1D2739);
const Color green = Color(0xff05A357);
const Color kLightAsh = Color(0xffEBEBEB);
const Color kYellow400 = Color(0xffFEECC9);
const Color kBlack600 = Color(0xff191919);
const Color kOrange500 = Color(0xffFCAA0A);
const Color kBlue = Color(0xff02013B);
const Color kLightGrey200 = Color(0xffFBFBFB);
const Color kLightAsh300 = Color(0xffF7F7FB);
const Color kDark100 = Color(0xff64748B);
const Color kError900 = Color(0xffFF545E);
const Color kGreen10 = Color(0xff7AD8B1);
const Color kGreen200 = Color(0xff4ECA6F);
const Color kGreen100 = Color(0xffE9F8EF);
const Color kLight500 = Color(0xffF3F3F3);
const Color kTransparent = Colors.transparent;
const Color kDark300 = Color(0xff262626);
const Color kDark400 = Color(0xff3C3C3C);
const Color kDarkColor200 = Color(0xff363636);
const Color kLightAsh100 = Color(0xffE5E5E5);
const Color kLightAsh400 = Color(0xffD9DBE4);
const Color kLightGrey400 = Color(0xffF5F7F9);
const Color kLightAsh50 = Color(0xffF2F3F4);
const Color kDark900 = Color(0xff101828);
const Color kLightRed100 = Color(0xffFEF2F2);
const Color kLightPurple100 = Color(0xffF9FAFB);
const Color kLightPurple200 = Color(0xffE7F1F7);
const Color kLightBlue400 = Color(0xff107AB6);
const Color kLightRed400 = Color(0xffFE0000);
const Color kLightDark400 = Color(0xffD9D9D9);







const double kBorderWidth = 1;
const double kThickBorderWidth = 3;
const BorderRadius kBorderRadius = BorderRadius.all(Radius.circular(kPadding));
const BorderRadius kBorderSmallRadius =
    BorderRadius.all(Radius.circular(kSmallPadding));
const BorderRadius kBorderMidRadius =
    BorderRadius.all(Radius.circular(kRegularPadding));
const BorderRadius kFullBorderRadius = BorderRadius.all(Radius.circular(100));
BoxDecoration kTextFieldBoxDecoration = const BoxDecoration(
    borderRadius: kBorderRadius, border: null, color: Colors.white);
BoxDecoration kBottomSheetBoxDecoration = const BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(15.0),
    topRight: Radius.circular(15.0),
  ),
);

InputBorder borderDesign = const OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.blueGrey,
  ),
);

InputBorder errorBorderDesign = const OutlineInputBorder(
  borderSide: BorderSide(
    color: Colors.red,
  ),
);

BoxShadow kBoxShadow(Color color) => BoxShadow(
      color: color,
      spreadRadius: 5,
      blurRadius: 7,
      offset: const Offset(0, 2), // changes position of shadow
    );

BoxShadow kBoxShadowMid(Color color) => BoxShadow(
      color: color,
      spreadRadius: 2,
      blurRadius: 4,
      offset: const Offset(0, 5), // changes position of shadow
    );

BoxShadow kBoxShadowCondensed(Color color) => BoxShadow(
      color: color,
      spreadRadius: 1,
      blurRadius: 1,
      offset: const Offset(0, 3), // changes position of shadow
    );



// Text
TextStyle kDisplayMediumTextStyle = const TextStyle(
  fontWeight: FontWeight.w400,
  color: kPrimaryWhite,
  fontSize: 16,
  fontFamily: "Inter",
);

TextStyle kDisplayLargeTextStyle = const TextStyle(
  fontWeight: FontWeight.w600,
  color:  kPrimaryColor,
  fontSize: 16,
  fontFamily: "Inter",
);

TextStyle kHeadlineMediumTextStyle = const TextStyle(
  fontWeight: FontWeight.w400,
  color: kDark200,
  fontSize: 14,
  fontFamily: "Inter",
);

TextStyle kBodyMediumStyle = const TextStyle(
  fontWeight: FontWeight.w700,
  color: kDarkColor,
  fontSize: 24,
  fontFamily: "Inter",
);

TextStyle kTitleMediumStyle = const TextStyle(
  fontWeight: FontWeight.w400,
  color: kPurple50,
  fontSize: 18,
  fontFamily: "Inter",
);

TextStyle kDisplaySmallTextStyle = const TextStyle(
  fontWeight: FontWeight.w400,
  color: kPurple100,
  fontSize: 12,
  fontFamily: "Inter",
);
TextStyle kTitleSmallStyle = const TextStyle(
  fontWeight: FontWeight.w400,
  color: kBlack900,
  fontSize: 16,
  fontFamily: "Inter",
);

TextStyle kBodyLargeStyle = const TextStyle(
  fontWeight: FontWeight.w500,
  color: kToastColor2,
  fontSize: 10,
  fontFamily: "Inter",
);







ThemeData kThemeData = ThemeData.light(
  useMaterial3: false
).copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: kPrimaryWhite,
  iconTheme: const IconThemeData(size: kIconSize, color: kPrimaryColor),
  // dividerColor: kLightGrey,
  primaryColor: kPrimaryColor,
  canvasColor: kPrimaryWhite,
  // backgroundColor: kPrimaryWhite,
  // textSelectionTheme: const TextSelectionThemeData(
  //   selectionHandleColor: kColorGreen,
  //   cursorColor: kPrimaryColor,
  //   selectionColor: kLightGrey,
  // ),
  dialogBackgroundColor: kLight800,
  appBarTheme: AppBarTheme(
    color: kPrimaryWhite,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: kPrimaryWhite,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    elevation: 0,
    iconTheme: const IconThemeData(size: kIconSize, color: Colors.black),
    titleTextStyle:
        kTitleMediumStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
      displayLarge: kDisplayLargeTextStyle,
      displayMedium: kDisplayMediumTextStyle,
      bodyMedium: kBodyMediumStyle,
      titleMedium: kTitleMediumStyle,
      displaySmall: kDisplaySmallTextStyle,
      titleSmall: kTitleSmallStyle,
      bodyLarge: kBodyLargeStyle, headlineMedium: kHeadlineMediumTextStyle),
);

ThemeData kThemeDataDark = ThemeData.dark().copyWith(
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: kBlack900,
  iconTheme: const IconThemeData(size: kIconSize, color: kPrimaryWhite),
  // dividerColor: kLightGrey,
  primaryColor: kPrimaryColor,
  canvasColor: kPrimaryWhite,
  // backgroundColor: kPrimaryBlack,
  // textSelectionTheme: const TextSelectionThemeData(
  //   selectionHandleColor: kColorGreen,
  //   cursorColor: kPrimaryColor,
  //   selectionColor: kLightGrey,
  // ),
  dialogBackgroundColor: kPrimaryColor,
  appBarTheme: AppBarTheme(
    color: kPrimaryColor,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: kPrimaryColor,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
    elevation: 0,
    iconTheme: const IconThemeData(size: kIconSize, color: kPrimaryWhite),
    titleTextStyle: kDisplayLargeTextStyle.copyWith(
        fontSize: 16, fontWeight: FontWeight.w500),
  ),
  textTheme: TextTheme(
      displayLarge: kDisplayLargeTextStyle.copyWith(color: kPrimaryWhite),
      displayMedium: kDisplayMediumTextStyle.copyWith(color: kPrimaryWhite),
      bodyMedium: kBodyMediumStyle.copyWith(color: kPrimaryWhite),
      titleMedium: kTitleMediumStyle.copyWith(color: kPrimaryWhite),
      displaySmall: kDisplaySmallTextStyle.copyWith(color: kPrimaryWhite),
      titleSmall: kTitleSmallStyle.copyWith(color: kPrimaryWhite),
      bodyLarge: kBodyLargeStyle.copyWith(color: kPrimaryWhite), headlineMedium: kHeadlineMediumTextStyle.copyWith(color: kPrimaryWhite)),
);
