import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../data/api/api_constants.dart';
import '../model/PreviousMonthWinner.dart';
import '../utils/constant.dart';
import 'TicketItemWidget.dart';

class WinnerWidget extends StatelessWidget {
  final BoxDecoration decoration;
  final VoidCallback onTap;
  final List<PreviousMonthWinner> list;

  const WinnerWidget({
    Key? key,
    required this.onTap,
    required this.decoration, required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Column(children: [
          Container(
            alignment: Alignment.center,
            child: Text(
             list[0].lotteryDetail.heading,
              textAlign: TextAlign.center,
              style: textStyle(Colors.white, 18, 0, FontWeight.w400),
            ),
          ),
          10.height,
          Container(
            alignment: Alignment.center,
            child: Text(
              list[0].lotteryDetail.name,
              textAlign: TextAlign.center,
              style: textStyle(Colors.white, 22, 0, FontWeight.w500),
            ),
          ),
          15.height,

            Align(
                    alignment: Alignment.topCenter,
                    child:  Image.network(
                      ApiConstants.baseUrlAssets+list[0].lotteryDetail.bannerImage,
                      scale:2.5,fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context,
                          Widget child,

                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              child: CircularProgressIndicator(
                                value: loadingProgress
                                    .expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress
                                        .expectedTotalBytes!
                                    : null,
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                              ),),
                        );
                      },
                    )
                  ),
          15.height,
          Container(
            alignment: Alignment.center,
            child: Text(
              "Previous Month Contest Winners",
              textAlign: TextAlign.center,
              style: textStyle(Colors.green, 22, 0, FontWeight.w500),
            ),
          ),
         15.height,
         Container(
           padding: const EdgeInsets.symmetric(vertical: 10),
           decoration: kDialogBgDecoration,
           child:
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: const EdgeInsets.only(top: 5, right: 10,left: 10,bottom: 5),
                  child: TicketItemWidget(
                    name: list[index].user.name.toString(),
                    onTap: () {

                    }, ticket: list[index].ticketId.toString(),
                  ));
            },
          ),
          ),

        ]));
  }
}
