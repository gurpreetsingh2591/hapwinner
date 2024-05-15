import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/event/tickets_event.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/utils/toast.dart';
import 'package:hap_winner_project/widgets/CommonTextField.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../app/router.dart';

import '../bloc/logic_bloc/buy_ticket_bloc.dart';
import '../bloc/state/common_state.dart';
import '../model/TicketNumbersResponse.dart';
import '../widgets/BottomButtonWidget.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/TopBarWidget.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  @override
  ThankYouPageState createState() => ThankYouPageState();
}

class ThankYouPageState extends State<ThankYouPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool isLogin = false;
  List<Map<String, dynamic>> retrievedStudents = [];
  String studentName = "";
  String token = "";
  final buyTicketBloc = BuyTicketBloc();

  @override
  void initState() {
    super.initState();

    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });

    setState(() {
      studentName = SharedPrefs().getUserFullName().toString();
      token = SharedPrefs().getUserToken().toString();
    });
  }

  Future<void> initializePreference() async {
    SharedPrefs.init(await SharedPreferences.getInstance());
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => buyTicketBloc,
      child: Scaffold(
        key: _scaffoldKey,
        body: ColoredSafeArea(
          child: BlocBuilder<BuyTicketBloc, CommonState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return buildHomeContainer(context, mq, true);
              } else if (state is SuccessState) {
                return buildHomeContainer(context, mq, false);
              } else if (state is FailureState) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }
              return buildHomeContainer(context, mq, false);
            },
          ),
        ),
      ),
    );
  }

  Widget buildHomeContainer(BuildContext context, Size mq, bool loading) {
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
                Future.delayed(Duration.zero, () {
                  context.go(Routes.mainHome);
                });
              },
              leftIcon: 'assets/back_arrow.png',
              title: 'Thank You',
              leftVisibility: true,
              screen: 'thank you',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                buildContestContainer(context, mq),
              ],
            ),
          ),
          Visibility(
            visible: loading,
            child: Container(
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
          )
        ],
      ),
    );
  }

  Widget buildContestContainer(BuildContext context, Size mq) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          50.height,
          const Text(
            "YOUR TICKET HAS BEEN BOOKED!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          20.height,
          Image.asset(
            "assets/thank_you.gif",
            scale: 3,
          ),
          20.height,
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
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text("GoTo Home".allInCaps,
                          style:
                              textStyle(Colors.white, 14, 0, FontWeight.w400)),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class DropDownState with ChangeNotifier {
  String? _selectedItem;

  String? get selectedItem => _selectedItem;

  void selectItem(String newValue) {
    _selectedItem = newValue;
    notifyListeners();
  }
}
