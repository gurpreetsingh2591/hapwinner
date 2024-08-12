import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/AppLocalizations.dart';
import '../app/router.dart';
import '../bloc/event/login_event.dart';
import '../bloc/event/signup_event.dart';
import '../bloc/logic_bloc/signup_bloc.dart';
import '../data/api/ApiService.dart';
import '../bloc/logic_bloc/login_bloc.dart';
import '../bloc/state/common_state.dart';
import '../utils/center_loader.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../utils/toast.dart';
import '../widgets/ColoredSafeArea.dart';
import '../widgets/CommonPasswordTextField.dart';
import '../widgets/CommonTextField.dart';
import '../widgets/CustomToastWidget.dart';
import '../widgets/TopBarWidget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool isLoading = false;
  bool isLogin = false;
  bool emailError = false;
  bool wrongError = false;
  bool sent = false;

  FToast fToast = FToast();

  final loginBloc = LoginBloc();
  bool dialogShown = false;

  @override
  void initState() {
    super.initState();
    emailListener();

    _emailFocus.addListener(_onFocusEmailChange);
    initializePreference().whenComplete(() {});
    isLogin = SharedPrefs().isLogin();
    if (kDebugMode) {
      print(isLogin);
    }
  }

  void emailListener() {
    _emailText.addListener(() {
      //here you have the changes of your textfield
      if (kDebugMode) {
        print("value: ${_emailText.text.toString()}");
      }
      //use setState to rebuild the widget
      setState(() {
        bool validEmail =
            isValidEmail(context, _emailText.text.toString().trim());
        if (!validEmail) {
          emailError = true;
        } else {
          emailError = false;
        }
        if (kDebugMode) {
          print("error: $emailError");
        }
      });
    });
  }

  Future<void> initializePreference() async {
    SharedPrefs.init(await SharedPreferences.getInstance());
  }

  void _onFocusEmailChange() {
    setState(() {
      wrongError = false;
      debugPrint("Focus: ${_emailFocus.hasFocus.toString()}");
    });
  }

  void forgotPassword(String userName) {
    bool validEmail = isValidEmail(context, userName);
    //  bool validPassword = isValidPassword(context, password);
    if (!validEmail) {
      if (userName.isEmpty) {
        toast(AppLocalizations.of(context).translate('enter_email'), true);
      } else if (!EmailValidator.validate(userName)) {
        toast(
            AppLocalizations.of(context).translate('enter_valid_email'), true);
      }
      emailError = true;
      _emailFocus.requestFocus();
    } else {
      emailError = false;

      loginBloc.add(GetForgotPasswordButtonPressed(
        email: userName,
      ));
    }
  }

  userDataAPI(dynamic loginSuccess) {
    if (loginSuccess['status'] == 401 && !dialogShown) {
      Future.delayed(Duration.zero, () {
        showCustomToast();
        dialogShown = true;
      });
    } else {
      if (loginSuccess['status'] == 200) {
        dialogShown = false;
        wrongError = false;
        if (!sent) {
          sent = true;
          getUserData(loginSuccess);
        }
      }
    }
  }

  getUserData(dynamic userData) {
    if (userData != null || userData != "") {
      if (kDebugMode) {
        print("get user data api$userData");
      }
      emailError = false;
      toast("Reset password link sent to your email", false);

      Future.delayed(Duration.zero, () {
        context.go(Routes.signIn);
      });
    }
  }

  showCustomToast() {
    setState(() {
      wrongError = true;
    });

    Widget toast = const CustomToastWidget(
      msg: 'Incorrect email, Please enter register email. Please try again.',
      image: 'assets/images/ic_wrong_alert.png',
      email: "",
      scale: 2,
    );

    fToast.showToast(
        child: toast,
        gravity: ToastGravity.CENTER,
        toastDuration: const Duration(seconds: 3),
        positionedToastBuilder: (context, child) {
          return Positioned(
            bottom: 180,
            left: 20,
            right: 20,
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    fToast.init(context);
    return BlocProvider(
        create: (context) => loginBloc,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<LoginBloc, CommonState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return buildHomeContainer(context, mq, true);
              } else if (state is SuccessState) {
                userDataAPI(state.response);
                return buildHomeContainer(context, mq, false);
              } else if (state is FailureState) {
                return buildHomeContainer(context, mq, false);
              }
              return buildHomeContainer(context, mq, false);
            },
          ),
        ));
  }

  Widget buildHomeContainer(BuildContext context, Size mq, bool isLoader) {
    return Container(
      decoration: boxImageBgDecoration(),
      padding: const EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 30),
      constraints: const BoxConstraints.expand(),
      child: Stack(
        children: [
          ListView(
            children: [
              Center(
                child: Image.asset(
                  "assets/splash_logo.png",
                  scale: 3,
                ),
              ),
              50.height,
              buildSignInContainer(context, mq),
            ],
          ),
          Visibility(
            visible: isLoader,
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
        ],
      ),
    );
  }

  Widget buildSignInContainer(BuildContext context, Size mq) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Enter your registered email to reset your password.",
            style: textStyle(Colors.white, 18, 0, FontWeight.normal),
          ),
          10.height,
          CommonTextField(
            controller: _emailText,
            hintText: "Email",
            text: "",
            isFocused: false,
            textColor: Colors.black,
            focus: _emailFocus,
            textSize: 16,
            weight: FontWeight.w400,
            hintColor: Colors.black26,
            error: emailError,
            wrongError: wrongError,
            decoration: kEditTextDecoration,
            padding: 0,
            leftIcon: true,
            enable: true, height: 50,
          ),
          30.height,
          Container(
            decoration: kButtonBoxDecorationEmpty,
            height: 50,
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("object");
                  }

                  forgotPassword(_emailText.text.trim().toString());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text("Send".allInCaps,
                          style: textStyle(
                              Colors.white, 16, 0.5, FontWeight.w400)),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
