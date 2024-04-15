import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../utils/constant.dart';
import 'ChildItemWidget.dart';

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
              "Contest Number: EH4",
              textAlign: TextAlign.center,
              style: textStyle(Colors.white, 18, 0, FontWeight.w500),
            ),
          ),
          10.height,
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          15.height,
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Winning Tickets",
              textAlign: TextAlign.center,
              style: textStyle(Colors.white, 18, 0, FontWeight.w500),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            primary: true,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  child: TicketItemWidget(
                    name: tickets[index].toString(),
                    closeIconVisibility: false,
                    onTap: () {},
                  ));
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 4 / 1),
          ),
          10.height,
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          10.height,
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  const Icon(Icons.price_change),
                  5.width,
                  const Text("Contest price",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ]),
                const Text("\$200",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ]),
              10.height,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  const Icon(Icons.punch_clock),
                  5.width,
                  const Text("Draw Date",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ]),
                const Text("Sat 24 April,2024",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ]),
            ],
          ),
        ]));
  }
}
