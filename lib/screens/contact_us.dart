import 'dart:async';
import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/logic_bloc/home_bloc.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/widgets/CommonNoteTextField.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../app/router.dart';
import '../bloc/event/home_event.dart';
import '../bloc/state/home_state.dart';
import '../data/api/api_constants.dart';
import '../model/contestDetail/LotteryData.dart';
import '../model/my_tickets/UserContestTicket.dart';
import '../utils/toast.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/CommonTextField.dart';
import '../widgets/TopBarWidget.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  ContactUsState createState() => ContactUsState();
}

class ContactUsState extends State<ContactUsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameText = TextEditingController();
  final _emailText = TextEditingController();
  final _subjectText = TextEditingController();
  final _descriptionText = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _subjectFocus = FocusNode();
  final FocusNode _descriptionFocus = FocusNode();
  bool isLogin = false;
  bool isLoader = false;
  bool load = false;

  bool wrongError = false;
  var homeBloc = HomeBloc();

  // Current selected value

  String status = "";
  String token = "";

  void contactUsPressed(
      String userName, String email, String subject, String message) {
    bool validEmail = isValidEmail(context, email);
    bool validName = userName.isNotEmpty;
    bool validSubject = subject.isNotEmpty;
    bool validMessage = message.isNotEmpty;
    if (!validEmail) {
      if (email.isEmpty) {
        toast('Enter email', true);
      } else if (!EmailValidator.validate(email)) {
        toast('Enter valid email', true);
      }
    } else if (!validName) {
      toast('Enter Name', true);
    } else if (!validSubject) {
      toast('Enter Subject', true);
    } else if (!validMessage) {
      toast('Enter Message', true);
    } else {
      homeBloc.add(GetContactUsPressed(
          name: userName,
          email: email,
          subject: subject,
          message: message,
          token: token));
    }
  }

  @override
  void initState() {
    super.initState();

    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });

    setState(() {
      token = SharedPrefs().getUserToken().toString();
    });
  }

  getDetail(dynamic response) {
    if (response != "") {
      status = response['status'].toString();
      if (status == "200") {
        if(!load) {
          load=true;
          toast("Message Sent to Our Team, They will contact you soon", false);

          _nameText.text = "";
          _emailText.text = "";
          _subjectText.text = "";
          _descriptionText.text = "";
        }
      }
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
              title: 'Contact Us',
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
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "We’d love to talk about how we can work together. Send us a message below and we’ll respond as soon as possible.",
                    style: textStyle(Colors.white, 18, 0, FontWeight.normal),
                  ),
                ),
                20.height,
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Drop Us a message:",
                    style: textStyle(Colors.white, 18, 0, FontWeight.normal),
                  ),
                ),
                15.height,
                Row(children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                      style: textStyle(Colors.white, 18, 0, FontWeight.normal),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "*",
                      style: textStyle(Colors.red, 18, 0, FontWeight.normal),
                    ),
                  ),
                ]),
                CommonTextField(
                  controller: _nameText,
                  hintText: "Enter Your Full Name",
                  text: "",
                  isFocused: false,
                  textColor: Colors.black,
                  focus: _nameFocus,
                  textSize: 16,
                  weight: FontWeight.w400,
                  hintColor: Colors.black26,
                  error: false,
                  wrongError: wrongError,
                  decoration: kEditTextDecoration,
                  padding: 10,
                  leftIcon: false,
                  enable: true, height: 50,
                ),
                15.height,
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email",
                        style:
                            textStyle(Colors.white, 18, 0, FontWeight.normal),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "*",
                        style: textStyle(Colors.red, 18, 0, FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                CommonTextField(
                  controller: _emailText,
                  hintText: "Enter Your Email",
                  text: "",
                  isFocused: false,
                  textColor: Colors.black,
                  focus: _emailFocus,
                  textSize: 16,
                  weight: FontWeight.w400,
                  hintColor: Colors.black26,
                  error: false,
                  wrongError: wrongError,
                  decoration: kEditTextDecoration,
                  padding: 10,
                  leftIcon: false,
                  enable: true, height: 50,
                ),
                15.height,
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Subject",
                        style:
                            textStyle(Colors.white, 18, 0, FontWeight.normal),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "*",
                        style: textStyle(Colors.red, 18, 0, FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                CommonTextField(
                  controller: _subjectText,
                  hintText: "Enter Subject",
                  text: "",
                  isFocused: false,
                  textColor: Colors.black,
                  focus: _subjectFocus,
                  textSize: 16,
                  weight: FontWeight.w400,
                  hintColor: Colors.black26,
                  error: false,
                  wrongError: wrongError,
                  decoration: kEditTextDecoration,
                  padding: 10,
                  leftIcon: false,
                  enable: true, height: 50,
                ),
                15.height,
                Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Message",
                        style:
                            textStyle(Colors.white, 18, 0, FontWeight.normal),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "*",
                        style: textStyle(Colors.red, 18, 0, FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                CommonNoteTextField(
                  controller: _descriptionText,
                  hintText: "Write Your Message",
                  text: "",
                  isFocused: false,
                  textColor: Colors.black,
                  focus: _descriptionFocus,
                  textSize: 16,
                  weight: FontWeight.w400,
                  hintColor: Colors.black26,
                  error: false,
                  wrongError: wrongError,
                  decoration: kEditTextDecoration,
                  padding: 10,
                ),
                20.height,
                Container(
                  decoration: kButtonBoxDecorationEmpty,
                  height: 50,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {
                        if (kDebugMode) {
                          print("object");
                        }
                        contactUsPressed(
                            _nameText.text.toString(),
                            _emailText.text.toString(),
                            _subjectText.text.toString(),
                            _descriptionText.text.toString());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text("Send Message".allInCaps,
                                style: textStyle(
                                    Colors.white, 16, 0.5, FontWeight.w400)),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
