import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../utils/constant.dart';


class BookingItemWidget extends StatelessWidget {
  final String time;
  final String date;
  final VoidCallback onTap;

  const BookingItemWidget({
    Key? key,
    required this.date, required this.time, required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        decoration: kMessageItemDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                "Date: $date",
                textAlign: TextAlign.left,
                style: textStyle(Colors.black, 14, 0, FontWeight.w400),
              ),
            ),
            5.height,
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            5.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                    "Time: $time",
                    style: textStyle(
                      Colors.black87,
                      12,
                      0,
                      FontWeight.w400,
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                  ),

                 GestureDetector(
                      onTap:(){
                        onTap();
                      },
                      child: Image.asset(
                      "assets/icons/delete.png",
                      color: Colors.red,
                    ),
                  ),
              ],
            )
          ],
        ));
  }
}
