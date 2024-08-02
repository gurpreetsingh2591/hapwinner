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

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _passwordText = TextEditingController();
  final _confirmPasswordText = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  bool isLoading = false;
  bool isLogin = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool confirmPasswordError = false;
  bool wrongError = false;
  bool switchScreen = false;
  bool passwordError = false;
  FToast fToast = FToast();
  dynamic loginResult;
  dynamic userDataResult;

  final loginBloc = LoginBloc();
  bool dialogShown = false;
  final signupBloc = SignUpBloc();
  String token = "";
  String? _selectedOption = "otp";
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'profile',
  ]);

  final List<ChecklistItem> _items = [
    ChecklistItem('Item 1'),
    ChecklistItem('Item 2'),
  ];

  @override
  void initState() {
    super.initState();

    initializePreference().whenComplete(() {});
    isLogin = SharedPrefs().isLogin();
    if (kDebugMode) {
      print(isLogin);
    }
  }

  Future<void> initializePreference() async {
    SharedPrefs.init(await SharedPreferences.getInstance());
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void changePassword() {
    bool validConfirmPassword = _confirmPasswordText.text.toString().isNotEmpty;
    bool validPassword = _passwordText.text.toString().isNotEmpty;
    bool validPasswordLength = _passwordText.text.toString().length > 5;
    bool validChangePassword = _passwordText.text.toString() == _confirmPasswordText.text.toString();

    if (!validPassword) {
      toast('Enter password', true);
      passwordError = true;
    }
    else if (!validConfirmPassword) {
      toast('Enter confirm password', true);
      confirmPasswordError = true;
    }
   else if (!validPasswordLength) {
      toast('Enter  minimum 6 digit password', true);
      passwordError = true;
    }
    else if (!validChangePassword) {
      toast('Enter both password same', true);
      passwordError = true;
    } else {
      FocusScope.of(context).unfocus();
      passwordError = false;
      confirmPasswordError = false;
      token = SharedPrefs().getUserToken().toString();
      loginBloc.add(GetChangePasswordButtonPressed(
          password: _passwordText.text.toString(),
          confirmPassword: _confirmPasswordText.text.toString(),
          token: token));
    }
  }

  userDataAPI(dynamic loginSuccess, bool isSocial, bool isLoginWithOtp) {
    if (kDebugMode) {
      print("login data---$loginSuccess");
    }
    if (loginSuccess['status'] == 401 && !dialogShown) {
      Future.delayed(Duration.zero, () {
        dialogShown = true;
        toast("Password not changed", false);
      });
    } else {
      if (loginSuccess['status'] == 200) {
        if (!switchScreen) {
          dialogShown = false;
          passwordError = false;
          switchScreen = true;
          toast("Password changed", false);
          _passwordText.text="";
          _confirmPasswordText.text="";
        }
      }
    }
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
                userDataAPI(state.response, false, false);
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
      decoration: kTopBarDecoration,
      constraints: const BoxConstraints.expand(),
      child: Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.only(right: 30, left: 30, top: 30, bottom: 10),
            constraints: const BoxConstraints.expand(),
            child: ListView(
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
                    title: 'Change Password',
                    leftVisibility: true,
                    screen: 'change password',
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
          80.height,
          Stack(
            children: [
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
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: kBaseColor,
                  ),
                ),
              ),
            ],
          ),
          20.height,
          Stack(
            children: [
              CommonPasswordTextField(
                controller: _confirmPasswordText,
                hintText: "Confirm Password",
                text: "",
                isFocused: false,
                textColor: Colors.black,
                focus: _confirmPasswordFocus,
                textSize: 16,
                weight: FontWeight.w400,
                hintColor: Colors.black26,
                obscurePassword: _obscureConfirmPassword,
                error: confirmPasswordError,
                wrongError: wrongError,
              ),
              Container(
                margin: const EdgeInsets.only(top: 13, right: 10),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _toggleConfirmPasswordVisibility,
                  child: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: kBaseColor,
                  ),
                ),
              ),
            ],
          ),
          40.height,
          Container(
            decoration: kButtonBoxDecorationEmpty,
            height: 50,
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("object");
                  }

                  changePassword();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text("Change Password".allInCaps,
                          style: textStyle(
                              Colors.white, 16, 0.5, FontWeight.w400)),
                    ),
                  ],
                )),
          ),
          10.height,
        ],
      ),
    );
  }
}
