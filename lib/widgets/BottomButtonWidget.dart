import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../app/AppLocalizations.dart';
import '../app/router.dart';
import '../utils/constant.dart';
import '../utils/themes/colors.dart';
import 'WinnerWidget.dart';

class BottomButtonWidget extends StatelessWidget {
  final String name;
  final String subTitle;
  final String title;
  final bool iconVisibility;
  final bool subTitleVisibility;
  final bool titleVisibility;
  final VoidCallback onTap;
  final VoidCallback onTapTitle;
  final double margin;
  final BoxDecoration decoration;
  final Color textColor;
  final Color titleTextColor;

  const BottomButtonWidget({
    Key? key,
    required this.name,
    required this.onTap,
    required this.subTitle,
    required this.iconVisibility,
    required this.subTitleVisibility,
    required this.title,
    required this.titleVisibility,
    required this.onTapTitle,
    required this.margin,
    required this.decoration,
    required this.textColor, required this.titleTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Align(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Visibility(
                    visible: subTitleVisibility,
                    child:
                  Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 32, right: 32),
                      alignment: Alignment.topCenter,
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          text:
                              AppLocalizations.of(context).translate(subTitle),
                          style: textStyle(
                              Colors.white54, 14, 0.5, FontWeight.w400),
                          children: <TextSpan>[
                            TextSpan(
                                text: AppLocalizations.of(context)
                                    .translate('agree_terms2'),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'poppins',
                                  decoration: TextDecoration.underline,
                                )),
                            TextSpan(
                              text: AppLocalizations.of(context)
                                  .translate('agree_terms3'),
                              style: textStyle(
                                  Colors.white54, 14, 0.5, FontWeight.w400),
                            ),
                            // can add more TextSpans here...
                          ],
                        ),
                      )),),
                  Container(
                    alignment: Alignment.bottomCenter,
                    decoration: kButtonBgDecoration,
                    padding: EdgeInsets.only(
                        left: 32,
                        right: 32,
                        bottom: margin + margin + 5,
                        top: margin),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Visibility(
                            visible: titleVisibility,
                            child: GestureDetector(
                                onTap: () => {onTapTitle()},
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate(title),
                                    style: textStyle(
                                        titleTextColor, 16, 0.5, FontWeight.w400),
                                  ),
                                )),
                          ),

                        ]),
                  ),
                ]),
          ),
        ],
      ),
    ));
  }
}
