import 'package:flutter/material.dart';

// Light Theme Colors
const appTextColorSecondary = Color(0xFF5A5C5E);
const appHpBrandBlue = Color(0xFF0096D6);
const appHpCian = Color(0xFF40DEFA);
const appHpGreen = Color(0xFF00D072);
const appHpGreenEighty = Color(0xFF00D072);
const appHpGreenTwo = Color(0xFF4EF5AB);
const appHpLightGreen = Color(0xFFEBFFF6);
const appHpLime = Color(0xFFD3FB66);
const appHpPink = Color(0xFFFF84FF);
const appHpRed = Color(0xFFF05656);
const appHpBlueTwo = Color(0xFF0078B8);
const appHpBlueForty = Color(0xFF0096D6);
const appHpBlueTen = Color(0xFFE6F5FB);
const appHpBlueSix = Color(0xFFF0F9FD);
const appHpGray = Color(0xFFF6F6F6);
const appHpGrayTwo = Color(0xFFC9C9C9);
const appHpGrayThree = Color(0xFFEEEEEE);
const appHpGrayFour = Color(0xFFA3A3A3);
const appHpGrayDark = Color(0xFF73726C);
const appHpGreenlight = Color(0xFFD5E4EC);
const appDropdownBackroundlight = Color(0xFFF2F9FB);

const appPrimaryColor = Color(0XFF0096D6);
const appPrimaryColorDark = Color(0XFF1D5B90);
const appDropdownBorderColor = Color(0XFFE3F1F9);
const appDropdownBackRoundColor = Color(0XFFFAFDFF);
const appDropdownShadowColor = Color(0XFFF1F8FC);
const appPrimaryTextColor = Color(0Xff73726C);
const appDangerTextColor = Color(0XffFF001F);
const appSecondaryColor = Color(0xff75D6FF);
const appRegularTextColor = Color(0xff8D8D8D);
const appRegularDropdownColor = Color(0xffF5F5F5);
const connectedTextColor = Color(0xffA3A3A3);


const appBaseColor = Color(0xff0c1133);
const appBaseColor1 = Color(0xff3cbdff);
const appBaseColorSecondary = Color(0xff8ec045);
const appRedColor = Color(0xfff1636a);
const appTitleBarColor = Color(0xff9f9f9f);
const appHintTextColor = Color(0xff6e7173);
const appTitleTextColor = Color(0xff929292);
const appBlueColor = Color(0xff5c8c98);
const appGreenColor = Color(0xff318a34);
const appOrangeColor = Color(0xffef891c);
const appYellowColor = Color(0xffdaac39);
const appDateColor = Color(0xffcfdbdd);
const appBgGrayColor = Color(0xfff3efef);



const iconColorPrimary = appPrimaryColor;
const iconColorSecondary = Color(0Xffc4c4c4);
const sliderInActiveSecondary = Color(0XFFe7e7e7);

const appLayoutBackground = Color(0x332F4F5C);
const appWhite = Color(0xFFFFFFFF);
const appShadowColor = Color(0xFF000000);
const appColorPrimaryLight = Color(0xFFF9FAFF);
const appSecondaryBackgroundColor = Color(0xFF131d25);
const appLineColor = Color(0Xffc4c4c4);
const appScanBackgroundColor = Color(0XffD5DCDE);
const appPostScanTabColor = Color(0XffF3F3F3);
const appPlaceholderTextColor = Color(0xff3D3D3D);
const appPrepareScannerTextColor = Color(0xff4D4D4D);





/*<color name="app_dark_base_color">#30a7df</color>
<color name="app_base_color">#30a7df</color>
<color name="app_base_color_second">#8ec045</color>
<color name="red_color">#f1636a</color>
<color name="title_bar_color">#9f9f9f</color>
<color name="hint_text_color">#6E7173</color>
<color name="title_text_color">#929292</color>
<color name="light_gray_color">#9CDFDFDF</color>
<color name="blue_color">#5C8C98</color>
<color name="trans_black">#40000000</color>
<color name="filled_gray">#E6E6E6</color>
<color name="light_gray">#C3C3C3</color>
<color name="green">#318A34</color>
<color name="orange">#EF891C</color>
<color name="yellow">#DAAC39</color>
<color name="bg_date_color">#cfdbdd</color>
<color name="bg_gray_color">#F3EFEF</color>
<color name="light_blue_600">#FF039BE5</color>
<color name="light_blue_900">#FF01579B</color>
<color name="light_blue_A200">#FF40C4FF</color>
<color name="light_blue_A400">#FF00B0FF</color>
<color name="black_overlay">#66000000</color>*/




