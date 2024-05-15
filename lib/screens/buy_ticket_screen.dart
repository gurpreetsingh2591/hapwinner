import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/event/tickets_event.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/utils/toast.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/logic_bloc/buy_ticket_bloc.dart';
import '../bloc/state/common_state.dart';
import '../model/TicketNumbersResponse.dart';
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
  bool dataLoad = false;
  List<Map<String, dynamic>> retrievedStudents = [];
  String studentName = "";
  String token = "";
  final buyTicketBloc = BuyTicketBloc();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  List<String> ticketNumbers = [];
  List<int> selectedTicketNumbers = [];
  List<String> selectedTickets = [];
  List<String> noOfTickets = [];

  // Initially showing the first 10 items
  List<String> visibleTickets = [];
  int itemsPerPage = 10;
  int currentPage = 1;

  // Current selected value
  String? _selectedItem;

  late Timer _timer;
  int _seconds = 0;

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
    buyTicketBloc.add(GetTicketListData(token: token));

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (dataLoad) {
        _loadMoreTickets();
        _timer.cancel();
      }
    });
    /* Future.delayed(const Duration(seconds: 4), () {

    });*/
  }

  void _loadMoreTickets() {
    final newTickets = ticketNumbers
        .skip((currentPage - 1) * itemsPerPage)
        .take(itemsPerPage)
        .toList();
    setState(() {
      visibleTickets.addAll(newTickets);
      currentPage++;
    });
  }

  getTickets(dynamic ticketResponse) {
    TicketNumbersResponse response =
        TicketNumbersResponse.fromJson(ticketResponse);

    ticketNumbers.addAll(response.ticketNumbers);
    dataLoad=true;
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

  Widget ticketItem(BuildContext context, String ticket, int index) {
    return InkWell(
        onTap: () {
          setState(() {
            if (selectedTicketNumbers.contains(index)) {
              selectedTicketNumbers.remove(index);
            } else {
              selectedTicketNumbers.add(index);
            }
          });
        },
        child: Container(
            decoration: selectedTicketNumbers.isNotEmpty
                ? selectedTicketNumbers.contains(index)
                    ? kSelectedTicketDecoration
                    : kTicketDecoration
                : kTicketDecoration,
            alignment: Alignment.center,
            height: 30,
            child: Text(
              ticket,
              style: textStyle(Colors.white, 12, 0, FontWeight.normal),
            )));
  }

  Widget buildContestContainer(BuildContext context, Size mq) {
    final dropDownState = Provider.of<DropDownState>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quick Buy Tickets",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          20.height,
          Text(
            "How many ticket to Buy?",
            style: textStyle(Colors.white, 12, 0, FontWeight.normal),
          ),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: DropdownButton<String>(
                  value: dropDownState.selectedItem,
                  // Current selected value
                  dropdownColor: Colors.black,
                  hint: Text(
                    'Select count',
                    style: textStyle(Colors.white, 14, 0, FontWeight.normal),
                  ),
                  items: dropdownItems.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style:
                            textStyle(Colors.white, 14, 0, FontWeight.normal),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Update the selected item when an option is selected
                    dropDownState.selectItem(newValue!);
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: kButtonBoxDecorationEmpty,
                  height: 30,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      noOfTickets.clear();
                      if (dropDownState.selectedItem != 'Select count') {
                        for (int i = 0;
                            i < int.parse(dropDownState.selectedItem!);
                            i++) {
                          noOfTickets.add(ticketNumbers[i]);
                        }

                        Future.delayed(Duration.zero, () {
                          if (kDebugMode) {
                            print("ticketlist--$noOfTickets");
                          }
                          String listJson = jsonEncode(noOfTickets);
                          context.pushNamed('myCart', queryParameters: {
                            'list': listJson,
                            'lotteryId': '1',
                          });

                          //context.push(Routes.myCart);
                        });
                      } else {
                        toast('Please select minimum one ticket', false);
                      }
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
                    ),
                  ),
                ),
              ),
            ],
          ),
          25.height,
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "OR",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Container(
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                )
              ]),
          15.height,
          Text("Choose your tickets",
              style: textStyle(Colors.white, 22, 0, FontWeight.normal)),
          15.height,
          Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: visibleTickets.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      color: appBaseColor,
                      child:
                          //BuyTicketItemWidget(ticketNo: '453654756543', closeIconVisibility: true, onTap: () {  },));
                          ticketItem(context, visibleTickets[index].toString(),
                              index));
                  // TicketItemWidget(  name: tickets[index].toString(), closeIconVisibility: false, onTap: () {  },));
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 4 / 1),
              ),
              if (visibleTickets.length <
                  ticketNumbers.length) // Show Load More if there's more data
                Container(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: _loadMoreTickets,
                    child: Text(
                      'Load More',
                      style: textStyle(Colors.white, 14, 0, FontWeight.w500),
                    ),
                  ),
                ),
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
                  selectedTickets.clear();
                  if (selectedTicketNumbers.isNotEmpty) {
                    for (int i = 0; i < visibleTickets.length; i++) {
                      for (int k = 0; k < selectedTicketNumbers.length; k++) {
                        if (i == (selectedTicketNumbers[k])) {
                          selectedTickets.add(visibleTickets[i].toString());
                        }
                      }
                    }
                    Future.delayed(Duration.zero, () {
                      if (kDebugMode) {
                        print("ticketlist--$selectedTickets");
                      }
                      String listJson = jsonEncode(selectedTickets);

                      context.pushNamed('myCart', queryParameters: {
                        'list': listJson,
                        'lotteryId': '1',
                      });

                      //context.push(Routes.myCart);
                    });
                  } else {
                    toast(
                        "Please select at least one ticket to preoceed", false);
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
                      child: Text("Proceed".allInCaps,
                          style:
                              textStyle(Colors.white, 14, 0, FontWeight.w400)),
                    ),
                    selectedTicketNumbers.isNotEmpty
                        ? Flexible(
                            child: Text(" (${selectedTicketNumbers.length})",
                                style: textStyle(
                                    Colors.white, 14, 0.5, FontWeight.w400)),
                          )
                        : const SizedBox()
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
