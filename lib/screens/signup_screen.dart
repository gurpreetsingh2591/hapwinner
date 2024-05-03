import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
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

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool isLoading = false;
  bool isLogin = false;
  bool _obscurePassword = true;
  bool emailError = false;
  bool wrongError = false;
  bool passwordError = false;
  FToast fToast = FToast();
  dynamic loginResult;
  dynamic userDataResult;

  final loginBloc = LoginBloc();
  bool dialogShown = false;
  final signupBloc = SignUpBloc();
  String? fcmToken;

  @override
  void initState() {
    super.initState();
    passwordListener();
    emailListener();

    _emailFocus.addListener(_onFocusEmailChange);
    _passwordFocus.addListener(_onFocusPasswordChange);
    initializePreference().whenComplete(() {});
    isLogin = SharedPrefs().isLogin();
    if (kDebugMode) {
      print(isLogin);
    }

    if (isLogin) {
      Future.delayed(Duration.zero, () {
        context.go(Routes.mainHome);
      });
    }
  }

  void passwordListener() {
    _passwordText.addListener(() {
      //here you have the changes of your textfield
      if (kDebugMode) {
        print("value: ${_passwordText.text.toString()}");
      }
      //use setState to rebuild the widget
      setState(() {
        bool validPassword =
            isValidPassword(context, _passwordText.text.toString());
        if (!validPassword) {
          passwordError = true;
        } else {
          passwordError = false;
        }
        if (kDebugMode) {
          print("error: $passwordError");
        }
      });
    });
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

  void _onFocusPasswordChange() {
    setState(() {
      wrongError = false;
      debugPrint("Focus: ${_passwordFocus.hasFocus.toString()}");
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void login(String userName, String password) {
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
    }
    /* else if (!validPassword) {
      _passwordFocus.requestFocus();
      passwordError = true;
      if (password.isEmpty) {
        toast(AppLocalizations.of(context).translate('enter_password'), true);
      } else if (password.length < 8) {
        toast(AppLocalizations.of(context).translate('enter_valid_password'),
            true);
      } else if (!passwordRegEx.hasMatch(password.toString())) {
        toast(AppLocalizations.of(context).translate('enter_valid_password'),
            true);
      }
    }*/
    else {
      passwordError = false;
      emailError = false;
      fcmToken = SharedPrefs().getTokenKey();
      if (Platform.isIOS) {
        if (fcmToken != "" || fcmToken != null) {
          loginBloc.add(LoginButtonPressed(
              username: userName, password: password, fcmToken: fcmToken!));
        } else {
          toast("Fcm token empty", false);
        }
      } else {
        if (fcmToken != null) {
          loginBloc.add(LoginButtonPressed(
              username: userName, password: password, fcmToken: fcmToken!));
        }
      }
    }
  }

  userDataAPI(dynamic loginSuccess) {
    if (loginSuccess['status'] == "400" && !dialogShown) {
      Future.delayed(Duration.zero, () {
        dialogShown = true;
        showCustomToast();
      });
    } else {
      if (loginSuccess['status'] == 200) {
        dialogShown = false;
        wrongError = false;
        getUserData(loginSuccess);
      }
    }
  }

  getUserData(dynamic userData) {
    if (userData != null || userData != "") {
      if (kDebugMode) {
        print("get user data api$userData");
      }
      passwordError = false;
      emailError = false;

      SharedPrefs().setUserFullName(userData['result']['studentname']);
      SharedPrefs().setUserEmail(userData['result']['vchmomemail']);
      SharedPrefs().setStudentId(userData['result']['studentid']);
      SharedPrefs().setParentId(userData['result']['parentid']);
      SharedPrefs()
          .setStudentCount(userData['result']['studuent_count'].toString());
      SharedPrefs().setStudentMomName(userData['result']['mom']);

      List<Map<String, dynamic>> students = [];
      if (userData['students_list'] != null) {
        if (userData['students_list'] is List) {
          // Check if 'students_list' is a List
          students.addAll(
            (userData['students_list'] as List)
                .map((student) => student as Map<String, dynamic>)
                .toList(),
          );
          SharedPrefs().saveStudents(students);
        }
      }
      if (kDebugMode) {
        print("studentList---${userData['students_list']}");
        print("student---$students");
      }

      SharedPrefs().setIsLogin(true);
      Future.delayed(Duration.zero, () {
        context.go(Routes.mainHome);
      });
    }
  }

  showCustomToast() {
    setState(() {
      wrongError = true;
    });

    Widget toast = const CustomToastWidget(
      msg: 'Invalid email and/or password. Please try again.',
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
          resizeToAvoidBottomInset: true,
          body: BlocBuilder<LoginBloc, CommonState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return loaderBar(context, mq);
              } else if (state is SuccessState) {
                userDataAPI(state.response);
                return buildHomeContainer(context, mq);
              } else if (state is UserDataSuccessState) {
                getUserData(state.response);
                return buildHomeContainer(context, mq);
              } else if (state is FailureState) {
                return buildHomeContainer(context, mq);
              }
              return buildHomeContainer(context, mq);
            },
          ),
        ));
  }

  Widget loaderBar(BuildContext context, Size mq) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: boxImageBgDecoration(),
      child: Stack(
        children: [
          Container(
            margin:
                const EdgeInsets.only(bottom: 20, top: 40, left: 32, right: 32),
            child: ListView(
              shrinkWrap: true,
              primary: false,
              children: [
                Center(
                  child: Image.asset(
                    "assets/splash_logo.png",
                    scale: 3,
                  ),
                ),
                buildSignInContainer(context, mq),
              ],
            ),
          ),
          Container(
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
        ],
      ),
    );
  }

  Widget buildHomeContainer(BuildContext context, Size mq) {
    return Container(
      decoration: boxImageBgDecoration(),
      padding: const EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 30),
      constraints: const BoxConstraints.expand(),
      child: ListView(
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
    );
  }

  Widget buildSignInContainer(BuildContext context, Size mq) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          30.height,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            height: 50,
            decoration: kFaceBookBoxDecoration,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset("assets/facebook.png"),
                ),
                Flexible(
                    flex: 4,
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Sign up with Facebook",
                          style:
                              textStyle(Colors.white, 20, 0, FontWeight.normal),
                        )))
              ],
            ),
          ),
          20.height,
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: kGoogleBoxDecoration,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Image.asset("assets/google_plus.png"),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Sign up with Google",
                      style: textStyle(Colors.white, 20, 0, FontWeight.normal),
                    ),
                  ),
                )
              ],
            ),
          ),
          50.height,
          InkWell(
            onTap: () async {
              Future.delayed(Duration.zero, () {
                context.push(Routes.signupWithEmail);
              });
            },
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              decoration: kEmailBoxDecoration,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Sign up with Email",
                  style: textStyle(Colors.white, 20, 0, FontWeight.normal),
                ),
              ),
            ),
          ),
          40.height,
          20.height,
          InkWell(
            onTap: () async {
              Future.delayed(Duration.zero, () {
                context.push(Routes.signIn);
              });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("If you have an account? Login",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins')),
            ),
          ),
        ],
      ),
    );
  }
}
