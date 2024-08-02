import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/logic_bloc/home_bloc.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:intl/intl.dart';

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

class ContestDetailPage extends StatefulWidget {
  const ContestDetailPage({Key? key}) : super(key: key);

  @override
  ContestDetailState createState() => ContestDetailState();
}

class ContestDetailState extends State<ContestDetailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLogin = false;
  bool isLoader = false;
  String token = "";
  final homeBloc = HomeBloc();
  List<UserContestTicket> myTicketList = [];

  // Current selected value
  String? _selectedItem;
  String lotteryHeading = "";
  String lotteryName = "";
  String bannerImage = "";
  String previousBannerImage = "";
  String lotteryPrice = "";
  String description = "";
  String maxLottery = "";
  String sold = "";
  String lotteryEndDate = "2024-05-30T00:00:00";
  late Timer _timer;
  String month = "";
  List<String> imageUrls = [];

  Duration _difference = Duration.zero;

  @override
  void initState() {
    super.initState();
    _timer =
        Timer.periodic(Duration(seconds: 1), (_) => _calculateDifference());
    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });

    setState(() {
      token = SharedPrefs().getUserToken().toString();
    });
    homeBloc.add(GetContestDetailPressed(token: token));
    var now = DateTime.now();
    var formatter = DateFormat('MMM');
    month = formatter.format(now);

    _calculateDifference();
  }

  void _calculateDifference() {
    final DateTime now = DateTime.now();
    DateTime dateTime = DateTime.parse(lotteryEndDate);

    //final DateTime endDate = DateTime(dateTime);

    setState(() {
      _difference = dateTime.difference(now);
    });
  }

  getDetail(dynamic response) {

    if (response != "") {
      imageUrls.clear();
      var lotteryData = LotteryData.fromJson(response);
      lotteryHeading = lotteryData.data.lotteries.lotteryHeading;
      lotteryName = lotteryData.data.lotteries.lotteryName;
      bannerImage = lotteryData.data.lotteries.bannerImage;
      lotteryPrice = lotteryData.data.ticketPrice.toString();
      maxLottery = lotteryData.data.lotteries.maxTickets.toString();
      sold = lotteryData.data.ticketTotalNumber.totalNumbers.toString();
      lotteryEndDate = lotteryData.data.lotteries.resultDate.toString();
      description = lotteryData.data.lotteries.lotteryPrizeDescription.toString();

      imageUrls = lotteryData.data.lotteries.contestImages.toString().split(',');
      imageUrls.add(bannerImage);


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
              title: 'Contest Detail',
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
    int remainingDays = _difference.inDays;
    int remainingHours = _difference.inHours.remainder(24);
    int remainingMinutes = _difference.inMinutes.remainder(60);
    int remainingSeconds = _difference.inSeconds.remainder(60);

    return Container(
      margin: const EdgeInsets.only(top: 30,bottom: 20),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(5),
            decoration: kWinnerDecoration,
              child: Column(children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                "This Contest End In:",
                textAlign: TextAlign.center,
                style: textStyle(Colors.white, 18, 0, FontWeight.w400),
              ),
            ),
            5.height,
            Text(
              "${remainingDays}d : ${remainingHours}h : ${remainingMinutes}m : ${remainingSeconds}s",
              //"15d | 05h | 45m | 34s",
              style: textStyle(Colors.white, 22, 0, FontWeight.w500),
            ),
          ])),
          15.height,
          Container(
            alignment: Alignment.center,
            child: Text(
              lotteryHeading,
              textAlign: TextAlign.center,
              style: textStyle(Colors.yellow, 22, 0, FontWeight.w400),
            ),
          ),
          10.height,
          Container(
            alignment: Alignment.center,
            child: Text(
              lotteryName,
              textAlign: TextAlign.center,
              style: textStyle(Colors.white, 22, 0, FontWeight.w500),
            ),
          ),
          15.height,
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 16/9, // Adjust as needed
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: false,
            ),
            items: imageUrls.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(

                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Image.network(
                      ApiConstants.baseUrlAssets +imageUrl,
                      fit: BoxFit.contain,

                    ),
                  );
                },
              );
            }).toList(),
          ),
/*          Align(
              alignment: Alignment.topCenter,
              child: Image.network(
                ApiConstants.baseUrlAssets + bannerImage,
                scale: 2.5,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                },
              ))*/
          15.height,
          Container(
            alignment: Alignment.center,
            child: Text(
              "Rs.${lotteryPrice} per ticket",
              textAlign: TextAlign.center,
              style: textStyle(Colors.white, 22, 0, FontWeight.w500),
            ),
          ),
          15.height,
          Container(
            alignment: Alignment.center,
            child: Text(
              "This competition has a maximum of $maxLottery entries.",
              textAlign: TextAlign.center,
              style: textStyle(Colors.white, 16, 0, FontWeight.w500),
            ),
          ),
          15.height,
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: kBgBorderDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Tickets Sold :",
                    textAlign: TextAlign.center,
                    style: textStyle(Colors.white, 22, 0, FontWeight.w500),
                  ),
                ),
                15.width,
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "$sold / $maxLottery",
                    textAlign: TextAlign.center,
                    style: textStyle(Colors.white, 16, 0, FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          30.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Rs. $lotteryPrice",
                  textAlign: TextAlign.center,
                  style: textStyle(Colors.white, 26, 0, FontWeight.w500),
                ),
              ),
              5.width,
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Per Ticket",
                  textAlign: TextAlign.center,
                  style: textStyle(Colors.white54, 16, 0, FontWeight.w500),
                ),
              ),
            ],
          ),
          15.height,
          Container(
              width: 200,
              decoration: kButtonBoxDecorationEmpty,
              height: 40,
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
                child: Text("Buy Tickets".allInCaps,
                    textAlign: TextAlign.center,
                    style: textStyle(Colors.white, 12, 0, FontWeight.w400)),
              )),
          20.height,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Description:",
              textAlign: TextAlign.left,
              style: textStyle(Colors.white, 22, 0, FontWeight.w500),
            ),
          ),
          10.height,
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              description,
              textAlign: TextAlign.left,
              style: textStyle(Colors.white, 14, 0, FontWeight.w500),
            ),
          ),
          20.height,
        ],
      ),
    );
  }
}
