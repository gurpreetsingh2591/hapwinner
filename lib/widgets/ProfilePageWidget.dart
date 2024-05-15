import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/utils/shared_prefs.dart';
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
                  onTapLeft: () {
                   // scaffoldKey.currentState?.openDrawer();

                  },
                  leftIcon: 'assets/menu.png',
                  title: 'Profile',
                  leftVisibility: false,
                  screen: 'profile',
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
                            SharedPrefs().getUserFullName().toString(),
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
                            "",
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
                              SharedPrefs().getUserEmail().toString(),
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
                            "",
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
                            "1A, sunny enclave, Mohali",
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
