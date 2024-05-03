import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/widgets/CommonTextField.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../app/router.dart';

import '../bloc/logic_bloc/buy_ticket_bloc.dart';
import '../bloc/state/common_state.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
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
  final buyTicketBloc = BuyTicketBloc();
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
      create: (context) => buyTicketBloc,
      child: Scaffold(
        key: _scaffoldKey,
        body: ColoredSafeArea(
          child: BlocBuilder<BuyTicketBloc, CommonState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return buildHomeContainer(context, mq);
              } else if (state is SuccessState) {
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
              title: 'Buy Tickets',
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
          )
        ],
      ),
    );
  }
  Widget ticketItem(BuildContext context, String ticket) {
    return Container(
        decoration: kTicketDecoration,
        alignment: Alignment.center,
        height: 30,
        child: Text(
          ticket,
          style: textStyle(Colors.white, 12, 0, FontWeight.normal),
        ));
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
                  child: Text("------------ OR -------------",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, color: Colors.white))),
              15.height,
              const Text("Choose your tickets",
                  style: TextStyle(fontSize: 16, color: Colors.white)),
              15.height,
              Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    primary: true,
                    itemCount: tickets.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: appBaseColor,
                          child:
                          //BuyTicketItemWidget(ticketNo: '453654756543', closeIconVisibility: true, onTap: () {  },));
                          ticketItem(context, tickets[index].toString()));
                         // TicketItemWidget(  name: tickets[index].toString(), closeIconVisibility: false, onTap: () {  },));
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 4 / 1),
                  )
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
                        context.push(Routes.myCart);
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
                          child: Text("Proceed".allInCaps,
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
