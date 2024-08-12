import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/data/api/api_constants.dart';
import 'package:hap_winner_project/model/TestimonialModel.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/utils/toast.dart';
import 'package:hap_winner_project/widgets/ProfilePageWidget.dart';
import 'package:hap_winner_project/widgets/TestimonialWidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../app/router.dart';

import '../bloc/event/home_event.dart';
import '../bloc/logic_bloc/home_bloc.dart';
import '../bloc/state/home_state.dart';
import '../model/HomeApiResponse.dart';
import '../model/LotteryData.dart';
import '../model/LotteryDetail.dart';
import '../model/PreviousMonthWinner.dart';
import '../widgets/TicketItemWidget.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/TopBarWidget.dart';
import '../widgets/WinnerWidget.dart';

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
  final homeBloc = HomeBloc();
  final PageController controller = PageController();
  bool index1 = true;
  bool index2 = false;
  bool index3 = false;
  bool index4 = false;
  bool switchScreen = false;
  final List<String> _videoUrlList = [];
  final List<String> nameList = [];
  final List<Testimonial> videoList = [];
  List<PreviousMonthWinner> previousMonthWinnerList = [];

  List<YoutubePlayerController> lYTC = [];
  String lotteryHeading = "";
  String lotteryName = "";
  String bannerImage = "";
  String previousBannerImage = "";
  String userAddress = "";
  String lotteryPrice = "";
  Map<String, dynamic> cStates = {};
  String month = "";
  String lotteryEndDate = "2024-05-28T12:00:00";

  late Timer _timer;
  Duration _difference = Duration.zero;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
