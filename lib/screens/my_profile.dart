import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/event/profile_event.dart';
import 'package:hap_winner_project/bloc/event/tickets_event.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';
import 'package:hap_winner_project/utils/toast.dart';
import 'package:hap_winner_project/widgets/CommonMobileField.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../app/router.dart';
import '../bloc/logic_bloc/buy_ticket_bloc.dart';
import '../bloc/logic_bloc/my_profile_bloc.dart';
import '../bloc/logic_bloc/my_ticket_bloc.dart';
import '../bloc/state/common_state.dart';
import '../model/TicketNumbersResponse.dart';
import '../model/my_tickets/UserContestTicket.dart';
import '../model/profileData/UserResponse.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/CommonTextField.dart';
import '../widgets/MyTicketsWidget.dart';
import '../widgets/TopBarWidget.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLogin = false;
  bool isLoader = false;
  bool isEdit = false;
  String token = "";
  final _emailText = TextEditingController();
  final _nameText = TextEditingController();
  final _dobText = TextEditingController();
  final _phoneText = TextEditingController();
  final _addressText = TextEditingController();
  final _cityText = TextEditingController();
  final _stateText = TextEditingController();
  final _countryText = TextEditingController();
  final _pinCodeText = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _countryFocus = FocusNode();
  final FocusNode _pinCodeFocus = FocusNode();
  List<UserContestTicket> myTicketList = [];
  var myProfileBloc = MyProfileBloc();
  String selectedDate = '';

  // Current selected value
  String? _selectedItem;

  @override
  void initState() {
    super.initState();

    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });

    setState(() {
      token = SharedPrefs().getUserToken().toString();
    });
    _emailText.text = SharedPrefs().getUserEmail().toString() == "null"
        ? ""
        : SharedPrefs().getUserEmail().toString();
    _nameText.text = SharedPrefs().getUserFullName().toString() == "null"
        ? ""
        : SharedPrefs().getUserFullName().toString();
    _phoneText.text = SharedPrefs().getUserPhone().toString() == "null"
        ? ""
        : SharedPrefs().getUserPhone().toString();

    _dobText.text = SharedPrefs().getUserDob().toString() == "null"
        ? ""
        : SharedPrefs().getUserDob().toString();
    _addressText.text = SharedPrefs().getUserAddress().toString() == "null"
        ? ""
        : SharedPrefs().getUserAddress().toString();
    _cityText.text = SharedPrefs().getUserCity().toString() == "null"
        ? ""
        : SharedPrefs().getUserCity().toString();
    _stateText.text = SharedPrefs().getUserState().toString() == "null"
        ? ""
        : SharedPrefs().getUserState().toString();
    _countryText.text = SharedPrefs().getUserCountry().toString() == "null"
        ? ""
        : SharedPrefs().getUserCountry().toString();
    _pinCodeText.text = SharedPrefs().getUserPinCode().toString() == "null"
        ? ""
        : SharedPrefs().getUserPinCode().toString();
    //  buyTicketBloc.add(GetMyWinTicketListData(token: token));
  }

  getProfileSaveData(dynamic ticketResponse) {
    var profileData = ticketResponse;

    if (profileData != "") {
      // UserResponse userResponse = UserResponse.fromJson(profileData);
      if (profileData['data']['user']['name'] != null) {
        SharedPrefs().setUserFullName(profileData['data']['user']['name']);
      }
      SharedPrefs().setUserEmail(profileData['data']['user']['email']);
      if (profileData['data']['user']['phone_number'] != null) {
        SharedPrefs().setUserPhone(profileData['data']['user']['phone_number']);
      }

      if (profileData['data']['userdetails']['dateofbirth'] != null) {
        SharedPrefs()
            .setUserDob(profileData['data']['userdetails']['dateofbirth']);
      }

      if (profileData['data']['userdetails']['address'] != null) {
        SharedPrefs()
            .setUserAddress(profileData['data']['userdetails']['address']);
      }
      if (profileData['data']['userdetails']['state'] != null) {
        SharedPrefs().setState(profileData['data']['userdetails']['state']);
      }
      if (profileData['data']['userdetails']['city'] != null) {
        SharedPrefs().setUserCity(profileData['data']['userdetails']['city']);
      }

      if (profileData['data']['userdetails']['country'] != null) {
        SharedPrefs().setCountry(profileData['data']['userdetails']['country']);
      }
      if (profileData['data']['userdetails']['pincode'] != null) {
        SharedPrefs()
            .setUserPinCode(profileData['data']['userdetails']['pincode']);
      }
    }
    isLoader = true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: appBaseColor, // Change button color here
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

        _dobText.text = selectedDate;
      });
    }
  }

  setSaveProfile(String name, String email, String dob, String phone,
      String address, String city, String state, String country, String pin) {
    myProfileBloc.add(GetSaveDataData(
        token: token,
        name: name,
        email: email,
        phone: phone,
        dob: dob,
        address: address,
        city: city,
        state: state,
        country: country,
        pinCode: pin));
  }

  Future<void> initializePreference() async {
    SharedPrefs.init(await SharedPreferences.getInstance());
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => myProfileBloc,
      child: Scaffold(
        key: _scaffoldKey,
        body: ColoredSafeArea(
          child: BlocBuilder<MyProfileBloc, CommonState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return buildHomeContainer(context, mq, true);
              } else if (state is SuccessState) {
                getProfileSaveData(state.response);
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
              title: 'My Profile',
              leftVisibility: true,
              screen: 'buy_ticket',
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
      padding: const EdgeInsets.all(20),
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Personal Details",
              style: textStyle(Colors.white, 22, 0, FontWeight.w500),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  !isEdit ? isEdit = true : isEdit = false;
                });
              },
              child: const Icon(
                Icons.edit,
                size: 18,
              ),
            ),
          ]),
          20.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Name  :",
              style: textStyle(Colors.white, 16, 0, FontWeight.w400),
            ),
            10.width,
            !isEdit
                ? Text(
                    SharedPrefs().getUserFullName().toString(),
                    style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                  )
                : Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CommonTextField(
                            controller: _nameText,
                            hintText: "Name",
                            text: SharedPrefs().getUserEmail().toString(),
                            isFocused: false,
                            textColor: Colors.white,
                            focus: _nameFocus,
                            textSize: 18,
                            weight: FontWeight.w400,
                            hintColor: Colors.grey,
                            error: false,
                            wrongError: false,
                            decoration: kEditText1Decoration,
                            padding: 0,
                            leftIcon: false,
                            enable: true))),
          ]),
          5.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Date of birth  :",
              style: textStyle(Colors.white, 16, 0, FontWeight.w400),
            ),
            10.width,
            !isEdit
                ? Text(
                    SharedPrefs().getUserDob().toString() == "null"
                        ? ""
                        : SharedPrefs().getUserDob().toString(),
                    style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                  )
                : Flexible(
                    child: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: CommonTextField(
                              controller: _dobText,
                              hintText: "DOB",
                              text: SharedPrefs().getUserEmail().toString(),
                              isFocused: false,
                              textColor: Colors.white,
                              focus: _dobFocus,
                              textSize: 18,
                              weight: FontWeight.w400,
                              hintColor: Colors.grey,
                              error: false,
                              wrongError: false,
                              decoration: kEditText1Decoration,
                              padding: 0,
                              leftIcon: false,
                              enable: false,
                            )))),
          ]),
          5.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Email  :",
              style: textStyle(Colors.white, 16, 0, FontWeight.w400),
            ),
            10.width,
            !isEdit
                ? Text(
                    SharedPrefs().getUserEmail().toString() == "null"
                        ? ""
                        : SharedPrefs().getUserEmail().toString(),
                    style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                  )
                : Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CommonTextField(
                            controller: _emailText,
                            hintText: "Email",
                            text: SharedPrefs().getUserEmail().toString(),
                            isFocused: false,
                            textColor: Colors.white,
                            focus: _emailFocus,
                            textSize: 18,
                            weight: FontWeight.w400,
                            hintColor: Colors.grey,
                            error: false,
                            wrongError: false,
                            decoration: kEditText1Decoration,
                            padding: 0,
                            leftIcon: false,
                            enable: true))),
          ]),
          5.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Phone  :",
              style: textStyle(Colors.white, 16, 0, FontWeight.w400),
            ),
            10.width,
            !isEdit
                ? Text(
                    SharedPrefs().getUserPhone().toString() == "null"
                        ? ""
                        : SharedPrefs().getUserPhone().toString(),
                    style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                  )
                : Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CommonMobileField(
                          controller: _phoneText,
                          hintText: "Mobile",
                          text: "",
                          isFocused: false,
                          textColor: Colors.white,
                          focus: _phoneFocus,
                          textSize: 18,
                          weight: FontWeight.w400,
                          hintColor: Colors.grey,
                          error: false,
                          wrongError: false,
                          decoration: kEditText1Decoration,
                          padding: 0,
                          leftIcon: false,
                        ))),
          ]),
          5.height,
          15.height,
          const Divider(
            thickness: 1,
            color: Colors.white,
          ),
          15.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Account Settings",
              style: textStyle(Colors.white, 22, 0, FontWeight.w500),
            ),
          ]),
          20.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Address  :",
              style: textStyle(Colors.white, 16, 0, FontWeight.w400),
            ),
            10.width,
            !isEdit
                ? Text(
                    SharedPrefs().getUserAddress().toString() == "null"
                        ? ""
                        : SharedPrefs().getUserAddress().toString(),
                    style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                  )
                : Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CommonTextField(
                            controller: _addressText,
                            hintText: "Address",
                            text: "",
                            isFocused: false,
                            textColor: Colors.white,
                            focus: _addressFocus,
                            textSize: 18,
                            weight: FontWeight.w400,
                            hintColor: Colors.grey,
                            error: false,
                            wrongError: false,
                            decoration: kEditText1Decoration,
                            padding: 0,
                            leftIcon: false,
                            enable: true))),
          ]),
          15.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "City  :",
              style: textStyle(Colors.white, 16, 0, FontWeight.w400),
            ),
            10.width,
            !isEdit
                ? Text(
                    SharedPrefs().getUserCity().toString() == "null"
                        ? ""
                        : SharedPrefs().getUserCity().toString(),
                    style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                  )
                : Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CommonTextField(
                            controller: _cityText,
                            hintText: "City",
                            text: SharedPrefs().getUserEmail().toString(),
                            isFocused: false,
                            textColor: Colors.white,
                            focus: _cityFocus,
                            textSize: 18,
                            weight: FontWeight.w400,
                            hintColor: Colors.grey,
                            error: false,
                            wrongError: false,
                            decoration: kEditText1Decoration,
                            padding: 0,
                            leftIcon: false,
                            enable: true))),
          ]),
          15.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "State  :",
              style: textStyle(Colors.white, 16, 0, FontWeight.w400),
            ),
            10.width,
            !isEdit
                ? Text(
                    SharedPrefs().getUserState().toString() == "null"
                        ? ""
                        : SharedPrefs().getUserState().toString(),
                    style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                  )
                : Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CommonTextField(
                            controller: _stateText,
                            hintText: "State",
                            text: SharedPrefs().getUserEmail().toString(),
                            isFocused: false,
                            textColor: Colors.white,
                            focus: _stateFocus,
                            textSize: 18,
                            weight: FontWeight.w400,
                            hintColor: Colors.grey,
                            error: false,
                            wrongError: false,
                            decoration: kEditText1Decoration,
                            padding: 0,
                            leftIcon: false,
                            enable: true)),
                  ),
          ]),
          15.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Country  :",
              style: textStyle(Colors.white, 16, 0, FontWeight.w400),
            ),
            10.width,
            !isEdit
                ? Text(
                    SharedPrefs().getUserCountry().toString() == "null"
                        ? ""
                        : SharedPrefs().getUserCountry().toString(),
                    style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                  )
                : Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CommonTextField(
                            controller: _countryText,
                            hintText: "Country",
                            text: SharedPrefs().getUserEmail().toString(),
                            isFocused: false,
                            textColor: Colors.white,
                            focus: _countryFocus,
                            textSize: 18,
                            weight: FontWeight.w400,
                            hintColor: Colors.grey,
                            error: false,
                            wrongError: false,
                            decoration: kEditText1Decoration,
                            padding: 0,
                            leftIcon: false,
                            enable: true)),
                  ),
          ]),
          15.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Pin Code  :",
              style: textStyle(Colors.white, 16, 0, FontWeight.w400),
            ),
            10.width,
            !isEdit
                ? Text(
                    SharedPrefs().getUserPinCode().toString() == "null"
                        ? ""
                        : SharedPrefs().getUserPinCode().toString(),
                    style: textStyle(Colors.white, 16, 0, FontWeight.w400),
                  )
                : Flexible(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: CommonMobileField(
                          controller: _pinCodeText,
                          hintText: "Pin Code",
                          text: SharedPrefs().getUserEmail().toString(),
                          isFocused: false,
                          textColor: Colors.white,
                          focus: _pinCodeFocus,
                          textSize: 18,
                          weight: FontWeight.w400,
                          hintColor: Colors.grey,
                          error: false,
                          wrongError: false,
                          decoration: kEditText1Decoration,
                          padding: 0,
                          leftIcon: false,
                        ))),
          ]),
          20.height,
          const Divider(
            thickness: 1,
            color: Colors.white,
          ),
          15.height,
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Change Password",
              style: textStyle(Colors.white, 22, 0, FontWeight.w500),
            ),
            InkWell(
                onTap: () {
                  Future.delayed(Duration.zero, () {
                    context.push(Routes.changePassword);
                  });
                },
                child: const Icon(
              Icons.edit,
              size: 18,
            ),),
          ]),
          40.height,
          Container(
            decoration: kButtonBoxDecorationEmpty,
            height: 50,
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  setSaveProfile(
                      _nameText.text.toString(),
                      _emailText.text.toString(),
                      _dobText.text.toString(),
                      _phoneText.text.toString(),
                      _addressText.text.toString(),
                      _cityText.text.toString(),
                      _stateText.text.toString(),
                      _countryText.text.toString(),
                      _pinCodeText.text.toString());
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text("Save".allInCaps,
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
