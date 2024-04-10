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

import '../bloc/logic_bloc/meeting_bloc.dart';
import '../bloc/state/meeting_state.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/TopBarWidget.dart';

class BuyTicketsPage extends StatefulWidget {
  const BuyTicketsPage({Key? key}) : super(key: key);

  @override
  BuyTicketsState createState() => BuyTicketsState();
}

class BuyTicketsState extends State<BuyTicketsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool isLogin = false;
  List<Map<String, dynamic>> retrievedStudents = [];
  String studentName = "";
  final meetingBloc = MeetingBloc();
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
          child: BlocBuilder<MeetingBloc, MeetingState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return loaderBar(context, mq);
              } else if (state is GetOfficeSlotState) {
                return buildHomeContainer(context, mq);
              } else if (state is FailureState) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
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
    );
  }

  Widget loaderBar(BuildContext context, Size mq) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: boxImageDashboardBgDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            decoration: kButtonBgDecoration,
            child: TopBarWidget(
              onTapLeft: () {},
              onTapRight: () {},
              leftIcon: 'assets/icons/menu.png',
              rightIcon: 'assets/icons/user.png',
              title: "Home",
              rightVisibility: true,
              leftVisibility: true,
              bottomTextVisibility: false,
              subTitle: '',
              screen: 'home',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 20,
              top: 82,
              left: 16,
            ),
            child: Stack(
              children: [
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
                Text.rich(
                  textAlign: TextAlign.left,
                  TextSpan(
                    text: "Welcome, ",
                    style: textStyle(Colors.black, 14, 0, FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                        text: studentName,
                        style: textStyle(appBaseColor, 14, 0, FontWeight.w500),
                      ),
                      // can add more TextSpans here...
                    ],
                  ),
                ),
                20.height,
                buildContestContainer(context, mq),
              ],
            ),
          ),
        ],
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
              child: const Text("Buy Tickets")),
         Container(
         margin: const EdgeInsets.only(top: 50),
         child:  ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              buildContestContainer(context, mq),
            ],
          ),)
        ],
      ),
    );
  }

  Widget buildContestContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Quick Buy Tickets",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              10.height,
              CommonTextField(
                controller: _emailText,
                hintText: "Enter Number of tickets",
                text: "",
                isFocused: false,
                textColor: Colors.black,
                focus: _emailFocus,
                textSize: 16,
                weight: FontWeight.w400,
                hintColor: Colors.black26,
                error: false,
                wrongError: false,
                decoration: kEditTextDecoration,
                padding: 0,
              ),
              15.height,
              const Center(
                  child: Text("OR",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, color: Colors.white))),
              15.height,
              const Text("Choose your tickets",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              15.height,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 5,
                      child: Column(
                        children: [
                          const Text("Tickets",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                          Container(
                            height: 200,
                            color: kCircleColor,
                          )
                        ],
                      )),
                  Container(
                    width: 1,
                    color: Colors.grey,
                  ),
                  const Flexible(
                      flex: 3,
                      child: Column(
                        children: [
                          Text("Selected tickets",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white)),
                        ],
                      )),
                ],
              ),
              40.height,
              Container(
                margin: const EdgeInsets.only(left: 50, right: 50),
                decoration: kButtonBoxDecorationEmpty,
                height: 50,
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      Future.delayed(Duration.zero, () {
                        context.go(Routes.mainHome);
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
                          child: Text("Proceed",
                              style: textStyle(
                                  Colors.white, 12, 0.5, FontWeight.w400)),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
