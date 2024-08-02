import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/logic_bloc/home_bloc.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../app/router.dart';
import '../bloc/event/home_event.dart';
import '../bloc/state/home_state.dart';
import '../data/api/api_constants.dart';
import '../model/contestDetail/LotteryData.dart';
import '../model/my_tickets/UserContestTicket.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/TopBarWidget.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  PrivacyPolicyState createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicyPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLogin = false;
  bool isLoader = false;

  var homeBloc = HomeBloc();

  // Current selected value

  String privacy = "";
  String token = "";

  @override
  void initState() {
    super.initState();

    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });

    setState(() {
      token = SharedPrefs().getUserToken().toString();
    });
    homeBloc.add(GetPrivacyPressed(token: token));
  }

  getDetail(dynamic response) {
    if (response != "") {
      privacy = response['data']['privacyData'].toString();
    }
  }

  Future<void> initializePreference() async {
    SharedPrefs.init(await SharedPreferences.getInstance());
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => homeBloc,
      child: Scaffold(
        key: _scaffoldKey,
        body: ColoredSafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return buildHomeContainer(context, mq, true);
              } else if (state is GetContestDetailState) {
                getDetail(state.response);
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
                Navigator.pop(context);
              },
              leftIcon: 'assets/back_arrow.png',
              title: 'Privacy Policy',
              leftVisibility: true,
              screen: 'contest detail',
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
      margin: const EdgeInsets.only(top: 30, bottom: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                10.height,
                Container(
                  alignment: Alignment.center,
                  child: HtmlWidget(
                    privacy,
                    textStyle: textStyle(Colors.white, 18, 0, FontWeight.normal),

                  ),
                ),
                10.height,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
