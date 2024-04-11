import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/event/login_event.dart';
import '../bloc/logic_bloc/login_bloc.dart';
import '../bloc/state/common_state.dart';
import '../model/ProfileDataResponse.dart';
import '../utils/toast.dart';
import '../widgets/ButtonWidget.dart';
import '../widgets/ColoredSafeArea.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/themes/colors.dart';
import '../widgets/CommonTextField.dart';
import '../widgets/DrawerWidget.dart';
import '../widgets/TopBarWidget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _addressText = TextEditingController();
  final _postalCodeText = TextEditingController();
  final _cityText = TextEditingController();
  final _phoneText = TextEditingController();
  final _momNameText = TextEditingController();
  final _momSurNameText = TextEditingController();
  final _momPhoneText = TextEditingController();
  final _momAddressText = TextEditingController();
  final _momOccupationText = TextEditingController();
  final _homePhoneText = TextEditingController();
  final _momEmployerText = TextEditingController();
  final _momWorkPhoneText = TextEditingController();
  final _momCityText = TextEditingController();
  final _momWorkPCText = TextEditingController();
  final _momEmailText = TextEditingController();

  final _fatherNameText = TextEditingController();
  final _fatherSurNameText = TextEditingController();
  final _fatherPhoneText = TextEditingController();
  final _fatherAddressText = TextEditingController();
  final _fatherOccupationText = TextEditingController();
  final _fatherWorkPhoneText = TextEditingController();
  final _fatherCityText = TextEditingController();
  final _fatherWorkPCText = TextEditingController();
  final _fatherEmailText = TextEditingController();

  final _doctorNameText = TextEditingController();
  final _doctorPostalCodeText = TextEditingController();
  final _doctorPhoneText = TextEditingController();
  final _doctorAddressText = TextEditingController();

  final _alterName1Text = TextEditingController();
  final _alterRelation1Text = TextEditingController();
  final _alterHomePhone1Text = TextEditingController();
  final _alterName2Text = TextEditingController();
  final _alterRelation2Text = TextEditingController();
  final _alterHomePhone2Text = TextEditingController();

  final _addressFocus = FocusNode();
  final _postalCodeFocus = FocusNode();
  final _cityFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _momNameFocus = FocusNode();
  final _momSurNameFocus = FocusNode();
  final _momPhoneFocus = FocusNode();
  final _momAddressFocus = FocusNode();
  final _momOccupationFocus = FocusNode();
  final _homePhoneFocus = FocusNode();
  final _momEmployerFocus = FocusNode();
  final _momWorkPhoneFocus = FocusNode();
  final _momCityFocus = FocusNode();
  final _momWorkPCFocus = FocusNode();
  final _momEmailFocus = FocusNode();

  final _fatherNameFocus = FocusNode();
  final _fatherSurNameFocus = FocusNode();
  final _fatherPhoneFocus = FocusNode();
  final _fatherAddressFocus = FocusNode();
  final _fatherOccupationFocus = FocusNode();
  final _fatherWorkPhoneFocus = FocusNode();
  final _fatherCityFocus = FocusNode();
  final _fatherWorkPCFocus = FocusNode();
  final _fatherEmailFocus = FocusNode();

  final _doctorNameFocus = FocusNode();
  final _doctorPostalCodeFocus = FocusNode();
  final _doctorPhoneFocus = FocusNode();
  final _doctorAddressFocus = FocusNode();

  final _alterName1Focus = FocusNode();
  final _alterRelation1Focus = FocusNode();
  final _alterHomePhone1Focus = FocusNode();
  final _alterName2Focus = FocusNode();
  final _alterRelation2Focus = FocusNode();
  final _alterHomePhone2Focus = FocusNode();

  String studentId = "";
  String parentId = "";

  bool isLoading = false;
  bool isLogin = false;
  bool selection = true;
  bool isUpdated = false;
  ProfileData? profileData;
  final loginBloc = LoginBloc();
  DateTime selectedDate = DateTime.now();
  String formattedDate = "";

  List<Map<String, dynamic>> updateProfileData = [];

  @override
  void initState() {
    super.initState();

    initializePreference().whenComplete(() {
      isLogin = SharedPrefs().isLogin();
    });
    studentId = SharedPrefs().getStudentId().toString();
    parentId = SharedPrefs().getParentId().toString();

    if (kDebugMode) {
      print(studentId);
      print(parentId);
    }

    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

    loginBloc.add(GetUserProfileData(parentId: parentId));
  }

  setProfileData(dynamic data) {
    try {
      var messagesResponse = ProfileDataResponse.fromJson(data);
      int status = messagesResponse.status;
      String message = messagesResponse.message;
      if (status == 200) {
        profileData = messagesResponse.result;

        _addressText.text = profileData!.vchaddress;
        _postalCodeText.text = profileData!.vchpostalcode;
        _cityText.text = profileData!.vchcity;
        _phoneText.text = profileData!.vchhomephone;
        _momNameText.text = profileData!.vchmomname;
        _momSurNameText.text = profileData!.vchmomsurname;
        _momPhoneText.text = profileData!.vchmomcellphone;
        _momAddressText.text = profileData!.vchaddress;
        _momOccupationText.text = profileData!.vchmomoccupassion;
        _homePhoneText.text = profileData!.vchhomephone;
        _momEmployerText.text = profileData!.vchmomemployer;
        _momWorkPhoneText.text = profileData!.vchmomworkphone;
        _momCityText.text = profileData!.vchmomhomecity;
        _momWorkPCText.text = profileData!.vchmomworkpc;
        _momEmailText.text = profileData!.vchmomemail;
        _fatherNameText.text = profileData!.vchdadname;
        _fatherSurNameText.text = profileData!.vchdadsurname;
        _fatherPhoneText.text = profileData!.vchdadcellphone;
        _fatherAddressText.text = profileData!.vchaddress;
        _fatherOccupationText.text = profileData!.vchdadoccupassion;
        _fatherWorkPhoneText.text = profileData!.vchdadworkphone;
        _fatherCityText.text = profileData!.vchdadhomecity;
        _fatherWorkPCText.text = profileData!.vchdadworkpc;
        _fatherEmailText.text = profileData!.vchdademail;
        _doctorNameText.text = profileData!.vchdoctorname;
        _doctorPostalCodeText.text = profileData!.vchdoctorpostalcode;
        _doctorPhoneText.text = profileData!.vchdoctorphone;
        _doctorAddressText.text = profileData!.vchdoctoraddress;
        _alterName1Text.text = profileData!.vchaltercontactname1;
        _alterRelation1Text.text = profileData!.vchaltercontactrelationship1;
        _alterHomePhone1Text.text = profileData!.vchaltercontactcellphone1;
        _alterName2Text.text = profileData!.vchaltercontactname2;
        _alterRelation2Text.text = profileData!.vchaltercontactrelationship2;
        _alterHomePhone2Text.text = profileData!.vchaltercontacthomephone2;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  callUpdate() {
    final Map<String, String> updatedData = {
      'vchaddress': _addressText.text,
      'vchpostalcode': _postalCodeText.text,
      'vchcity': _cityText.text,
      'vchhomephone': _phoneText.text,
      'vchmomname': _momNameText.text,
      'vchmomsurname': _momSurNameText.text,
      'vchmomcellphone': _momPhoneText.text,
      'vchaddress': _addressText.text,
      'vchmomoccupassion': _momOccupationText.text,
      'vchhomephone': _homePhoneText.text,
      'vchmomemployer': _momEmployerText.text,
      'vchmomworkphone': _momWorkPhoneText.text,
      'vchmomhomecity': _momCityText.text,
      'vchmomworkpc': _momWorkPCText.text,
      'vchmomemail': _momEmailText.text,
      'vchdadname': _fatherNameText.text,
      'vchdadsurname': _fatherSurNameText.text,
      'vchdadcellphone': _fatherPhoneText.text,
      'vchaddress': _addressText.text,
      'vchdadoccupassion': _fatherOccupationText.text,
      'vchdadworkphone': _fatherWorkPhoneText.text,
      'vchdadhomecity': _fatherCityText.text,
      'vchdadworkpc': _fatherWorkPCText.text,
      'vchdademail': _fatherEmailText.text,
      'vchdoctorname': _doctorNameText.text,
      'vchdoctorpostalcode': _doctorPostalCodeText.text,
      'vchdoctorphone': _doctorPhoneText.text,
      'vchdoctoraddress': _doctorAddressText.text,
      'vchaltercontactname1': _alterName1Text.text,
      'vchaltercontactrelationship1': _alterRelation1Text.text,
      'vchaltercontactcellphone1': _alterHomePhone1Text.text,
      'vchaltercontactname2': _alterName2Text.text,
      'vchaltercontactrelationship2': _alterRelation2Text.text,
      'vchaltercontacthomephone2': _alterHomePhone2Text.text,
    };

    loginBloc.add(
        GetUserProfileDataUpdate(parentId: parentId, profileData: updatedData));
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
        key: _scaffoldKey,
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width *
              0.75, // 75% of screen will be occupied
          child: Drawer(
            backgroundColor: Colors.white,
            child: DrawerWidget(
              contexts: context,
            ),
          ), //Drawer
        ),
        body: ColoredSafeArea(
          child: BlocBuilder<LoginBloc, CommonState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return loaderBar(context, mq);
              } else if (state is GetProfileDataState) {
                setProfileData(state.response);
                return buildHomeContainer(context, mq);
              } else if (state is GetUpdateProfileDataState) {


                !isUpdated? toast("Profile Detail have been Updated", false):null;
                isUpdated=true;
               // loginBloc.add(GetUserProfileData(parentId: parentId));

                return buildHomeContainer(context, mq);
              } else if (state is FailureState) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth < 757) {
                    return buildHomeContainer(context, mq);
                  } else {
                    return buildHomeContainer(context, mq);
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget loaderBar(BuildContext context, Size mq) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: boxImageDashboardBgDecoration(),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            decoration: kButtonBgDecoration,
            child: TopBarWidget(
              onTapLeft: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              onTapRight: () {},
              leftIcon: 'assets/icons/menu.png',
              rightIcon: 'assets/icons/user.png',
              title: "Profile",
              rightVisibility: false,
              leftVisibility: true,
              bottomTextVisibility: false,
              subTitle: '',
              screen: 'mwt',
            ),
          ),

                buildTextFieldContainer(context),

          Container(
            height: 500,
            margin: const EdgeInsets.only(bottom: 20, top: 20),
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
      constraints: const BoxConstraints.expand(),
      decoration: boxImageDashboardBgDecoration(),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 60,
            decoration: kButtonBgDecoration,
            child: TopBarWidget(
              onTapLeft: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              onTapRight: () {},
              leftIcon: 'assets/icons/menu.png',
              rightIcon: 'assets/icons/user.png',
              title: "Profile",
              rightVisibility: false,
              leftVisibility: true,
              bottomTextVisibility: false,
              subTitle: '',
              screen: 'mwt',
            ),
          ),
          buildTextFieldContainer(context)
        ],
      ),
    );
  }

  Widget buildTextFieldContainer(BuildContext context){
    return   Container(
        margin: const EdgeInsets.only(
            bottom: 20, top: 82, left: 16, right: 16),
        child: ListView(
          shrinkWrap: true,
          primary: true,
          children: [
            buildBookingHistoryContainer(
                "Address",
                "Postal Code",
                _addressText,
                _postalCodeText,
                _addressFocus,
                _postalCodeFocus),
            10.height,
            buildBookingHistoryContainer("City", "Phone", _cityText,
                _phoneText, _cityFocus, _phoneFocus),
            10.height,
            buildBookingHistoryContainer(
                "Mom's Name",
                "Mom's SurName",
                _momNameText,
                _momSurNameText,
                _momNameFocus,
                _momSurNameFocus),
            10.height,
            buildBookingHistoryContainer(
                "Mom's Phone",
                "Mom's Address",
                _momPhoneText,
                _momAddressText,
                _momPhoneFocus,
                _momAddressFocus),
            10.height,
            buildBookingHistoryContainer(
                "Mom's Occupation",
                "Home Phone",
                _momOccupationText,
                _homePhoneText,
                _momOccupationFocus,
                _homePhoneFocus),
            10.height,
            buildBookingHistoryContainer(
                "Mom's Email",
                "Mom's work Phone",
                _momEmailText,
                _momWorkPhoneText,
                _momEmailFocus,
                _momWorkPhoneFocus),
            10.height,
            buildBookingHistoryContainer(
                "Mom's City",
                "Mom's work Pc",
                _momCityText,
                _momWorkPCText,
                _momCityFocus,
                _momWorkPCFocus),
            10.height,
            buildBookingHistoryContainer(
                "Father's Name",
                "Father's SurName",
                _fatherNameText,
                _fatherSurNameText,
                _fatherNameFocus,
                _fatherSurNameFocus),
            10.height,
            buildBookingHistoryContainer(
                "Father's Phone",
                "Father's Address",
                _fatherPhoneText,
                _fatherAddressText,
                _fatherPhoneFocus,
                _fatherAddressFocus),
            10.height,
            buildBookingHistoryContainer(
                "Father's Occupation",
                "Father's Work Phone",
                _fatherOccupationText,
                _fatherWorkPhoneText,
                _fatherOccupationFocus,
                _fatherWorkPhoneFocus),
            10.height,
            buildBookingHistoryContainer(
                "Father's Email",
                "Father's work Pc",
                _fatherEmailText,
                _fatherWorkPCText,
                _fatherEmailFocus,
                _fatherWorkPCFocus),
            10.height,
            buildBookingHistoryContainer(
                "Doctor's Name",
                "Doctor's Address",
                _doctorNameText,
                _doctorAddressText,
                _doctorNameFocus,
                _doctorAddressFocus),
            10.height,
            buildBookingHistoryContainer(
                "Doctor's Phone",
                "Doctor's Postal Code",
                _doctorPhoneText,
                _doctorPostalCodeText,
                _doctorPhoneFocus,
                _doctorPostalCodeFocus),
            10.height,
            buildBookingHistoryContainer(
                "Alter Contact Name 1",
                "Alter Contact Name 2",
                _alterName1Text,
                _alterName2Text,
                _alterName1Focus,
                _alterName2Focus),
            10.height,
            buildBookingHistoryContainer(
                "Alter Contact Phone 1",
                "Alter Contact Phone 2",
                _alterHomePhone1Text,
                _alterHomePhone2Text,
                _alterHomePhone1Focus,
                _alterHomePhone2Focus),
            10.height,
            buildBookingHistoryContainer(
                "Alter Relation 1",
                "Alter Relation 2",
                _alterRelation1Text,
                _alterRelation2Text,
                _alterRelation1Focus,
                _alterRelation2Focus),
            20.height,
            ButtonWidget(
                name: "Update Profile",
                icon: "",
                visibility: false,
                padding: 0,
                onTap: () {
                  isUpdated=false;
                  callUpdate();
                },
                size: 14,
                scale: 0,
                height: 40,
                decoration: kButtonBoxDecoration,
                textColors: Colors.white,
                rightVisibility: false,
                weight: FontWeight.w400,
                iconColor: Colors.black,
                margin: 0),
            20.height,
          ],
        ),

    );
  }

  Widget buildBookingHistoryContainer(
      String title1,
      String title2,
      TextEditingController controller1,
      TextEditingController controller2,
      FocusNode focusNode1,
      FocusNode focusNode2) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: textStyle(appHintTextColor, 12, 0, FontWeight.w400),
                ),
                5.height,
                CommonTextField(
                    controller: controller1,
                    hintText: "",
                    text: '',
                    isFocused: false,
                    textColor: Colors.black,
                    focus: focusNode1,
                    textSize: 12,
                    weight: FontWeight.w400,
                    hintColor: appHintTextColor,
                    error: false,
                    wrongError: false,
                    decoration: kEditTextDecoration,
                    padding: 5)
              ],
            ),
          ),
          10.width,
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title2,
                  style: textStyle(appHintTextColor, 12, 0, FontWeight.w400),
                ),
                5.height,
                CommonTextField(
                    controller: controller2,
                    hintText: "",
                    text: '',
                    isFocused: false,
                    textColor: Colors.black,
                    focus: focusNode2,
                    textSize: 12,
                    weight: FontWeight.w400,
                    hintColor: appHintTextColor,
                    error: false,
                    wrongError: false,
                    decoration: kEditTextDecoration,
                    padding: 5)
              ],
            ),
          )
        ]);
  }
}
