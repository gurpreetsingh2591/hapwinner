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

class SignUpWithEmailPage extends StatefulWidget {
  const SignUpWithEmailPage({Key? key}) : super(key: key);

  @override
  SignUpWithEmailState createState() => SignUpWithEmailState();
}

class SignUpWithEmailState extends State<SignUpWithEmailPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameText = TextEditingController();
  final _emailText = TextEditingController();
  final _passwordText = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
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

  bool dialogShown = false;
  bool switchScreen = false;
  final signupBloc = SignUpBloc();
  String? fcmToken;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'profile',
  ]);
  final loginBloc = LoginBloc();

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
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      // Triggered when the current user changes
      // You can handle sign in success here
      if (account != null) {
        if (kDebugMode) {
          print('User signed in: ${account.email}');
        }
        if (kDebugMode) {
          print('User social id: ${account.id}');
        }
        loginBloc.add(GetSocialLoginData(
            emailId: account.email,
            socialId: account.id,
            name: account.displayName!));
      }
    });
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print('Error signing in: $error');
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

  void signup(String userName, String userEmail, String password) {
    bool validEmail = isValidEmail(context, userEmail);
    bool validPassword = isValidPassword(context, password);

    if (!validEmail) {
      if (userEmail.isEmpty) {
        toast('Enter email', true);
      } else if (!EmailValidator.validate(userEmail)) {
        toast('Enter valid email', true);
      }
      emailError = true;
      //_emailFocus.requestFocus();
    } else {
      emailError = false;
      fcmToken = SharedPrefs().getTokenKey();

      signupBloc.add(SignUpButtonPressed(userEmail: userEmail));
      /* if (Platform.isIOS) {
        if (fcmToken != "" || fcmToken != null) {
          signupBloc.add(SignUpButtonPressed(
              firstName: userName,userEmail: userEmail,password: password  ));
        } else {
          toast("Fcm token empty", false);
        }
      } else {
        if (fcmToken != null) {
          signupBloc.add(SignUpButtonPressed(
              firstName: userName,userEmail: userEmail,password: password  ));        }
      }*/
    }
  }

  userDataAPI(dynamic loginSuccess, bool isSocial) {
    if (loginSuccess['status'] == 401 && !dialogShown) {
      toast(
          "Already Registered , Please try with another email/mobile ", false);

      Future.delayed(Duration.zero, () {
        dialogShown = true;
        showCustomToast();
      });
    } else {
      if (loginSuccess['status'] == 200) {
        if (!switchScreen) {
          switchScreen = true;
          dialogShown = false;
          wrongError = false;
          getUserData(loginSuccess, isSocial);
        }
      }
    }
  }

  getUserData(dynamic userData, bool isSocial) {
    if (userData != null || userData != "") {
      if (kDebugMode) {
        print("get user data api$userData");
      }
      passwordError = false;
      emailError = false;

      if (isSocial) {
        SharedPrefs().setStudentId(userData['data']['user']['id'].toString());
        SharedPrefs().setUserEmail(userData['data']['user']['email']);
        SharedPrefs().setUserToken(userData['data']['token']);

        SharedPrefs().setIsLogin(true);
        Future.delayed(Duration.zero, () {
          context.go(Routes.mainHome);
        });
      } else {
        SharedPrefs().setStudentId(userData['data']['user']['id'].toString());
        SharedPrefs().setUserEmail(userData['data']['user']['email']);
        // SharedPrefs().setUserToken(userData['data']['token']);

        Future.delayed(Duration.zero, () {
          //context.push(Routes.otpVerify);

          context.pushNamed('otpVerify', queryParameters: {
            'id': SharedPrefs().getStudentId().toString(),
            'type': 'register'
          });
        });
      }
      /*SharedPrefs().setIsLogin(true);
      Future.delayed(Duration.zero, () {
        context.go(Routes.mainHome);
      });*/
    }
  }

  showCustomToast() {
    setState(() {
      wrongError = true;
    });

    Widget toast = const CustomToastWidget(
      msg: 'Invalid email and/or password. Please try again.',
      image: 'assets/ic_wrong_alert.png',
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
        create: (context) => signupBloc,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: BlocBuilder<SignUpBloc, CommonState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return buildHomeContainer(context, mq, true);
              } else if (state is SuccessState) {
                userDataAPI(state.response, false);
                return buildHomeContainer(context, mq, false);
              } else if (state is SocialLoginState) {
                userDataAPI(state.response, true);
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
    return Stack(children: [
      Container(
        decoration: boxImageBgDecoration(),
        padding:
            const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
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
            buildSignInContainer(context, mq),
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
          )),
    ]);
  }

  Widget buildSignInContainer(BuildContext context, Size mq) {
    return Align(
        alignment: Alignment.topLeft,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /*40.height,
              CommonTextField(
                controller: _nameText,
                hintText: "Name",
                text: "",
                isFocused: false,
                textColor: Colors.black,
                focus: _nameFocus,
                textSize: 16,
                weight: FontWeight.w400,
                hintColor: Colors.black26,
                error: emailError,
                wrongError: wrongError,
                decoration: kEditTextDecoration,
                padding: 0,
              ),*/
              20.height,
              CommonTextField(
                  height: 50,
                  controller: _emailText,
                  hintText: "Email/Mobile Number".allInCaps,
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
                  enable: true),
              20.height,
/*              Stack(children: [
                CommonPasswordTextField(
                  controller: _passwordText,
                  hintText: "Password",
                  text: "",
                  isFocused: false,
                  textColor: Colors.black,
                  focus: _passwordFocus,
                  textSize: 16,
                  weight: FontWeight.w400,
                  hintColor: Colors.black26,
                  obscurePassword: _obscurePassword,
                  error: passwordError,
                  wrongError: wrongError,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 13, right: 10),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: kBaseColor,
                    ),
                  ),
                ),
              ])*/
              20.height,
              Container(
                decoration: kButtonBoxDecorationEmpty,
                height: 50,
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();

                      /*Future.delayed(Duration.zero, () {
                        context.go(Routes.mainHome);
                      });*/
                      //dialogShown = false;
                      signup(
                          _nameText.text.toString(),
                          _emailText.text.trim().toString(),
                          _passwordText.text.trim().toString());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text("Signup".allInCaps,
                              style: textStyle(
                                  Colors.white, 16, 0.5, FontWeight.w400)),
                        ),
                      ],
                    )),
              ),
              20.height,
              InkWell(
                onTap: () async {
                  Future.delayed(Duration.zero, () {
                    context.go(Routes.signIn);
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: const Text("If you have an account? Login",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'poppins')),
                ),
              ),
              20.height,
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
                          style: TextStyle(fontSize: 22, color: Colors.white),
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
              20.height,
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        _handleSignIn();
                      },
                      child: Center(
                          child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: kGoogleBoxDecoration,
                        child: Image.asset(
                          "assets/google_plus.png",
                          scale: 1.5,
                        ),
                      )),
                    ),
                    20.width,
                    Center(
                        child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: kFaceBookBoxDecoration,
                      child: Image.asset(
                        "assets/facebook.png",
                        scale: 1.5,
                      ),
                    )),
                  ])
            ]));
  }
}
