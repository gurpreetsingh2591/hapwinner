import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/screens/buy_ticket_screen.dart';
import 'package:hap_winner_project/screens/change_password_screen.dart';
import 'package:hap_winner_project/screens/contact_us.dart';
import 'package:hap_winner_project/screens/contest_detail.dart';
import 'package:hap_winner_project/screens/home_screen.dart';
import 'package:hap_winner_project/screens/my_cart_screen.dart';
import 'package:hap_winner_project/screens/my_profile.dart';
import 'package:hap_winner_project/screens/my_tickets_wins.dart';
import 'package:hap_winner_project/screens/privacy_policy.dart';
import 'package:hap_winner_project/screens/sign_up_with_email_screen.dart';
import 'package:hap_winner_project/screens/forgot_password_screen.dart';

import '../screens/login_screen.dart';
import '../screens/my_past_tickets.dart';
import '../screens/my_tickets.dart';
import '../screens/otp_verification_page.dart';
import '../screens/thank_you_screen.dart';

class Routes {
  // static const selectionPage = '/';
  static const mainHome = '/home';
  static const buyTickets = '/buyTickets';
  static const myCart = '/my_cart';
  static const account = '/account';
  static const signIn = '/';
  static const forgotPassword = '/forgot_password';
  static const upcomingContest = '/upcoming_contest';
  static const signupWithEmail = '/signup_with_email';
  static const thankYouPage = '/thank_you';
  static const otpVerify = '/otp_verify';
  static const myTicketsPage = '/my_tickets';
  static const myWinTicketsPage = '/my_win_tickets';
  static const myPastTicketsPage = '/my_past_tickets';
  static const myProfilePage = '/my_profile';
  static const contestDetail = '/contest_detail';
  static const privacy = '/privacy';
  static const contactUs = '/contact_us';
  static const changePassword = '/change_password';

  static const accountInfo = '/account-info';
  static const pairFailed = '/pair-failed';
  static const alreadyPaired = '/already-paired';
  static const messageToOffice = '/message-to-office';
  static const messageToTeacher = '/message-to-teacher';
  static const meetingWithOffice = '/meeting-with-office';
  static const meetingWithTeacher = '/meeting-with-teacher';
  static const schoolCalender = '/school-calender';
  static const lunchMenu = '/lunch-menu';
  static const snackMenu = '/snack-menu';
  static const switchChild = '/switch-child';
  static const studentPhotos = '/student-photos';
  static const lessonProgress = '/lesson-progress';
  static const setReminder = '/set-reminder';
}

GoRouter buildRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: Routes.signIn,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: Routes.mainHome,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: Routes.buyTickets,
        builder: (_, __) => const BuyTicketsPage(),
      ),
      /* GoRoute(
        path: Routes.myCart,
        builder: (_, __) => const MyCartPage(),
      ),*/

      GoRoute(
        path: Routes.forgotPassword,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: Routes.signupWithEmail,
        builder: (_, __) => const SignUpWithEmailPage(),
      ),
      GoRoute(
        path: Routes.thankYouPage,
        builder: (_, __) => const ThankYouPage(),
      ),
      GoRoute(
        path: Routes.myTicketsPage,
        builder: (_, __) => const MyTicketsPage(),
      ),
      GoRoute(
        path: Routes.myWinTicketsPage,
        builder: (_, __) => const MyTicketsWinsPage(),
      ),
      GoRoute(
        path: Routes.myPastTicketsPage,
        builder: (_, __) => const MyPastTicketsPage(),
      ),
      GoRoute(
        path: Routes.myProfilePage,
        builder: (_, __) => const MyProfilePage(),
      ),
      GoRoute(
        path: Routes.contestDetail,
        builder: (_, __) => const ContestDetailPage(),
      ),
      GoRoute(
        path: Routes.privacy,
        builder: (_, __) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: Routes.contactUs,
        builder: (_, __) => const ContactUsPage(),
      ),
      GoRoute(
        path: Routes.changePassword,
        builder: (_, __) => const ChangePasswordPage(),
      ),
      GoRoute(
        path: Routes.otpVerify,
        name: "otpVerify",
        builder: (context, state) => OtpVerificationScreen(
          userId: state.queryParameters['id']!,
          userType: state.queryParameters['type']!,
        ),
      ),
      GoRoute(
        path: Routes.myCart,
        name: "myCart",
        builder: (context, state) => MyCartPage(
          ticketList: state.queryParameters['list']!,
          lotteryId: state.queryParameters['lotteryId']!,
        ),
      ),

      /* GoRoute(
        path: Routes.changePassword,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: Routes.messageFromSchool,
        builder: (_, __) => const MessageFromSchoolPage(),
      ),


      GoRoute(
        path: Routes.messageToOffice,
        builder: (_, __) => const MessageToOfficePage(),
      ),
      GoRoute(
        path: Routes.messageToTeacher,
        builder: (_, __) => const MessageToTeacherPage(),
      ),
      GoRoute(
        path: Routes.meetingWithTeacher,
        builder: (_, __) => const MeetingWithTeacherPage(),
      ),
      GoRoute(
        path: Routes.meetingWithOffice,
        builder: (_, __) => const MeetingWithOfficePage(),
      ),

      GoRoute(
        path: Routes.lunchMenu,
        builder: (_, __) => const LunchMenuPage(),
      ),

      GoRoute(
        path: Routes.snackMenu,
        builder: (_, __) => const SnackMenuPage(),
      ),
   GoRoute(
        path: Routes.switchChild,
        builder: (_, __) => const SwitchChildPage(),
      ),
   GoRoute(
        path: Routes.studentPhotos,
        builder: (_, __) => const StudentPhotoPage(),
      ),

   GoRoute(
        path: Routes.lessonProgress,
        builder: (_, __) => const LessonProgressPage(),
      ),

   GoRoute(
        path: Routes.schoolCalender,
        builder: (_, __) => const SchoolCalenderPage(),
      ),

  GoRoute(
        path: Routes.setReminder,
        builder: (_, __) => const SetReminderPage(),
      ),

  GoRoute(
        path: Routes.accountInfo,
        builder: (_, __) => const ProfilePage(),
      ),
*/
    ],
  );
}
