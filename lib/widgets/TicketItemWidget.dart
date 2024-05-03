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
          padding: const EdgeInsets.all(10),
          decoration: kWinnerDecoration,
          alignment: Alignment.center,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image.asset(
                            "assets/first.png",
                            scale: 8,
                          ),
                        )),
                    10.width,
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: Image.asset(
                          "assets/testimonial.png",
                          scale: 7,
                        ),
                      ),
                    ),
                    10.width,
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          name,
                          style:
                              textStyle(Colors.white, 18, 0, FontWeight.normal),
                        ))
                  ],
                ),
                Text("Shushma, Assam".allInCaps),
              ])),
    );
  }
}
