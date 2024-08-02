import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/event/tickets_event.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/utils/toast.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/logic_bloc/buy_ticket_bloc.dart';
import '../bloc/logic_bloc/my_ticket_bloc.dart';
import '../bloc/state/common_state.dart';
import '../model/MyWinsModel.dart';
import '../model/TicketNumbersResponse.dart';
import '../model/my_tickets/UserContestTicket.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/MyTicketsWidget.dart';
import '../widgets/MyWinTicketsWidget.dart';
import '../widgets/TopBarWidget.dart';

class MyTicketsWinsPage extends StatefulWidget {
  const MyTicketsWinsPage({Key? key}) : super(key: key);

  @override
  MyTicketsWinState createState() => MyTicketsWinState();
}

class MyTicketsWinState extends State<MyTicketsWinsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLogin = false;
  bool isLoader = false;
  String token = "";
  final buyTicketBloc = BuyTicketBloc();

  List<MyWinTicket> myTicketList = [];

  // Current selected value
  String? _selectedItem;

  @override
  void initState() {
    super.initState();

    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });

    setState(() {
      token = SharedPrefs().getUserToken().toString();
    });
    buyTicketBloc.add(GetMyWinTicketListData(token: token));
  }

  getTickets(dynamic ticketResponse) {
    var ticketList = ticketResponse['data']['userwins'];

    if (ticketList != "") {
      myTicketList = (ticketList as List)
          .map((item) => MyWinTicket.fromJson(item))
          .toList();
    }
    isLoader=true;
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
                getTickets(state.response);
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
              title: 'My Wins',
              leftVisibility: true,
              screen: 'buy_ticket',
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
      child: myTicketList.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: myTicketList.length,
              itemBuilder: (BuildContext context, int index) {
                return MyWinTicketsWidget(
                  onTap: () {},
                  decoration: kGradientBoxDecoration,
                  list: myTicketList[index],
                );
              },
            )
          : isLoader?Container(
              height: 500,
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  "Data Not found",
                  style: textStyle(Colors.white, 18, 0, FontWeight.normal),
                ),
              )):SizedBox(),
    );
  }
}
