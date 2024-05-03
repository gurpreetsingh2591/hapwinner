import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/widgets/CommonTextField.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../app/router.dart';

import '../bloc/logic_bloc/home_bloc.dart';
import '../bloc/state/meeting_state.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/TopBarWidget.dart';

class UpComingDrawPage extends StatefulWidget {
  const UpComingDrawPage({Key? key}) : super(key: key);

  @override
  UpComingDrawState createState() => UpComingDrawState();
}

class UpComingDrawState extends State<UpComingDrawPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool isLogin = false;
  List<Map<String, dynamic>> retrievedStudents = [];
  String studentName = "";
  final meetingBloc = HomeBloc();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final FocusNode _emailFocus = FocusNode();

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
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width *
              0.75, // 75% of screen will be occupied
          child: Drawer(
            backgroundColor: Colors.white,
            child: DrawerWidget(
              contexts: context,
            ),
          ), //Drawer
        ),
        body: ColoredSafeArea(
          child: BlocBuilder<HomeBloc, MeetingState>(
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
              return buildHomeContainer(context, mq);
            },
          ),
        ),
      ),
    );
  }

  Widget buildHomeContainer(BuildContext context, Size mq) {
    return Container(
      decoration: kTopBarDecoration,
      constraints: const BoxConstraints.expand(),
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 50,
              width: mq.width,
              alignment: Alignment.center,
              decoration: kTopBarDecoration,
              child: TopBarWidget(
                onTapLeft: () {
                  Navigator.pop(context);
                },
                leftIcon: 'assets/back_arrow.png',
                title: 'Upcoming Contest',
                leftVisibility: true,
                screen: 'buy_ticket',
              ),),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                buildComingDrawContainer(context, mq),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildComingDrawContainer(BuildContext context, Size mq) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return upcomingContestItem(context, tickets[index].toString());
        },
      ),
    );
  }

  Widget upcomingContestItem(BuildContext context, String ticket) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(20),
        decoration: kAllCornerBoxDecoration,
        child: Column(children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: circleGreenBox,
                  child: Image.asset(
                    "assets/like.png",
                    scale: 6,
                  ),
                ),
                Image.asset(
                  "assets/balls.png",
                  scale: 4,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "Contest No.\nEH4",
                    textAlign: TextAlign.center,
                  ),
                )
              ]),
          10.height,
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  const Icon(Icons.price_change),
                  5.width,
                  const Text("Ticket price",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ]),
                const Text("\$4.90",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ]),
              10.height,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  const Icon(Icons.lock_clock),
                  5.width,
                  const Text("Remaining Days",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ]),
                const Text("5d",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ]),
              10.height,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  const Icon(Icons.note),
                  5.width,
                  const Text("Tickets Remaining",
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ]),
                const Text("98889",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ])
            ],
          ),
        ]));
  }
}
