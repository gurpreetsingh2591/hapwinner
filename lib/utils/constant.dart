import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hap_winner_project/utils/themes/colors.dart';

import '../bloc/logic_bloc/login_bloc.dart';


///Fcm Strings
const String kCollectionId = "hp_printer";
const channel = MethodChannel('HpPhotoBooth');

/// * Static Strings
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter valid Email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password must be at least 6 characters";
const String kConfirmPasswordMatchError = "Your both password not matched";
const String kNameNullError = "Please enter your name";
const String kOTPError = "Please enter valid OTP";
const String kCollectionNameNullError = "Please enter collection name";
const String kStreetNullError = "Please enter your street";
const String kCityNullError = "Please enter your city";
const String kStateNullError = "Please enter your state";
const String kZipCodeNullError = "Please enter your zip code";
const String kCorrectCode = "Please enter 4-set code";
const String kEnterPassword = 'Password';
const String kConfirmPassword = 'Re-enter Password';
const String kEnterEmail = 'E-mail';
const String kOTP = 'OTP';
const String kDescription = 'Your Description Here';
const String kTitle = 'Your Title Here';
const String kNewPassword = 'New Password';
const String kConfirmNewPassword = 'Confirm New Password';
const String kEnterNewPassword = "Entre new password";
const String kEnterConfirmNewPassword = "Entre Confirm new password";
const String kEnterName = "Full name";
const String kEnterCollectionName = "Enter collection name";
const String kEnterDob = "Please enter date of birth";
const String kEnterFullName = "Full Name";
const String kEnterPhone = 'Phone Number';
const String kData = "Data not available";

/// Constants Strings */
const String kSelectLang = "Select Language";
const String kSelectLangList = "Select your language from the list below";
const String kValidCardCVVError = "Please Enter Valid Card CVV";
const String kValidNameOnCardError = "Please Enter Name on Card";
const String kValidSelectCardError = "Please Select  Card";

const String kSubPlansTitle = "Subscription Plans";
const String kSignUpFree = " Start 7-day Free Trial";

const String kSignIn = "Sign In";
const String kHaveNotAcc = "If you haven't account? ";
const String kSignUp = "Sign Up";

const String kVerifyOTP = "Verify OTP";
const String kSignInWith = "Sign in with your success subliminals account";
const String kForgotMsg =
    "Enter your register email, you will get OTP on your email";
const String kNewPasswordMsg = "Enter your new password same in both fields";
const String kOTPMsg =
    "You have received OTP on your email, Please enter below";
const String kCancelSubscriptionAlert =
    "Are you sure to cancel the subscription?";
const String kSetCode = 'Set code';
const String kBioMetrics = "Use Biometrics";
const String kYes = 'Yes';
const String kNo = 'No';
const String kCancel = "Cancel";
const String kOK = 'OK';
const String kSend = "Send";
const String kSubmit = 'Submit';
const String kAgree = 'Agree';
const String kMinus = '-';
const String kPlus = "+";
const String kPound = "£";
const String kThisMonth = "This Month";
const String kLastMonth = "Last Month";
const String kThisYear = "This Year";
const String kLastYear = "Last Year";
const String kLast12Month = "Last 12 Month";
const String kShareStatement = "Share Statement file";
const String kDownloadStatement = 'Download Statement';
const String kShare = 'Share Statement';
const String kStatementExport = "Statement export options";
const String kNote = 'Note';
const String kRegisterAnAccount = "Register an account";

const String kLogout = "Log out";
const String kDeleteAccountTitle = "Delete account";
const String kFAQ = "Frequently asked questions";
const String kNewsUpdate = "News & Updates";
const String kHome = "Home";
const String kPleaseWait = "Please wait...";
const String kEditText = "Edit";
const String kRegister = 'Register';
const String kComingSoon = "Coming Soon";
const String kBuyPaperLink =
    "https://sprocketprinters.com/collections/paper-and-cartridges";

List<String> languageList = [
  'en-GB',
  'en-AU',
  'en-US',
  'de-DE'
      'de-LU'
];
RegExp passwordRegEx = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");

