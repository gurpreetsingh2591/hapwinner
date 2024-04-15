import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../utils/constant.dart';

class TicketItemWidget extends StatelessWidget {
  final String name;
  final bool closeIconVisibility;
  final VoidCallback onTap;

  const TicketItemWidget({
    Key? key,
    required this.name,
    required this.closeIconVisibility,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
            decoration: kTicketDecoration,
            alignment: Alignment.center,
            height: 30,
            child: Text(
              name,
              style: textStyle(Colors.white, 12, 0, FontWeight.normal),
            )));
  }
}
