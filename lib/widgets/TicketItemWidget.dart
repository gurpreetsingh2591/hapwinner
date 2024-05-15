import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../utils/constant.dart';

class TicketItemWidget extends StatelessWidget {
  final String name;
  final String ticket;
  final VoidCallback onTap;

  const TicketItemWidget({
    Key? key,
    required this.name,
    required this.onTap,
    required this.ticket,
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                          Flexible(child: Text(name.allInCaps)),
                        ]),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          ticket,
                          style:
                              textStyle(Colors.white, 18, 0, FontWeight.normal),
                        )),
                  ),
                ])));
  }
}