final List<Map<String, String>> languages = [
  {'code': 'en', 'name': 'English'},
  {'code': 'fr', 'name': 'Français'},
  {'code': 'it', 'name': 'Italiano'},
  {'code': 'de', 'name': 'Deutsch'},
  {'code': 'es', 'name': 'Español'},
  {'code': 'ja', 'name': '中文 (简体)'},
  {'code': 'ko', 'name': '中文 (繁體)'},
];
// List of items for the drop-down
final List<String> dropdownItems = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10'
];
ThemeData dialogTheme = ThemeData(
  dialogBackgroundColor: Colors.white, // Change the background color as needed
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // Text color
    // Customize other text styles as needed
  ),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary, // Button text color
  ),
);

List<String> tickets = [
  "5656457",
  "1526376",
  "8766789",
  "4567891",
  "8767654",
  "1235466",
  "2312221",
  "6556878",
  "1235466",
  "1237677"
];

/* launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}*/

Map<String, String> splitName(String inputString) {
  List<String> words = inputString.split(' ');

  if (words.length >= 2) {
    String firstName = words.sublist(0, words.length - 1).join(' ');
    String lastName = words.last;
    return {'firstName': firstName, 'lastName': lastName};
  } else if (words.length == 1) {
    // If there's only one word, put it in the first name
    String firstName = words.first;
    return {'firstName': firstName, 'lastName': ''};
  } else {
    // Handle cases where there are not enough words to split
    return {'firstName': '', 'lastName': ''};
  }
}

BoxDecoration boxImageBgDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: ExactAssetImage('assets/login_bg.png', scale: 1, bundle: null),
    ),
  );
}

BoxDecoration boxImageDrawerBgDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: ExactAssetImage(
        'assets/icons/sidebarmenu_bg.jpg',
      ),
    ),
  );
}

BoxDecoration boxImageDashboardBgDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.cover,
      image: ExactAssetImage(
        'assets/icons/dashboard_bg.jpg',
      ),
    ),
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

const statusBarGradient = LinearGradient(
  colors: <Color>[
    appBaseColor,
    appBaseColor,
  ],
  stops: [0.5, 1.5],
);

final kInnerDecoration = BoxDecoration(
  color: appBaseColor,
  borderRadius: BorderRadius.circular(10),
);

final kEditLineDecoration = BoxDecoration(
  border: Border(bottom: BorderSide(color: Colors.grey.shade400, width: 1.5)),
);

const circleRedBox = BoxDecoration(
  shape: BoxShape.circle, // This property makes the container circular
  color: darkRed, // Set your desired background color
);
const circleYellowBox = BoxDecoration(
  shape: BoxShape.circle, // This property makes the container circular
  color: yellow, // Set your desired background color
);
const circleBlueBox = BoxDecoration(
  shape: BoxShape.circle, // This property makes the container circular
  color: kCircleColor, // Set your desired background color
);
const circleMitiBox = BoxDecoration(
  shape: BoxShape.circle, // This property makes the container circular
  color: miti, // Set your desired background color
);
const circleGreenBox = BoxDecoration(
  gradient: LinearGradient(colors: [kBaseRed, kBaseRedLight]),
  shape: BoxShape.circle, // This property makes the container circular
);
const kInnerDecoration2 = BoxDecoration(
  color: Colors.red,
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
);
final kSelectedDecoration = BoxDecoration(
  color: appBaseColor,
  borderRadius: BorderRadius.circular(8),
);
final kUnSelectedDecoration = BoxDecoration(
  border: Border.all(color: appBaseColor, width: 1),
  borderRadius: BorderRadius.circular(8),
);
final kMessageItemDecoration = BoxDecoration(
  color: gray,
  borderRadius: BorderRadius.circular(10),
);
const kDrawerTileDecoration = BoxDecoration(
    color: kTileBG,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)));

final kEditTextDecoration = BoxDecoration(
  color: Colors.white,
  border: Border.all(color: gray),
  borderRadius: BorderRadius.circular(5),
);
final kEditText1Decoration = BoxDecoration(
  border: Border(
    bottom: BorderSide(width: 1.0, color: Colors.grey), // Specify the color and width of the bottom border
  ),
);