const controlPanelIconContainerBackgroundColor = Color(0xffE9F8FF);
const controlPanelIconContainerBackgroundGradientColor = Color(0xffDEF5FF);
const white = Color(0xffFFFFFF);
const controlPanelIconContainerGradientColor = LinearGradient(
  // transform: GradientRotation(math.pi / 2),
  colors: [
    controlPanelIconContainerBackgroundGradientColor,
    // Colors.white,
    controlPanelIconContainerBackgroundColor
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

var unselectedScannerContainerGradientColor = LinearGradient(
  // transform: GradientRotation(math.pi / 2),
  colors: [
    Color.fromRGBO(222, 218, 218, 0.24),
    Color.fromRGBO(84, 84, 84, 0.24),
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

const selectedScannerContainerGradientColor = LinearGradient(
  // transform: GradientRotation(math.pi / 2),
  colors: [
    appPrimaryColor,
    Color(0xFF75D6FF),
  ],
  begin: Alignment(1, -1),
  end: Alignment(-1, 1.6),
);

var appPrimaryButtonLightColorGradient = LinearGradient(
  // transform: GradientRotation(math.pi / 2),
  colors: [
    Color(0xff22A1D8).withOpacity(0.09),
    // Colors.white,
    appPrimaryColor.withOpacity(0.12)
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

var appPrimaryButtonDeselectColorGradient = LinearGradient(
  // transform: GradientRotation(math.pi / 2),
  colors: [
    appPrimaryColor.withOpacity(0.5),
    appSecondaryColor.withOpacity(0.5),
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

final controlPanelIconContainerBorderColor = appPrimaryColor.withOpacity(0.12);
const appIconContainerBorder = Color(0xffdbebf4);
const appIconContainerShadow = Color(0xffd4eefd);
const borderPrepareScanner = Color(0Xffc4c4c4);
const updateButtonLight = Color(0XffFFA6A6);
const updateButtonDark = Color(0XffEC6363);
const updateTextColor = Color(0XffFF4f4f);
const redColor = Color(0XffEC6A5E);

const appPrimaryButtonColor = appPrimaryColor;
const appPrimaryButtonGradientColor = appSecondaryColor;
const appSecondaryButtonColor = Color(0xffF4F4F4);
const appSecondaryButtonGradientColor = Color(0xffF9F9F9);
const appSmallActionButtonSecondaryColor = Color(0xffffffff);
const appSmallActionButtonSecondaryGradientColor = Color(0xfffbfbfb);
const appGreenButtonSecondaryColor = Color(0xff00D072);
const appRedButtonSecondaryColor = Color(0xffFF3900);
const appGreenButtonSecondaryGradientColor = Color(0xff4EF5AB);
const appRedButtonSecondaryGradientColor = Color(0xffFFAB93);
const ghostWhite = Color(0xFFDCDCDC);
const borderColor = Color(0xFFDADADA);

var deselectButtonGradient = const LinearGradient(
  colors: [
    Color.fromRGBO(240, 240, 240, 0.35),
    Color.fromRGBO(215, 215, 215, 0.38)
  ],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);

const appDeselectColor = Color(0xFFF7F7F7);
var buttonDeselectColor = const Color(0xFFE8E8E8);
var textDeselectColor = const Color(0xFFC4C4C4);
const iconSelectedColor = Color(0xFF929292);
var iconDeSelectedColor = const Color(0xffd3d3d3);

final appHoverColor = appPrimaryColor.withOpacity(0.07);
final appPaneShadowColor = appShadowColor.withOpacity(0.07);
final appContainerShadowColor = appShadowColor.withOpacity(0.08);
final appSecondaryButtonShadowColor = const Color(0Xffc4c4c4).withOpacity(0.13);

// Primary as Material Color

const Map<int, Color> primaryMatColorDefs = {
  50: Color.fromRGBO(0, 150, 214, .1),
  100: Color.fromRGBO(0, 150, 214, .2),
  200: Color.fromRGBO(0, 150, 214, .3),
  300: Color.fromRGBO(0, 150, 214, .4),
  400: Color.fromRGBO(0, 150, 214, .5),
  500: Color.fromRGBO(0, 150, 214, .6),
  600: Color.fromRGBO(0, 150, 214, .7),
  700: Color.fromRGBO(0, 150, 214, .8),
  800: Color.fromRGBO(0, 150, 214, .9),
  900: Color.fromRGBO(0, 150, 214, 1),
};

// MaterialColor primaryMatColor = const MaterialColor(appPrimaryColor, primaryMatColorDefs);

const kPrimaryColor = Color.fromRGBO(58, 76, 148, 1);
const kPrimaryColor2 = Color.fromRGBO(116, 128, 179, 1.0);
const kSecondaryColor = Color.fromRGBO(247, 245, 255, 1.0);
const kButtonColor = Color.fromRGBO(255, 246, 36, 1.0);
const kDisabledButtonColor = Color.fromRGBO(255, 246, 36, 0.5019607843137255);
const kButtonBgColor = Color.fromRGBO(49, 49, 85, 1);
const kBlackColor = Color.fromRGBO(9, 9, 9, 1.0);
const kBlueColor = Color.fromRGBO(150, 181, 210, 1.0);
const kBaseColor = Color.fromRGBO(125, 2, 121, 1.0);
const kUnselectedTextColor = Color.fromRGBO(125, 133, 159, 1.0);
const kSelectedTextColor = Color.fromRGBO(205, 15, 127, 1.0);
const kCircleColor = Color.fromRGBO(133, 25, 231, 1.0);
const kBaseColorDark = Color.fromRGBO(20, 0, 78, 1.0);
const kBaseRed = Color.fromRGBO(193, 30, 30, 1.0);
const kDarkBlueColor = Color.fromRGBO(2, 9, 52, 0.3607843137254902);
const kYellow = Color.fromRGBO(251, 255, 46, 1.0);
const kRed = Color.fromRGBO(249, 118, 87, 1);
const kBaseColor2 = Color.fromRGBO(208, 18, 132, 1.0);
const kBaseColor3 = Color.fromRGBO(96, 61, 220, 1.0);
const kLightGray = Color.fromRGBO(196, 196, 196, 1.0);
const kTrans = Color.fromRGBO(255, 255, 255, 0.0);
const kRedTrans = Color.fromRGBO(252, 0, 0, 0.21568627450980393);
const klight2grey = Color.fromRGBO(44, 44, 44, 1.0);
const kTransBase = Color.fromRGBO(26, 5, 65, 0.10196078431372549);
const kTransBaseNew = Color.fromRGBO(26, 5, 65, 1.0);
const kTransBaseNewWeb = Color.fromRGBO(26, 5, 65, 1.0);
const kTransBaseNewWeb1 = Color.fromRGBO(31, 6, 236, 0.72);

const kWhiteTrans = Color.fromRGBO(255, 255, 255, 0.050980392156862744);
const kWhiteTransWeb = Color.fromRGBO(255, 255, 255, 0.023529411764705882);
const kWhiteTrans20 = Color.fromRGBO(98, 98, 126, 1.0);
const kBackground = Color.fromRGBO(49, 49, 85, 1.0);
const kDrawerBG = Color.fromRGBO(36, 36, 66, 1);
const kTileBG = Color.fromRGBO(49, 49, 85, 1);
const kLightWhiteTrans = Color.fromRGBO(255, 255, 255, 0.011764705882352941);
const kT = Color.fromRGBO(255, 255, 255, 0.0);
const kBaseLightColor = Color.fromRGBO(173, 69, 154, 1);
const kButtonColor1 = Color.fromRGBO(192, 111, 255, 1.0);
const kButtonColor2 = Color.fromRGBO(159, 35, 255, 1.0);
const kLoginText = Color.fromRGBO(172, 66, 254, 1.0);
const kLightPink = Color.fromRGBO(188, 154, 215, 0.5803921568627451);
const kLightGray1 = Color.fromRGBO(183, 167, 194, 0.596078431372549);
const kTextGrey = Color.fromRGBO(199, 199, 199, 1.0);
const kTextColor = Color.fromRGBO(172, 66, 254, 1.0);
const kDialogBgColor = Color.fromRGBO(36, 36, 66, 1);
const primary = Colors.white;
const backgroundDark =Color.fromRGBO(36, 36, 66, 1);
const backgroundDark3 = Color(0xff1a0541);
const backgroundDark2 = Color(0xff1a0541);
const shimmerColor = Color(0xff22074d);
const accent = Color(0xffac42fe);
const green = Color(0xff5be845);
const accentLight = Color(0x67ac42fe);
const gray = Color(0xffe5e4e4);
const red = Color(0x84ff0000);
const blue = Color(0x99239DFD);
const miti = Color(0x80fa6309);
const yellow = Color(0x80ffe30a);
const greenTrans = Color(0x805be845);