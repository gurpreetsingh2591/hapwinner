import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';

import '../app/AppLocalizations.dart';
import '../utils/constant.dart';

class CustomToastWidget extends StatelessWidget {
  final String email;
  final String msg;
  final String image;
  final double scale;

  const CustomToastWidget({
    Key? key,
    required this.msg,
    required this.image, required this.email, required this.scale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: kDialogBgDecorationSecondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            image,
            scale: scale,
          ),
          25.width,
          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
               msg,
                style: textStyle(Colors.white, 14, 0.5, FontWeight.w400),
              ),
              Text(
                email,
                style: textStyle(Colors.white, 14, 0.5, FontWeight.w400),
              ),
            ],
          ),),
        ],
      ),
    );
  }
}