// Calculate initial difference
    // Update difference every second
    _timer =
        Timer.periodic(Duration(seconds: 1), (_) => _calculateDifference());
    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });

    homeBloc.add(
        GetTestimonialsVideo(token: SharedPrefs().getUserToken().toString()));
    homeBloc.add(GetHomeData(token: SharedPrefs().getUserToken().toString()));
    setState(() {
      studentName = SharedPrefs().getUserFullName().toString();
    });

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

  deleteAccount(dynamic data) {
    if (data['status'] == 401) {
      toast("Account not deleted, Please try again", true);
    } else {
      if (data['status'] == 200) {
        if (!switchScreen) {
          toast("Account deleted successfully", false);
          SharedPrefs().setIsLogin(false);
          SharedPrefs().reset();
          Future.delayed(Duration.zero, () {
            context.go(Routes.signIn);
          });
          switchScreen = true;
        }
      }
    }
  }

  setHomeData(dynamic homaData) {
    // if (kDebugMode) {
    //   print("homaData--$homaData");
    // }

    var lotteryDetail =
        LotteryDetail.fromJson(homaData['data']['lottry_detail']);
    lotteryHeading = lotteryDetail
        .heading; //homaData['data']['lottry_detail']['lottery_heading'];
    lotteryName =
        lotteryDetail.name; //homaData['data']['lottry_detail']['lottery_name'];
    bannerImage = lotteryDetail
        .bannerImage; //homaData['data']['lottry_detail']['lottery_name'];
    lotteryPrice = homaData['data']['lottry_price'].toString();
    lotteryEndDate =
        homaData['data']['lottry_detail']['lottery_end_date'].toString();
    /* var previousMonthWinners = (homaData['data']['privousmonthwinners'] as List)
        .map((item) => PreviousMonthWinner.fromJson(item))
        .toList();*/
    var previousList = homaData['data']['privousmonthwinners'];

    previousMonthWinnerList = (previousList as List)
        .map((item) => PreviousMonthWinner.fromJson(item))
        .toList();
    if (previousMonthWinnerList.isNotEmpty) {
      previousBannerImage =
          previousMonthWinnerList[0].lotteryDetail.bannerImage.toString();
      // userAddress = previousMonthWinnerList[0].lotteryDetail.bannerImage.toString();
    }

    /* for(int i=0;i<previousMonthWinners.length;i++) {
      previousMonthWinnerList.add(previousMonthWinners[i]);
    }*/
    /*try {
      final response = HomeApiResponse<LotteryData>.fromJson(
        homaData,
        (dataJson) => LotteryData.fromJson(dataJson),
      );

      print("Status: ${response.status}");
      print("Message: ${response.message}");
      print("Lottery Price: ${response.data.lotteryPrice}");
    } catch (e) {
      print("Error occurred: $e");
    }*/
  }

  setTestimonialVideoData(dynamic testimonials) {
    _videoUrlList.clear();
    videoList.clear();
    if (kDebugMode) {
      print("object--$testimonials");
    }

    try {
      var testimonialsResponse = TestimonialResponse.fromJson(testimonials);
      int status = testimonialsResponse.status;
      String message = testimonialsResponse.message;
      if (status == 200) {
        videoList.addAll(testimonialsResponse.testimonials);
        _videoUrlList.clear();
        for (int i = 0; i < videoList.length; i++) {
          _videoUrlList
              .add(videoList[i].videoLink.split("embed/")[1].split("?")[0]);
          nameList.add(videoList[i].title);
        }
        if (kDebugMode) {
          print(_videoUrlList);
        }
        fillYTlists();
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  fillYTlists() {
    for (var element in _videoUrlList) {
      String _id = YoutubePlayer.convertUrlToId(element)!;
      YoutubePlayerController _ytController = YoutubePlayerController(
        initialVideoId: _id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          enableCaption: true,
          captionLanguage: 'en',
        ),
      );

      _ytController.addListener(() {
        print('for $_id got isPlaying state ${_ytController.value.isPlaying}');
        if (cStates[_id] != _ytController.value.isPlaying) {
          if (mounted) {
            setState(() {
              cStates[_id] = _ytController.value.isPlaying;
            });
          }
        }
      });

      lYTC.add(_ytController);
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
            drawer: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.75, // 75% of screen will be occupied
              child: Drawer(
                backgroundColor: Colors.white,
                child: DrawerWidget(
                  contexts: context,
                  homeBloc: homeBloc,
                ),
              ), //Drawer
            ),
            body: Stack(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 80),
                child: PageView(
                  controller: controller,
                  onPageChanged: (num) {
                    setState(() {
                      if (num == 0) {
                        index1 = true;
                        index2 = false;
                        index3 = false;
                        index4 = false;
                      } else if (num == 1) {
                        index1 = false;
                        index2 = true;
                        index3 = false;
                        index4 = false;
                      }
                      if (num == 2) {
                        index1 = false;
                        index2 = false;
                        index3 = true;
                        index4 = false;
                      }
                      if (num == 3) {
                        index1 = false;
                        index2 = false;
                        index3 = false;
                        index4 = true;
                      }
                    });
                  },
                  children: <Widget>[
                    Center(
                      child: ColoredSafeArea(
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return buildHomeContainer(context, mq, true);
                            } else if (state is GetHomeState) {
                              setHomeData(state.response);

                              return buildHomeContainer(context, mq, false);
                            } else if (state is GetAccountDeleteSuccessState) {
                              deleteAccount(state.response);

                              return buildHomeContainer(context, mq, false);
                            } else if (state is GetTestimonialsState) {
                              setTestimonialVideoData(state.response);

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
                    Center(
                      child: ColoredSafeArea(
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return buildWinnerContainer(context, mq, true);
                            } else if (state is GetTestimonialsState) {
                              return buildWinnerContainer(context, mq, false);
                            } else if (state is GetAccountDeleteSuccessState) {
                              deleteAccount(state.response);

                              return buildHomeContainer(context, mq, false);
                            } else if (state is FailureState) {
                              return Center(
                                child: Text('Error: ${state.error}'),
                              );
                            }
                            return buildWinnerContainer(context, mq, false);
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: ColoredSafeArea(
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return buildTestimonialContainer(
                                  context, mq, true);
                            } else if (state is GetTestimonialsState) {
                              setTestimonialVideoData(state.response);

                              return buildTestimonialContainer(
                                  context, mq, false);
                            } else if (state is GetAccountDeleteSuccessState) {
                              deleteAccount(state.response);

                              return buildHomeContainer(context, mq, false);
                            } else if (state is FailureState) {
                              return Center(
                                child: Text('Error: ${state.error}'),
                              );
                            }
                            return buildTestimonialContainer(
                                context, mq, false);
                          },
                        ),
                      ),
                    ),
                    Center(
                      child: ColoredSafeArea(
                        child: BlocBuilder<HomeBloc, HomeState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return buildProfileContainer(context, mq, true);
                            } else if (state is GetTestimonialsState) {
                              return buildProfileContainer(context, mq, false);
                            } else if (state is GetAccountDeleteSuccessState) {
                              deleteAccount(state.response);

                              return buildHomeContainer(context, mq, false);
                            } else if (state is FailureState) {
                              return Center(
                                child: Text('Error: ${state.error}'),
                              );
                            }
                            return buildProfileContainer(context, mq, false);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(bottom: 0, child: bottomBar(mq)),
            ])));
  }

  Widget bottomBar(Size mq) {
    return Container(
        decoration: kBlackButtonBoxDecoration,
        width: mq.width,
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
                      controller.jumpToPage(0);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Image.asset(
                        index1
                            ? "assets/home_color.png"
                            : "assets/home_simple.png",
                        scale: 5,
                      ),
                      5.height,
                      Text(
                        "Home",
                        style: textStyle(
                            index1 ? kSelectedTextColor : kUnselectedTextColor,
                            12,
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
                      controller.jumpToPage(1);
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      Image.asset(
                        index2
                            ? "assets/winner_color.png"
                            : "assets/winner_simple.png",
                        scale: 5,
                      ),
                      5.height,
                      Text(
                        "Winners",
                        style: textStyle(
                            index2 ? kSelectedTextColor : kUnselectedTextColor,
                            12,
                            0,
                            FontWeight.normal),
                      )
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      controller.jumpToPage(2);

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
                        scale: 5,
                      ),
                      5.height,
                      Text(
                        "Testimonials",
                        style: textStyle(
                            index3 ? kSelectedTextColor : kUnselectedTextColor,
                            12,
                            0,
                            FontWeight.normal),
                      )
                    ]),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      controller.jumpToPage(3);
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
                        scale: 5,
                      ),
                      5.height,
                      Text(
                        "Profile",
                        style: textStyle(
                            index4 ? kSelectedTextColor : kUnselectedTextColor,
                            12,
                            0,
                            FontWeight.normal),
                      )
                    ]),
                  ),
                )
              ],
            )));
  }

  ///Home Container
  Widget buildHomeContainer(BuildContext context, Size mq, bool loading) {
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              width: mq.width,
              alignment: Alignment.center,
              decoration: kTopBarDecoration,
              child: TopBarWidget(
                onTapLeft: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                leftIcon: 'assets/menu.png',
                title: 'Home',
                leftVisibility: true,
                screen: 'home',
              )),
          Container(
            margin: const EdgeInsets.only(top: 60),
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
          ),
        ]));
  }

  ///Winner container
  Widget buildWinnerContainer(BuildContext context, Size mq, bool loading) {
    return Container(
        decoration: kTopBarDecoration,
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 60,
                width: mq.width,
                alignment: Alignment.center,
                decoration: kTopBarDecoration,
                child: TopBarWidget(
                  onTapLeft: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  leftIcon: 'assets/menu.png',
                  title: 'Winners',
                  leftVisibility: true,
                  screen: 'buy_ticket',
                )),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 50),
              child: ListView(shrinkWrap: true, primary: false, children: [
                WinnerWidget(
                  onTap: () {},
                  decoration: kAllCornerBoxDecoration,
                  list: previousMonthWinnerList,
                )
              ]),
            ),
          ],
        ));
  }

  ///Testimonial
  Widget buildTestimonialContainer(
      BuildContext context, Size mq, bool loading) {
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            width: mq.width,
            alignment: Alignment.center,
            decoration: kTopBarDecoration,
            child: TopBarWidget(
              onTapLeft: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              leftIcon: 'assets/menu.png',
              title: 'Testimonials',
              leftVisibility: true,
              screen: 'buy_ticket',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: _videoUrlList.length,
              itemBuilder: (BuildContext context, int index) {
                YoutubePlayerController _ytController = lYTC[index];

                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(children: [
                      Container(
                        height: 220.0,
                        decoration: const BoxDecoration(
                          color: Color(0xfff5f5f5),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                          ),
                          child: YoutubePlayer(
                            controller: _ytController,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.lightBlueAccent,
                            bottomActions: [
                              CurrentPosition(),
                              ProgressBar(isExpanded: true),
                              FullScreenButton(),
                            ],
                            onReady: () {
                              print('onReady for $index');
                            },
                            onEnded: (YoutubeMetaData _md) {
                              _ytController.seekTo(const Duration(seconds: 0));
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.9),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                        ),
                        child: Row(children: [
                          Text(
                            nameList[index].toString(),
                            style: textStyle(
                                Colors.white, 18, 0, FontWeight.normal),
                          ),
                        ]),
                      ),
                    ]));
              },
            ),
          ), /*TestimonialWidget(
                    onTap: () {},
                    decoration: kAllCornerBoxDecoration,
                    name: 'Katrine',
                    testimonial:
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                    image: 'assets/testimonial.png',
                  );*/
        ]));
  }

  ///Contest Detail
  Widget buildContestContainer(BuildContext context, Size mq) {
    // Calculate remaining hours, minutes, and seconds
    // Calculate remaining days and hours
    int remainingDays = _difference.inDays;
    int remainingHours = _difference.inHours.remainder(24);
    int remainingMinutes = _difference.inMinutes.remainder(60);
    int remainingSeconds = _difference.inSeconds.remainder(60);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(children: [
          InkWell(
            onTap: () {
              Future.delayed(Duration.zero, () {
                context.push(Routes.contestDetail);
              });
            },
            child: SizedBox(
              width: mq.width,
              child: Image.asset("assets/home_imge.jpg"),
            ),
          ),
          InkWell(
            onTap: () {
              Future.delayed(Duration.zero, () {
                context.push(Routes.contestDetail);
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              alignment: Alignment.bottomRight,
              child: Image.network(
                ApiConstants.baseUrlAssets + bannerImage,
                scale: 4,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /* Container(
                    width: 100,
                    padding: const EdgeInsets.all(10),
                    decoration: kButtonBgDecoration,
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/logo.png',
                    ),
                  ),*/
                  Text(
                    lotteryHeading,
                    style: textStyle(Colors.white, 14, 0, FontWeight.w400),
                  ),
                  10.height,
                  Text(
                    "$month month contest".allInCaps,
                    style: textStyle(Colors.yellow, 14, 0, FontWeight.w400),
                  ),
                  10.height,
                  Text(
                    lotteryName,
                    style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                  ),
                  10.height,
                  Text(
                    "Rs. $lotteryPrice Per ticket",
                    style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                  ),
                  Text(
                    "Buy Contest tickets to get a chance to win",
                    style: textStyle(Colors.white, 10, 0, FontWeight.w400),
                  ),
                  10.height,
                  Container(
                      width: 150,
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
                            style: textStyle(
                                Colors.white, 12, 0, FontWeight.w400)),
                      ))
                ]),
          )
        ]),
        20.height,
        Container(
          padding:const EdgeInsets.symmetric(horizontal: 20),child:Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Image.asset(
            "assets/new_offer.png",
            scale: 10,
          ),
          10.width,
          const Text("Buy 10 Tickets get 20% discount",style: TextStyle(color: Colors.black,fontSize: 16),)
        ]),),
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: kButtonBgDecoration,
          child: Stack(children: [
/*              Align(
                alignment: Alignment.center,
                child: Image.asset("assets/spiner.gif",scale: 1,),)*/
            Column(
              children: [
                Text(
                  "Contest Draw".allInCaps,
                  style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                ),
                Text(
                  "$month Month Contest Draw",
                  style: textStyle(Colors.white, 16, 0, FontWeight.normal),
                ),
                15.height,
                Container(
                  height: 1,
                  width: mq.width,
                  color: Colors.grey,
                ),
                15.height,
                Column(
                  children: [
                    Text(
                      "Contest Draw starts on".allInCaps,
                      style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                    ),
                    10.height,
                    Text(
                      "${remainingDays}d | ${remainingHours}h | ${remainingMinutes}m | ${remainingSeconds}s",
                      //"15d | 05h | 45m | 34s",
                      style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                    ),
                  ],
                ),
                25.height,
                Text(
                  "Rs.$lotteryPrice Per Ticket",
                  style: textStyle(Colors.white, 18, 0, FontWeight.w500),
                ),
                15.height,
                Container(
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  decoration: kButtonBoxDecorationEmpty,
                  height: 50,
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
                        style:
                            textStyle(Colors.white, 16, 0.5, FontWeight.w400)),
                  ),
                )
              ],
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.all(20),
          decoration: kButtonBgDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How it work",
                style: textStyle(Colors.white, 22, 0, FontWeight.w400),
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
                      child: Text("1",
                          style:
                              textStyle(Colors.white, 16, 0, FontWeight.w400)),
                    ),
                  ),
                  10.width,
                  Flexible(
                      flex: 8,
                      child: Text("Buy Contest Tickets".allInCaps,
                          style:
                              textStyle(Colors.white, 16, 0, FontWeight.w400))),
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
                      child: Text("2",
                          style:
                              textStyle(Colors.white, 16, 0, FontWeight.w400)),
                    ),
                  ),
                  10.width,
                  Flexible(
                      flex: 8,
                      child: Text("Wait for contest draw".allInCaps,
                          style:
                              textStyle(Colors.white, 16, 0, FontWeight.w400))),
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
                      child: Text(
                        "3",
                        style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                      ),
                    ),
                  ),
                  10.width,
                  Flexible(
                      flex: 8,
                      child: Text("Get a chance to win".allInCaps,
                          style:
                              textStyle(Colors.white, 16, 0, FontWeight.w400))),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: kButtonBgDecoration,
          child: Column(
            children: [
              Text(
                "Previous Month Winners".allInCaps,
                textAlign: TextAlign.center,
                style: textStyle(Colors.white, 18, 0, FontWeight.w400),
              ),
              15.height,
              Image.network(
                ApiConstants.baseUrlAssets + previousBannerImage,
                scale: 2,
              ),
              20.height,
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                decoration: kButtonBoxDecorationEmpty,
                height: 50,
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    if (kDebugMode) {
                      print("object");
                    }

                    setState(() {
                      index1 = false;
                      index2 = true;
                      index3 = false;
                      index4 = false;
                      controller.jumpToPage(1);
                    });
                    /*Future.delayed(Duration.zero, () {
                        context.push(Routes.upcomingContest);
                      });*/
                    //dialogShown = false;
                    //login(_emailText.text.trim().toString(), _controllerpasswordText.text.trim().toString());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: Text("See Previous Winners".allInCaps,
                      textAlign: TextAlign.center,
                      style: textStyle(Colors.white, 16, 0, FontWeight.w400)),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildProfileContainer(BuildContext context, Size mq, bool loading) {
    return Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              width: mq.width,
              alignment: Alignment.center,
              decoration: kTopBarDecoration,
              child: TopBarWidget(
                onTapLeft: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                leftIcon: 'assets/menu.png',
                title: 'Home',
                leftVisibility: true,
                screen: 'Profile',
              )),
          Container(
            height: mq.height,
            color: appBaseColor,
            margin: const EdgeInsets.only(top: 50),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                buildProfile(context, mq),
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
          ),
        ]));
  }

  Widget buildProfile(BuildContext context, Size mq) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              Future.delayed(Duration.zero, () {
                context.push(Routes.myTicketsPage);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: kGradientBoxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Text(
                      "My Tickets",
                      style: textStyle(Colors.white, 22, 0, FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 50, child: Icon(Icons.arrow_forward)),
                ],
              ),
            ),
          ),
          15.height,
          InkWell(
            onTap: () {
              Future.delayed(Duration.zero, () {
                context.push(Routes.myProfilePage);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: kGradientBoxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Text(
                      "My Profile",
                      style: textStyle(Colors.white, 22, 0, FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 50, child: Icon(Icons.arrow_forward)),
                ],
              ),
            ),
          ),
          15.height,
          InkWell(
            onTap: () {
              Future.delayed(Duration.zero, () {
                context.push(Routes.myWinTicketsPage);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: kGradientBoxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Text(
                      "My Wins",
                      style: textStyle(Colors.white, 22, 0, FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 50, child: Icon(Icons.arrow_forward)),
                ],
              ),
            ),
          ),
          15.height,
          InkWell(
            onTap: () {
              Future.delayed(Duration.zero, () {
                context.push(Routes.myPastTicketsPage);
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: kGradientBoxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Text(
                      "My Past Tickets",
                      style: textStyle(Colors.white, 22, 0, FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 50, child: Icon(Icons.arrow_forward)),
                ],
              ),
            ),
          ),
          15.height,
          InkWell(
            onTap: () {
              showDeleteAccountAlertDialog(context, "Delete Account",
                  "Are you sure to delete account permanently?"); // Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: kGradientBoxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Text(
                      "Delete Account",
                      style: textStyle(Colors.white, 22, 0, FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 50, child: Icon(Icons.arrow_forward)),
                ],
              ),
            ),
          ),
          15.height,
          InkWell(
            onTap: () {
              // Navigator.pop(context);
              SharedPrefs().setIsLogin(false);
              SharedPrefs().reset();

              context.go(Routes.signIn);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: kGradientBoxDecoration,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: Text(
                      "Logout",
                      style: textStyle(Colors.white, 22, 0, FontWeight.normal),
                    ),
                  ),
                  const SizedBox(height: 50, child: Icon(Icons.arrow_forward)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  showDeleteAccountAlertDialog(
    BuildContext context,
    String title,
    String msg,
  ) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        switchScreen = false;

        Navigator.of(context, rootNavigator: true).pop();
        homeBloc.add(
            GetDeleteAccountData(id: SharedPrefs().getStudentId().toString()));
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        //Navigator.pop(contexts);

        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title:
          Text(title, style: textStyle(Colors.black, 14, 0, FontWeight.normal)),
      content: Text(
        msg,
        style: textStyle(Colors.black, 14, 0, FontWeight.normal),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