BoxDecoration kButtonBgDecoration = BoxDecoration(
  color: appBaseColor,
  borderRadius: BorderRadius.circular(5),
);
const kTopBarDecoration = BoxDecoration(
  color: appBaseColor,
);
final kTicketDecoration = BoxDecoration(
  color: kBaseColor,
  borderRadius: BorderRadius.circular(15),
);
final kSelectedTicketDecoration = BoxDecoration(
  color: kCircleColor,
  borderRadius: BorderRadius.circular(15),
);
final kWinnerDecoration = BoxDecoration(
  color: pink,
  borderRadius: BorderRadius.circular(5),
);
const kPIBgDecoration = BoxDecoration(
  color: appHpGreen,
);
final kDialogBgDecoration = BoxDecoration(
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(15),
);
final kBgBorderDecoration = BoxDecoration(
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(25),
);

final kDialogBgDecorationSecondary = BoxDecoration(
  color: appBaseColor,
  border: Border.all(color: kTrans),
  borderRadius: BorderRadius.circular(5),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: const LinearGradient(colors: [blue, indigo, purple]),
  borderRadius: BorderRadius.circular(5),
);

final kFaceBookBoxDecoration = BoxDecoration(
  color: kFacebookColor,
  borderRadius: BorderRadius.circular(25),
);
final kGoogleBoxDecoration =
    BoxDecoration(color: kGoogleColor, borderRadius: BorderRadius.circular(25));
final kEmailBoxDecoration = BoxDecoration(
    color: kDisabledButtonColor, borderRadius: BorderRadius.circular(5));
final kButtonBoxDecorationEmpty = BoxDecoration(
  gradient: const LinearGradient(
    colors: [kBaseColor, kBaseColor2],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
  border: Border.all(color: Colors.grey, width: 1),
  borderRadius: BorderRadius.circular(25),
);

const kBlackButtonBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(10.0), // Adjust the radius as needed
    topRight: Radius.circular(10.0), // Adjust the radius as needed
  ),
  border: Border(
    top: BorderSide(
      color: kLightGray, // Specify the color of the stroke
      width: 2.0, // Specify the width of the stroke
    ),
  ),
);

final kAllCornerBoxDecoration = BoxDecoration(
  color: kBaseColor,
  gradient: const LinearGradient(colors: [kPrimaryColor, kPrimaryColor2]),
  borderRadius: BorderRadius.circular(20),
);

TextStyle textStyle(
  Color color,
  double size,
  double letterSpacing,
  FontWeight weight,
) {
  return TextStyle(
      fontSize: size,
      letterSpacing: letterSpacing,
      fontWeight: weight,
      color: color,
      fontFamily: 'poppins');
}

TextStyle hintStyle(
    Color color, double size, double letterSpacing, FontWeight weight) {
  return TextStyle(
      fontSize: size,
      color: color,
      letterSpacing: letterSpacing,
      fontWeight: weight,
      fontFamily: 'poppins');
}

InputBorder border() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: kBaseLightColor,
    ),
  );
}

InputBorder focusedBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      width: 1.5,
      color: kBaseLightColor,
    ),
  );
}

class AppMaterialTextSelectionControls extends MaterialTextSelectionControls {
  AppMaterialTextSelectionControls({
    required this.onPaste,
  });

  ValueChanged<TextSelectionDelegate> onPaste;

  @override
  Future<void> handlePaste(final TextSelectionDelegate delegate) {
    onPaste(delegate);
    return super.handlePaste(delegate);
  }
}

bool isValidName(BuildContext context, String name) {
  bool isValid = false;
  if (name.isEmpty) {
    isValid = false;
  } else {
    isValid = true;
  }

  return isValid;
}

bool isValidEmail(BuildContext context, String email) {
  bool isValid = false;
  if (email.isEmpty) {
    isValid = false;
  } else if (!EmailValidator.validate(email)) {
    isValid = false;
  } else {
    isValid = true;
  }

  return isValid;
}

bool isValidPassword(BuildContext context, String password) {
  bool isValid = false;
  if (password.isEmpty) {
    isValid = false;
  } else if (password.length < 6) {
    isValid = false;
  } else {
    isValid = true;
  }

  return isValid;
}
