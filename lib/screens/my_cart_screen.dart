import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/event/tickets_event.dart';
import 'package:hap_winner_project/bloc/logic_bloc/buy_ticket_bloc.dart';
import 'package:hap_winner_project/bloc/state/common_state.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../app/router.dart';

import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/TopBarWidget.dart';

class MyCartPage extends StatefulWidget {
  final String ticketList;
  final String lotteryId;

  const MyCartPage(
      {Key? key, required this.ticketList, required this.lotteryId})
      : super(key: key);

  @override
  MyCartState createState() => MyCartState();
}

class MyCartState extends State<MyCartPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool isLogin = false;
  List<String> selectedTicket = [];
  String userToken = "";
  final buyTicketBloc = BuyTicketBloc();

  @override
  void initState() {
    super.initState();

    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });

    setState(() {
      userToken = SharedPrefs().getUserToken().toString();
    });
    getTicketList();
  }

  getBuyTicketData() {
    Future.delayed(Duration.zero, () {
      context.go(Routes.thankYouPage);
    });
  }

  getTicketList() async {
    selectedTicket.clear();
    if (widget.ticketList != "") {
      selectedTicket = List<String>.from(jsonDecode(widget.ticketList));
    }
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
                getBuyTicketData();
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

  Widget buildHomeContainer(BuildContext context, Size mq, bool isLoading) {
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
              title: 'My Cart',
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
              visible: isLoading,
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
              ))
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text("Your tickets",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                InkWell(
                    onTap: () {
                      setState(() {
                        selectedTicket.clear();
                      });
                    },
                    child: const Text("Clear all",
                        style: TextStyle(fontSize: 16, color: Colors.white))),
              ]),
              15.height,
              Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: selectedTicket.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: appBaseColor,
                          child: ticketItem(context,
                              selectedTicket[index].toString(), index));
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 2.8 / 1),
                  ),
                ],
              ),
              30.height,
              Column(
                children: [
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Single Ticket price",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        Text("Rs 100",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      ]),
                  10.height,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Total Ticket price\n(${selectedTicket.length}*100)",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                        Text("Rs ${selectedTicket.length * 100}",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                      ])
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
                      if (selectedTicket.isNotEmpty) {
                        String tickets = selectedTicket.join(', ');
                        buyTicketBloc.add(GetBuyTicketsData(
                            userId: SharedPrefs().getStudentId().toString(),
                            lotteryId: widget.lotteryId,
                            ticketNumber: tickets,
                            paymentStatus: 'paid',
                            countryId: '19',
                            amount: (selectedTicket.length * 100).toString(),
                            transactionType: 'card',
                            transactionId: '56547547464556',
                            token: SharedPrefs().getUserToken().toString()));
                      }
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
                          child: Text("Buy Tickets".allInCaps,
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

  Widget ticketItem(BuildContext context, String ticket, int index) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: kTicketDecoration,
            alignment: Alignment.center,
            child: Text(
              ticket,
              style: textStyle(Colors.white, 12, 0, FontWeight.normal),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              selectedTicket.removeAt(index);
            });
          },
          child: Container(
            alignment: Alignment.topRight,
            child: const Icon(
              Icons.close_rounded,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
