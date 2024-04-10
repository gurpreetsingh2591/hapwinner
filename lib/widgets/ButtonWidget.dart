import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/constant.dart';

class ButtonWidget extends StatelessWidget {
  final String name;
  final double size;
  final String icon;
  final Color textColors;
  final bool visibility;
  final bool rightVisibility;
  final double padding;
  final double scale;
  final double height;
  final double margin;
  final BoxDecoration decoration;
  final VoidCallback onTap;
  final FontWeight weight;
  final Color iconColor;

  const ButtonWidget({
    Key? key,
    required this.name,
    required this.icon,
    required this.visibility,
    required this.padding,
    required this.onTap,
    required this.size,
    required this.scale,
    required this.height,
    required this.decoration,
    required this.textColors,
    required this.rightVisibility,
    required this.weight,
    required this.iconColor, required this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: margin),
      padding: EdgeInsets.only(left: padding, right: padding),
      decoration: decoration,
      height: height,
      alignment: Alignment.center,
      child: ElevatedButton(
          onPressed: onTap,

          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: Colors.grey,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: rightVisibility,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        icon,
                        scale: scale,
                        color: iconColor,
                      ),
                    ),
                  )),
              Flexible(
                child:
                    Text( name, textAlign:TextAlign.center  ,style: textStyle(textColors, size, 0.5, weight)),
              ),
              Visibility(
                  visible: visibility,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(left: 5),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        icon,
                        scale: scale,
                        color: iconColor,
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
