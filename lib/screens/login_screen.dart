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
import '../model/ChecklistItem.dart';
import '../utils/center_loader.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../utils/toast.dart';
import '../widgets/ColoredSafeArea.dart';
import '../widgets/CommonMobileField.dart';
import '../widgets/CommonPasswordTextField.dart';
import '../widgets/CommonTextField.dart';
import '../widgets/CustomToastWidget.dart';
import '../widgets/TopBarWidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailText = TextEditingController();
  final _mobileText = TextEditingController();
  final _passwordText = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();

  bool isLoading = false;
  bool isLogin = false;
  bool _obscurePassword = true;
  bool emailError = false;
  bool wrongError = false;
  bool switchScreen = false;
  bool passwordError = false;
  FToast fToast = FToast();
  dynamic loginResult;
  dynamic userDataResult;

  final loginBloc = LoginBloc();
  bool dialogShown = false;
  final signupBloc = SignUpBloc();
  String? fcmToken;
  String? _selectedOption = "otp";
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['email', 'profile',]);

  final List<ChecklistItem> _items = [
    ChecklistItem('Item 1'),
    ChecklistItem('Item 2'),
  ];

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

  void loginWithOTP(String userName) {
    bool validEmail = isValidEmail(context, userName);
    if (!validEmail) {
      if (userName.isEmpty) {
        toast('Enter email/mobile', true);
      } else if (!EmailValidator.validate(userName)) {
        toast('Enter valid email/mobile', true);
      }
      emailError = true;
      // _emailFocus.requestFocus();
    } else {
      emailError = false;
      fcmToken = SharedPrefs().getTokenKey();
      loginBloc
          .add(LoginWithOTPButtonPressed(username: userName, fcmToken: ""));
    }
  }

  void loginWithPassword(String userName, String password) {
    bool validEmail = isValidEmail(context, userName);
    bool validPassword = isValidPassword(context, password);
    if (!validEmail) {
      if (userName.isEmpty) {
        toast('Enter email', true);
      } else if (!EmailValidator.validate(userName)) {
        toast('Enter valid email', true);
      }
      emailError = true;
      // _emailFocus.requestFocus();
    } else if (!validPassword) {
      // _passwordFocus.requestFocus();
      passwordError = true;
      if (password.isEmpty) {
        toast('Enter password', true);
      } else if (password.length < 6) {
        toast('Enter minimum 6 character', true);
      }
    } else {
      passwordError = false;
      emailError = false;
      fcmToken = SharedPrefs().getTokenKey();
      loginBloc.add(LoginButtonPressed(
          username: userName, password: password, fcmToken: ""));

      /* if (Platform.isIOS) {
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
      }*/
    }
  }

  userDataAPI(dynamic loginSuccess,bool isSocial) {
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
          wrongError = false;
          switchScreen = true;
          getUserData(loginSuccess,isSocial);
        }
      }
    }
  }

  getUserData(dynamic userData,bool isSocial) {
    if (userData != null || userData != "") {
      if (kDebugMode) {
        print("get user data api$userData");
      }
      passwordError = false;
      emailError = false;
      if(isSocial){
        SharedPrefs().setStudentId(userData['data']['user']['id'].toString());
        SharedPrefs().setUserEmail(userData['data']['user']['email']);
        SharedPrefs().setUserToken(userData['data']['token']);

        SharedPrefs().setIsLogin(true);
        Future.delayed(Duration.zero, () {
          context.go(Routes.mainHome);
        });
      }else {
        if (_selectedOption == "password") {
          SharedPrefs().setUserFullName(userData['data']['user']['name']);
          SharedPrefs().setUserEmail(userData['data']['user']['email']);
          SharedPrefs().setStudentId(userData['data']['user']['id'].toString());
          bool isVerified = (userData['data']['user']['otpverified']);
          SharedPrefs().setUserToken(userData['data']['token']);

          if (isVerified == 1) {
            SharedPrefs().setIsLogin(true);
            Future.delayed(Duration.zero, () {
              context.go(Routes.mainHome);
            });
          } else {
            toast("Your account not verified", true);
          }
        } else {
          SharedPrefs().setUserFullName(userData['data']['user']['name']);
          SharedPrefs().setStudentId(userData['data']['user']['id'].toString());
          SharedPrefs().setUserEmail(userData['data']['user']['email']);
          //SharedPrefs().setUserToken(userData['data']['token']);

          Future.delayed(Duration.zero, () {
            //context.push(Routes.otpVerify);

            context.pushNamed('otpVerify', queryParameters: {
              'id': SharedPrefs().getStudentId().toString(),
              'type': 'login'
            });
          });
        }
      }
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
                return buildHomeContainer(context, mq, true);
              } else if (state is SuccessState) {
                userDataAPI(state.response,false);
                return buildHomeContainer(context, mq, false);
              } else if (state is SocialLoginState) {
                userDataAPI(state.response,true);
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
    return Stack(children: [
      Container(
        decoration: boxImageBgDecoration(),
        padding:
            const EdgeInsets.only(right: 30, left: 30, top: 30, bottom: 10),
        constraints: const BoxConstraints.expand(),
        child: ListView(
          children: [
            Center(
              child: Image.asset(
                "assets/splash_logo.png",
                scale: 3,
              ),
            ),
            10.height,
            buildSignInContainer(context, mq),
          ],
        ),
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
          ))
    ]);
  }

  Widget buildSignInContainer(BuildContext context, Size mq) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RadioListTile<String>(
            title: const Text('Login with OTP'),
            value: 'otp',
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 0), // Reduce horizontal padding
          ),
          Transform.translate(
            offset: const Offset(0, -20),
            // Negative margin, moves this widget up
            child: RadioListTile<String>(
              title: const Text('Login with password'),
              value: 'password',
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0), // Reduce horizontal padding
            ),
          ),
          CommonTextField(
            controller: _emailText,
            hintText: "Email/Mobile",
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
            padding: 0, leftIcon: true, enable: true,
          ),
          20.height,
          _selectedOption == "password"
              ? Stack(children: [
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
                ])
              : const SizedBox(),
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
                  if (_selectedOption == "password") {
                    loginWithPassword(_emailText.text.trim().toString(),
                        _passwordText.text.trim().toString());
                  } else {
                    loginWithOTP(_emailText.text.trim().toString());
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text("Login".allInCaps,
                          style: textStyle(
                              Colors.white, 16, 0.5, FontWeight.w400)),
                    ),
                  ],
                )),
          ),
          10.height,
          InkWell(
            onTap: () async {},
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.topRight,
              child: const Text("Forgot Password?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'poppins')),
            ),
          ),
          10.height,
          InkWell(
            onTap: () async {
              Future.delayed(Duration.zero, () {
                context.push(Routes.signupWithEmail);
              });
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              child: const Text("Don't have account? REGISTER",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins')),
            ),
          ),
          10.height,
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
                        scale: 2,
                      ),
                    ))),
                20.width,
                Center(
                    child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: kFaceBookBoxDecoration,
                  child: Image.asset(
                    "assets/facebook.png",
                    scale: 2,
                  ),
                )),
              ])
        ],
      ),
    );
  }
}
