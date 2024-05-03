import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../utils/constant.dart';
import 'TicketItemWidget.dart';

class WinnerWidget extends StatelessWidget {
  final BoxDecoration decoration;
  final VoidCallback onTap;

  const WinnerWidget({
    Key? key,
    required this.onTap,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(20),
        decoration: kAllCornerBoxDecoration,
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Previous Month Contest".allInCaps,
              textAlign: TextAlign.center,
              style: textStyle(Colors.white, 20, 0, FontWeight.w500),
            ),
          ),Container(
            alignment: Alignment.center,
            child: Text(
              "Winners".allInCaps,
              textAlign: TextAlign.center,
              style: textStyle(Colors.green, 22, 0, FontWeight.w500),
            ),
          ),
          15.height,
          Image.asset(
            "assets/trip.jpeg",
            scale: 2,
          ),


          15.height,
         Container(
           padding: const EdgeInsets.symmetric(vertical: 10),
           decoration: kDialogBgDecoration,
           child:
          ListView.builder(
            shrinkWrap: true,
            primary: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: const EdgeInsets.only(top: 5, right: 10,left: 10,bottom: 5),
                  child: TicketItemWidget(
                    name: tickets[index].toString(),
                    closeIconVisibility: false,
                    onTap: () {

                    },
                  ));
            },
          ),
          ),

        ]));
  }
}
