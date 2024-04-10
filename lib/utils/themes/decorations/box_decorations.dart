import 'package:flutter/material.dart';
import '../../enums/enum.dart';
import '../colors.dart';
import 'constants.dart';

List<BoxShadow> defaultBoxShadow({
  Color? shadowColor,
  double? blurRadius,
  double? spreadRadius,
  Offset offset = const Offset(0.0, 0.0),
}) {
  return [
    BoxShadow(
      color: shadowColor ?? shadowColorGlobal,
      blurRadius: blurRadius ?? defaultBlurRadius,
      spreadRadius: spreadRadius ?? defaultSpreadRadius,
      offset: offset,
    )
  ];
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? Colors.white,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: appShadowColor)
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}

BoxDecoration leftPaneBoxDecoration({Color bgColor = Colors.white}) {
  return BoxDecoration(color: bgColor, boxShadow: <BoxShadow>[
    BoxShadow(
        color: appPaneShadowColor,
        spreadRadius: 0,
        blurRadius: 44,
        offset: const Offset(0, 4))
  ]);
}

BoxDecoration containerBoxDecoration({Color bgColor = Colors.white}) {
  return BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(0, 0, 0, 0.05), width: 1),
      borderRadius:
           const BorderRadius.all(Radius.circular(appContainerBorderRadius)),
      color: const Color(0xffffffff),
      boxShadow: [
        BoxShadow(
            color: appContainerShadowColor,
            spreadRadius: 0,
            blurRadius: 24,
            offset: const Offset(0, 13))
      ]);
}

// TODO:: Param changed from isGreenButton to decorationColor because of more than two button color variant
BoxDecoration primaryButtonBoxDecoration(
    ButtonDecorationColor decorationColor) {
  return BoxDecoration(
      borderRadius:
          const BorderRadius.all(Radius.circular(appButtonBorderRadius)),
      gradient: LinearGradient(
        colors: decorationColor == ButtonDecorationColor.greenButton
            ? [appGreenButtonSecondaryColor, appGreenButtonSecondaryColor]
            : decorationColor == ButtonDecorationColor.deleteButton
                ? [appRedButtonSecondaryColor, appRedButtonSecondaryColor]
                : decorationColor ==
                        ButtonDecorationColor.primaryGradientReverce
                    ? [appPrimaryButtonColor, appPrimaryButtonColor]
                    : [appPrimaryButtonColor, appPrimaryButtonColor],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ));
}

BoxDecoration roundButtonBoxDecoration(radius) {
  return BoxDecoration(
      // borderRadius: BorderRadius.all(Radius.circular(radius)),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
            color: appPrimaryColor.withOpacity(0.24),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 5)),
        BoxShadow(
            color: appWhite.withOpacity(0.68),
            spreadRadius: 0,
            blurRadius: 0,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0, 1.04))
      ],
      gradient: const LinearGradient(
        colors: [appPrimaryButtonColor, appPrimaryButtonGradientColor],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ));
}

BoxDecoration secondaryButtonBoxDecoration() {
  return BoxDecoration(
      borderRadius:
          const BorderRadius.all(Radius.circular(appButtonBorderRadius)),
      boxShadow: [
        BoxShadow(
            color: appSecondaryButtonShadowColor,
            spreadRadius: 1.18,
            blurStyle: BlurStyle.inner)
      ],
      gradient: const LinearGradient(
        colors: [appHpGray, appHpGray],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ));
}

BoxDecoration resetButtonBoxDecoration() {
  return const BoxDecoration(
      borderRadius:
          BorderRadius.all(Radius.circular(appButtonBorderRadius)),
      boxShadow: [
        BoxShadow(
            color: appLineColor, spreadRadius: 1.18, blurStyle: BlurStyle.inner)
      ],
      gradient: LinearGradient(
        colors: [white, white],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ));
}

BoxDecoration disableButtonBoxDecoration() {
  return BoxDecoration(
      borderRadius:
          const BorderRadius.all(Radius.circular(appButtonBorderRadius)),
      boxShadow: const [
        BoxShadow(
            color: appHpGrayTwo, spreadRadius: 1.18, blurStyle: BlurStyle.inner)
      ],
      gradient: deselectButtonGradient);
}

BoxDecoration appPrimaryDisableButtonBoxDecoration() {
  return BoxDecoration(
      borderRadius:
          const BorderRadius.all(Radius.circular(appButtonBorderRadius)),
      boxShadow: const [
        BoxShadow(
            color: appDeselectColor,
            spreadRadius: 1.18,
            blurStyle: BlurStyle.inner)
      ],
      gradient: appPrimaryButtonDeselectColorGradient);
}

BoxDecoration primaryLightButtonBoxDecoration() {
  return BoxDecoration(
      borderRadius:
          const BorderRadius.all(Radius.circular(appButtonBorderRadius)),
      boxShadow: const [
        BoxShadow(
            color: appDeselectColor,
            spreadRadius: 1.18,
            blurStyle: BlurStyle.inner)
      ],
      gradient: appPrimaryButtonLightColorGradient);
}

BoxDecoration outlinedInputBoxDecoration({bool isDisable = false}) {
  return BoxDecoration(
      border: Border.all(color: appLineColor, width: 0.5),
      color: isDisable ? appDeselectColor : Colors.white,
      borderRadius: BorderRadius.circular(appButtonBorderRadius));
}

BoxDecoration appPrimaryBoxDecoration() {
  return BoxDecoration(
      border: Border.all(color: appDropdownBorderColor, width: 1),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(color: appDropdownShadowColor, blurRadius: 3, spreadRadius: 3)
      ],
      borderRadius: BorderRadius.circular(appButtonBorderRadius));
}

BoxDecoration inputBoxDecoration({bool isDisable = false}) {
  return BoxDecoration(
    color: isDisable ? appDeselectColor : Colors.white,
  );
}

BoxDecoration controlPanelIconContainerBoxDecoration() {
  return BoxDecoration(
      border: Border.all(
        color: appIconContainerBorder,
      ),
      borderRadius:
          const BorderRadius.all(Radius.circular(controlPanelIconBorderRadius)),
      gradient: controlPanelIconContainerGradientColor,
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: appPrimaryColor.withOpacity(0.12),
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 0)),
        BoxShadow(
            color: appWhite.withOpacity(0.20),
            spreadRadius: 0,
            blurRadius: 0,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0, 1.04))
      ]);
}

BoxDecoration scannerContainerBoxDecoration({bool isSelected = false}) {
  return BoxDecoration(
      border: Border.all(
          color: appPrimaryColor,
          style: isSelected ? BorderStyle.solid : BorderStyle.none,
          width: 1),
      borderRadius:
          const BorderRadius.all(Radius.circular(controlPanelIconBorderRadius)),
      gradient: isSelected
          ? selectedScannerContainerGradientColor
          : unselectedScannerContainerGradientColor,
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: const Color.fromRGBO(196, 196, 196, 0.24),
            spreadRadius: isSelected ? 4 : 0,
            blurRadius: 0,
            blurStyle: BlurStyle.inner,
            offset: const Offset(0, 1.04))
      ]);
}

BoxDecoration controlPanelIconInsetContainerBoxDecoration() {
  return BoxDecoration(
    borderRadius:
        const BorderRadius.all(Radius.circular(appContainerBorderRadius)),
    gradient: LinearGradient(
      colors: [
        const Color(0xffffffff).withOpacity(0),
        const Color(0xffffffff).withOpacity(1),
      ],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    ),
  );
}
