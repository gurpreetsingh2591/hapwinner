import 'dart:async';
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/screens/profile_screen.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/widgets/ProfilePageWidget.dart';
import 'package:hap_winner_project/widgets/TestimonialWidget.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../app/router.dart';

import '../bloc/logic_bloc/home_bloc.dart';
import '../bloc/state/meeting_state.dart';
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
  final testimonialBloc = HomeBloc();
  final PageController controller = PageController();
  bool index1 = true;
  bool index2 = false;
  bool index3 = false;
  bool index4 = false;
  final List<String> _videoUrlList = [
    'https://youtu.be/dWs3dzj4Wng',
    'https://www.youtube.com/watch?v=668nUCeBHyY',
    'https://youtu.be/S3npWREXr8s',
  ];

  List<YoutubePlayerController> lYTC = [];

  Map<String, dynamic> cStates = {};

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
    fillYTlists();
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
        create: (context) => testimonialBloc,
        child: Scaffold(
            key: _scaffoldKey,
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
                        child: BlocBuilder<HomeBloc, MeetingState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return buildHomeContainer(context, mq, true);
                            } else if (state is GetOfficeSlotState) {
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
                        child: BlocBuilder<HomeBloc, MeetingState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return buildWinnerContainer(context, mq, true);
                            } else if (state is GetOfficeSlotState) {
                              return buildWinnerContainer(context, mq, false);
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
                        child: BlocBuilder<HomeBloc, MeetingState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return buildTestimonialContainer(
                                  context, mq, true);
                            } else if (state is GetOfficeSlotState) {
                              return buildTestimonialContainer(
                                  context, mq, false);
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
                        child: BlocBuilder<HomeBloc, MeetingState>(
                          builder: (context, state) {
                            if (state is LoadingState) {
                              return ProfilePageWidget(
                                onTap: () {},
                              );
                            } else if (state is GetOfficeSlotState) {
                              return ProfilePageWidget(
                                onTap: () {},
                              );
                            } else if (state is FailureState) {
                              return Center(
                                child: Text('Error: ${state.error}'),
                              );
                            }
                            return ProfilePageWidget(
                              onTap: () {},
                            );
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
                onTapLeft: () {},
                leftIcon: 'assets/back_arrow.png',
                title: 'Home',
                leftVisibility: false,
                screen: 'buy_ticket',
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
                  onTapLeft: () {},
                  leftIcon: 'assets/back_arrow.png',
                  title: 'Winners',
                  leftVisibility: false,
                  screen: 'buy_ticket',
                )),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(top: 50),
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return WinnerWidget(
                    onTap: () {},
                    decoration: kAllCornerBoxDecoration,
                  );
                },
              ),
            ),
          ],
        ));
  }

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
              onTapLeft: () {},
              leftIcon: 'assets/back_arrow.png',
              title: 'Testimonials',
              leftVisibility: false,
              screen: 'buy_ticket',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                YoutubePlayerController _ytController = lYTC[index];


                return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column( children: [
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
                        ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(20)
                      ),child: Image.asset(
                            "assets/testimonial.png",
                            scale: 7,
                          ),),
                          20.width,
                           Text(
                            "Katrina ",
                            style: textStyle(Colors.white, 22, 0, FontWeight.normal),
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

  Widget buildContestContainer(BuildContext context, Size mq) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(children: [
          SizedBox(
            width: mq.width,
            child: Image.asset("assets/home_top_image.png"),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Image.asset(
              "assets/splash_logo.png",
              scale: 4,
            ),
          )
        ]),
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
                  "April Month Contest Draw",
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
                      "15d | 05h | 45m | 34s",
                      style: textStyle(Colors.white, 16, 0, FontWeight.w500),
                    ),
                  ],
                ),
                25.height,
                Text(
                  "Rs. 100 Per Ticket",
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text("Buy Tickets".allInCaps,
                                style: textStyle(
                                    Colors.white, 16, 0.5, FontWeight.w400)),
                          ),
                        ],
                      )),
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
              Image.asset(
                "assets/trip.jpeg",
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text("See Previous Contest Winners".allInCaps,
                              textAlign: TextAlign.center,
                              style: textStyle(
                                  Colors.white, 16, 0, FontWeight.w400)),
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
