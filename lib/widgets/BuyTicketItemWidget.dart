import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../utils/constant.dart';

class BuyTicketItemWidget extends StatelessWidget {
  final String ticketNo;
  final bool closeIconVisibility;
  final VoidCallback onTap;

  const BuyTicketItemWidget({
    Key? key,
    required this.ticketNo,
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
          child: Stack(

              children: [
            Container(
                decoration: kWinnerDecoration,

                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.close_rounded)),
            Container(
                alignment: Alignment.center,
                child: Text(
                  ticketNo,
                  style: textStyle(Colors.white, 18, 0, FontWeight.normal),
                ))
          ])),
    );
  }
}
