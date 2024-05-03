import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import '../utils/constant.dart';
import 'TicketItemWidget.dart';
import 'TopBarWidget.dart';

class ProfilePageWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ProfilePageWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: kTopBarDecoration,
        constraints: const BoxConstraints.expand(),
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 60,
                alignment: Alignment.center,
                decoration: kTopBarDecoration,
                child: TopBarWidget(
                  onTapLeft: () {},
                  leftIcon: 'assets/back_arrow.png',
                  title: 'Profile',
                  leftVisibility: false,
                  screen: 'buy_ticket',
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personal Details",
                            style:
                            textStyle(Colors.white, 22, 0, FontWeight.w500),
                          ),
                          const Icon(
                            Icons.edit,
                            size: 18,
                          ),
                        ]),
                    20.height,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name  :",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                          10.width,
                          Text(
                            "John",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                        ]),
                    5.height,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date of birth  :",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                          10.width,
                          Text(
                            "15-04-1987",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                        ]),
                    5.height,

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email  :",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                          10.width,
                          Text(
                            "john@yopmail.com",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                        ]),
                    5.height,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Phone  :",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                          10.width,
                          Text(
                            "+167767777",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                        ]),
                    5.height,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Address  :",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                          10.width,
                          Text(
                            "8198 Fieldstone, WI 54601",
                            style:
                            textStyle(Colors.white, 16, 0, FontWeight.w400),
                          ),
                        ]),
                    15.height,
                    const Divider(thickness: 1,color: Colors.white,),

                    15.height,
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Change Password",
                            style:
                            textStyle(Colors.white, 22, 0, FontWeight.w500),
                          ),
                          const Icon(
                            Icons.edit,
                            size: 18,
                          ),
                        ]),
                    15.height,
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
