import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/event/login_event.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*import 'dart:html' as html;*/

import '../app/router.dart';
import '../bloc/logic_bloc/login_bloc.dart';
import '../bloc/state/common_state.dart';
import '../data/api/ApiService.dart';
import '../utils/center_loader.dart';
import '../utils/constant.dart';
import '../utils/custom_alert_dialog.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../utils/toast.dart';
import '../widgets/CustomToastWidget.dart';
import '../widgets/OtpTimer.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String userId;
  final String userType;

  const OtpVerificationScreen(
      {Key? key, required this.userId, required this.userType})
      : super(key: key);

  @override
  OtpVerificationScreenState createState() => OtpVerificationScreenState();
}

class OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<OtpTimerState> _otpTimerStateKey = GlobalKey<OtpTimerState>();
  String loginText = "If you haven't received OTP yet? ";
  String loginText1 = "Resend";

  bool isLoading = false;
  bool isLogin = false;

  String otp = "";
  bool isTimeUp = false;
  bool isTimeStart = true;
  bool dialogShown = false;
  bool switchScreen = false;
  FToast fToast = FToast();
  final loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
      setState(() {});
    });
  }

  void _resendOtp() {
    setState(() {
      // Code to resend OTP
    });
    _otpTimerStateKey.currentState?.restartTimer();
  }

  void _getVerifyOTPData() {
    loginBloc.add(LoginOTPVerifyButtonPressed(
        user: widget.userId, otp: otp, usertype: widget.userType));
  }

  void resendData(dynamic response) {
    if (response['status'] == 401) {
      Future.delayed(Duration.zero, () {
        dialogShown = true;
        showCustomToast();
      });
    } else {
      if (response['status'] == 200) {
        if (!switchScreen) {
          toast("OTP Resend Successfully", false);
          switchScreen = true;
        }
      }
    }
  }

  userDataAPI(dynamic loginSuccess) {
    print("login data---$loginSuccess");
    if (loginSuccess['status'] == 401 && !dialogShown) {
      Future.delayed(Duration.zero, () {
        dialogShown = true;
        showCustomToast();
      });
    } else {
      if (loginSuccess['status'] == 200) {
        if (!switchScreen) {
          dialogShown = false;
          switchScreen = true;
          getUserData(loginSuccess);
        }
      }
    }
  }

  showCustomToast() {
    Widget toast = const CustomToastWidget(
      msg: 'Otp not send. Please try again.',
      image: 'assets/ic_wrong_alert.png',
      email: "",
      scale: 2,
    );

    fToast.showToast(
        child: toast,
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 4),
        positionedToastBuilder: (context, child) {
          return Positioned(
            bottom: 180,
            left: 20,
            right: 20,
            child: child,
          );
        });
  }

  getUserData(dynamic userData) {
    if (userData != null || userData != "") {
      if (kDebugMode) {
        print("get user data api$userData");
      }

      SharedPrefs().setStudentId(userData['data']['user']['id'].toString());
      SharedPrefs().setUserEmail(userData['data']['user']['email']);
      SharedPrefs().setUserToken(userData['data']['token']);
      SharedPrefs().setIsLogin(true);
      Future.delayed(Duration.zero, () {
        context.go(Routes.mainHome);
      });
    }
  }

  void _getResendOTPData() {
    loginBloc.add(OTPResendButtonPressed(
        userId: SharedPrefs().getStudentId().toString()));
  }

  Future<void> initializePreference() async {
    SharedPrefs.init(await SharedPreferences.getInstance());
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => loginBloc,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: BlocBuilder<LoginBloc, CommonState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return buildHomeContainer(context, mq, true);
              } else if (state is OTPSuccessState) {
                userDataAPI(state.response);
                return buildHomeContainer(context, mq, false);
              } else if (state is ResendOTPSuccessState) {
                resendData(state.response);
                return buildHomeContainer(context, mq, false);
              } else if (state is FailureState) {
                return buildHomeContainer(context, mq, false);
              }
              return buildHomeContainer(context, mq, false);
            },
          ),
        ));
  }

  Widget buildHomeContainer(BuildContext context, Size mq, bool isLoading) {
    return Stack(
      children: [
        Container(
          decoration: boxImageBgDecoration(),
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 30),
          constraints: const BoxConstraints.expand(),
          child: ListView(
            children: [
              Center(
                child: Image.asset(
                  "assets/splash_logo.png",
                  scale: 3,
                ),
              ),
              30.height,
              buildOTPContainer(context, mq),
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
    );
  }

  Widget buildLoginTxtContainer(BuildContext context) {
    return const Text(kOTPMsg,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ));
  }

  Widget buildOTPContainer(BuildContext context, Size mq) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 60,
            margin: const EdgeInsets.only(
              top: 50,
            ),
            child: OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: const TextStyle(fontSize: 17, color: Colors.white),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              otpFieldStyle: OtpFieldStyle(
                  focusBorderColor: accent,
                  disabledBorderColor: accentLight,
                  enabledBorderColor: accent,
                  errorBorderColor: Colors.red //(here)
                  ),
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                if (pin.isNotEmpty) {
                  otp = pin;
                }

                if (kDebugMode) {
                  print("Completed: $pin");
                }
              },
            ),
          ),
          ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: Container(
                decoration: kButtonBgDecoration,
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (otp == "") {
                      const CustomAlertDialog().errorDialog(kOTPError, context);
                    } else {
                      // setState(() {
                      // showCenterLoader(context);
                      _getVerifyOTPData();
                      // });
                      // }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // <-- Radius
                    ),
                  ),
                  child: const Text(kVerifyOTP,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      )),
                ),
              )),
          Container(
              margin: const EdgeInsets.only(top: 40),
              child: buildResendTxtContainer1(context))
        ],
      ),
    );
  }

  Widget buildResendTxtContainer1(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(loginText,
          textAlign: TextAlign.center,
          style: textStyle(
            Colors.white,
            16,
            0,
            FontWeight.w400,
          )),
      MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => {
              setState(() {
                isTimeUp = false;
                isTimeStart = true;
                // showCenterLoader(context);
                _getResendOTPData();
                _resendOtp();
              })
            },
            child: Visibility(
              visible: isTimeUp,
              child: Text(loginText1,
                  textAlign: TextAlign.center,
                  style: textStyle(
                    appBaseColor,
                    18,
                    0,
                    FontWeight.w400,
                  )),
            ),
          )),
      Visibility(
          visible: isTimeStart,
          child: Align(
              alignment: Alignment.center,
              child: OtpTimer(
                key: _otpTimerStateKey,
                timeInSec: 45,
                onTimerEnd: () {
                  setState(() {
                    isTimeUp = true;
                    isTimeStart = false;
                  }); // handle the timer end event here
                },
              ))),
    ]);
  }
}
