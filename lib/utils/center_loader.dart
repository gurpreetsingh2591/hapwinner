import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hap_winner_project/utils/themes/colors.dart';



showCenterLoader(BuildContext context) {
  showDialog(context: context, barrierDismissible: false,builder: (ctx) => buildContainer());
}

Widget buildContainer() {
  return  const SpinKitFadingCircle(
            color: kBaseLightColor,
            size: 50.0,
          );
}
