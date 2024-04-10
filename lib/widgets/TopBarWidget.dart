import 'package:flutter/material.dart';
import '../app/AppLocalizations.dart';
import '../utils/constant.dart';

class TopBarWidget extends StatelessWidget {
  final String leftIcon;
  final String screen;
  final String rightIcon;
  final String title;
  final String subTitle;
  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;
  final bool rightVisibility;
  final bool leftVisibility;
  final bool bottomTextVisibility;

  const TopBarWidget({
    Key? key,
    required this.onTapLeft,
    required this.onTapRight,
    required this.leftIcon,
    required this.rightIcon,
    required this.title,
    required this.rightVisibility,
    required this.leftVisibility,
    required this.bottomTextVisibility,
    required this.subTitle,
    required this.screen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: leftVisibility,
            child: GestureDetector(
              onTap: () => {onTapLeft()},
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  leftIcon,
                  scale: 8,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(right: 30),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context).translate(title),
                textAlign: TextAlign.center,
                style: textStyle(
                  Colors.white,
                  18,
                  0,
                  FontWeight.w500,
                ),
              ),
            ),
          ),
          Visibility(
              visible: rightVisibility,
              child: GestureDetector(
                onTap: () => {onTapRight()},
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    rightIcon,
                    scale:10,
                    color: Colors.white,
                  ),
                ),
              )),
        ]);
  }
}
