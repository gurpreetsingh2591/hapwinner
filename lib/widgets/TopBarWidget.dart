import 'package:flutter/material.dart';
import '../app/AppLocalizations.dart';
import '../utils/constant.dart';

class TopBarWidget extends StatelessWidget {
  final String leftIcon;
  final String screen;
  final String title;
  final VoidCallback onTapLeft;
  final bool leftVisibility;

  const TopBarWidget({
    Key? key,
    required this.onTapLeft,
    required this.leftIcon,
    required this.title,
    required this.leftVisibility,
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
                  scale: 4,
                  color: Colors.white,
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
                title,
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
            visible: false,
            child: GestureDetector(
              onTap: () => {onTapLeft()},
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  leftIcon,
                  scale: 4,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]);
  }
}
