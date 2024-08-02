import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../data/api/api_constants.dart';
import '../model/MyWinsModel.dart';
import '../model/PreviousMonthWinner.dart';
import '../model/my_tickets/UserContestTicket.dart';
import '../utils/constant.dart';
import 'TicketItemWidget.dart';

class MyWinTicketsWidget extends StatelessWidget {
  final BoxDecoration decoration;
  final VoidCallback onTap;
  final MyWinTicket list;

  const MyWinTicketsWidget({
    Key? key,
    required this.onTap,
    required this.decoration,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: decoration,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Lottery :',
                    textAlign: TextAlign.left,
                    style: textStyle(Colors.white, 18, 0, FontWeight.w400),
                  ),
                ),
                10.width,
                Flexible(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      list.lottery.lotteryName,
                      textAlign: TextAlign.center,
                      style: textStyle(Colors.white, 18, 0, FontWeight.w400),
                    ),
                  ),
                )
              ]),
          10.height,
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Ticket Numbers :',
                    textAlign: TextAlign.start,
                    style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                  ),
                ),
                10.width,
                Flexible(
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      list.ticketId.toString(),
                      textAlign: TextAlign.left,
                      style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                    ),
                  ),
                ),
              ]),
          15.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'Amount :',
                textAlign: TextAlign.center,
                style: textStyle(Colors.white, 18, 0, FontWeight.w500),
              ),
            ),
            10.width,
            Flexible(
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  list.lottery.estimatedLotteryAmount,
                  textAlign: TextAlign.center,
                  style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                ),
              ),
            )
          ]),
          15.height,

/*          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Purchase Date :',
                    textAlign: TextAlign.center,
                    style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                  ),
                ),
                10.width,
                Flexible(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        list.tickets[0].purchaseDate,
                        textAlign: TextAlign.center,
                        style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                      ),
                    )),
              ])*/
          // 15.height,
        ],
      ),
    );
  }
}
