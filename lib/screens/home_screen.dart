import 'dart:async';
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../app/router.dart';

import '../bloc/logic_bloc/meeting_bloc.dart';
import '../bloc/state/meeting_state.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/TopBarWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool isLogin = false;
  List<Map<String, dynamic>> retrievedStudents = [];
  String studentName = "";
  final meetingBloc = MeetingBloc();
  final PageController controller = PageController();
  bool index1 = true;
  bool index2 = false;
  bool index3 = false;
  bool index4 = false;

  @override
  void initState() {
    super.initState();

    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });

    setState(() {
      studentName = SharedPrefs().getUserFullName().toString();
    });
    getStudentList();
  }

  getStudentList() async {
    retrievedStudents.clear();

    retrievedStudents = await SharedPrefs().getStudents();

    if (kDebugMode) {
      print(retrievedStudents);
    }
  }

  Future<void> initializePreference() async {
    SharedPrefs.init(await SharedPreferences.getInstance());
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => meetingBloc,
      child: Scaffold(
        key: _scaffoldKey,
        body: PageView(
          controller: controller,
          children: <Widget>[
            Center(
              child: ColoredSafeArea(
                child: BlocBuilder<MeetingBloc, MeetingState>(
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return buildHomeContainer(context, mq);
                    } else if (state is GetOfficeSlotState) {
                      return buildHomeContainer(context, mq);
                    } else if (state is FailureState) {
                      return Center(
                        child: Text('Error: ${state.error}'),
                      );
                    }
                    return LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        if (constraints.maxWidth < 757) {
                          return buildHomeContainer(context, mq);
                        } else {
                          return buildHomeContainer(context, mq);
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            Center(
              child: buildTestimonialContainer(context, mq),
            ),
            Center(
              child: buildWinnerContainer(context, mq),
            ),
            Center(
              child: buildProfileContainer(context, mq),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBar(Size mq) {
    return SizedBox(
        width: mq.width,
        child: Card(
            borderOnForeground: true,
            color: Colors.white,
            elevation: 5,
            shadowColor: Colors.white,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          index1 = true;
                          index2 = false;
                          index3 = false;
                          index4 = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(children: [
                          Image.asset(
                            index1
                                ? "assets/home_color.png"
                                : "assets/home_simple.png",
                            scale: 4,
                          ),
                          5.height,
                          Text(
                            "Home",
                            style: textStyle(
                                index1
                                    ? kSelectedTextColor
                                    : kUnselectedTextColor,
                                16,
                                0,
                                FontWeight.normal),
                          )
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index1 = false;
                          index2 = true;
                          index3 = false;
                          index4 = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(children: [
                          Image.asset(
                            index2
                                ? "assets/winner_color.png"
                                : "assets/winner_simple.png",
                            scale: 4,
                          ),
                          5.height,
                          Text(
                            "Winners",
                            style: textStyle(
                                index2
                                    ? kSelectedTextColor
                                    : kUnselectedTextColor,
                                16,
                                0,
                                FontWeight.normal),
                          )
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index1 = false;
                          index2 = false;
                          index3 = true;
                          index4 = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(children: [
                          Image.asset(
                            index3
                                ? "assets/testimonial_color.png"
                                : "assets/testimonial_simple.png",
                            scale: 4,
                          ),
                          5.height,
                          Text(
                            "Testimonials",
                            style: textStyle(
                                index3
                                    ? kSelectedTextColor
                                    : kUnselectedTextColor,
                                16,
                                0,
                                FontWeight.normal),
                          )
                        ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index1 = false;
                          index2 = false;
                          index3 = false;
                          index4 = true;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(children: [
                          Image.asset(
                            index4
                                ? "assets/profile_color.png"
                                : "assets/profile.png",
                            scale: 4,
                          ),
                          5.height,
                          Text(
                            "Profile",
                            style: textStyle(
                                index4
                                    ? kSelectedTextColor
                                    : kUnselectedTextColor,
                                16,
                                0,
                                FontWeight.normal),
                          )
                        ]),
                      ),
                    )
                  ],
                ))));
  }

  Widget buildHomeContainer(BuildContext context, Size mq) {
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  width: mq.width,
                  alignment: Alignment.center,
                  decoration: kTopBarDecoration,
                  child: const Text("Home")),
              ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  buildContestContainer(context, mq),
                ],
              ),
            ],
          ),
          Container(
            height: 500,
            margin: const EdgeInsets.only(bottom: 20, top: 80),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                    child: SpinKitFadingCircle(
                  color: kLightGray,
                  size: 80.0,
                ))
              ],
            ),
          ),
          Positioned(bottom: 0, child: bottomBar(mq)),
        ]));
  }

  Widget buildWinnerContainer(BuildContext context, Size mq) {
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  width: mq.width,
                  alignment: Alignment.center,
                  decoration: kTopBarDecoration,
                  child: const Text("Winners")),
              ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  buildContestContainer(context, mq),
                ],
              ),
            ],
          ),
          Positioned(bottom: 0, child: bottomBar(mq)),
        ]));
  }

  Widget buildTestimonialContainer(BuildContext context, Size mq) {
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  width: mq.width,
                  alignment: Alignment.center,
                  decoration: kTopBarDecoration,
                  child: const Text("Testimonials")),
              ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  buildContestContainer(context, mq),
                ],
              ),
            ],
          ),
          Positioned(bottom: 0, child: bottomBar(mq)),
        ]));
  }

  Widget buildProfileContainer(BuildContext context, Size mq) {
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 50,
                  width: mq.width,
                  alignment: Alignment.center,
                  decoration: kTopBarDecoration,
                  child: const Text("Profile")),
              ListView(
                shrinkWrap: true,
                primary: false,
                children: [
                  buildContestContainer(context, mq),
                ],
              ),
            ],
          ),
          Positioned(bottom: 0, child: bottomBar(mq)),
        ]));
  }

  Widget buildContestContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 150,
          width: mq.width,
          color: kBaseColor,
        ),
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: kButtonBgDecoration,
          child: Column(
            children: [
              const Text(
                "Contest Draw starts on",
                style: TextStyle(color: Colors.white),
              ),
              10.height,
              const Text(
                "15d | 05h | 45m | 34s",
                style: TextStyle(color: Colors.white),
              ),
              15.height,
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                decoration: kButtonBoxDecorationEmpty,
                height: 30,
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      if (kDebugMode) {
                        print("object");
                      }
                      Future.delayed(Duration.zero, () {
                        context.push(Routes.buyTickets);
                      });
                      //dialogShown = false;
                      //login(_emailText.text.trim().toString(), _passwordText.text.trim().toString());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text("Buy Tickets",
                              style: textStyle(
                                  Colors.white, 12, 0.5, FontWeight.w400)),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.all(20),
          decoration: kButtonBgDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "How it work",
                style: TextStyle(color: Colors.white),
              ),
              10.height,
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      decoration: circleBlueBox,
                      child: const Text("1", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  10.width,
                  const Flexible(
                      flex: 8,
                      child: Text("Buy Contest Tickets",
                          style: TextStyle(fontSize: 12))),
                ],
              ),
              10.height,
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      decoration: circleBlueBox,
                      child: const Text("2", style: TextStyle(fontSize: 12)),
                    ),
                  ),
                  10.width,
                  const Flexible(
                      flex: 8,
                      child: Text("Wait for contest draw",
                          style: TextStyle(fontSize: 12))),
                ],
              ),
              10.height,
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 25,
                      width: 25,
                      alignment: Alignment.center,
                      decoration: circleBlueBox,
                      child: const Text(
                        "3",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  10.width,
                  const Flexible(
                      flex: 8,
                      child: Text("Get a chance to win",
                          style: TextStyle(fontSize: 12))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
