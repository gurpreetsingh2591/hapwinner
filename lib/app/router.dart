import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/screens/buy_ticket_screen.dart';
import 'package:hap_winner_project/screens/home_screen.dart';
import 'package:hap_winner_project/screens/my_cart_screen.dart';
import 'package:hap_winner_project/screens/sign_up_with_email_screen.dart';
import 'package:hap_winner_project/screens/signup_screen.dart';
import 'package:hap_winner_project/screens/upcoming_draw_screen.dart';

import '../screens/login_screen.dart';


class Routes {
  // static const selectionPage = '/';
  static const mainHome = '/home';
  static const buyTickets = '/buyTickets';
  static const myCart = '/my_cart';
  static const account = '/account';
  static const signIn = '/';
  static const forgotPassword = '/forgot_password';
  static const upcomingContest = '/upcoming_contest';
  static const signup = '/signup';
  static const signupWithEmail = '/signup_with_email';

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
  static const changePassword = '/changePassword';
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
      GoRoute(
        path: Routes.myCart,
        builder: (_, __) => const MyCartPage(),
      ),
      GoRoute(
        path: Routes.upcomingContest,
        builder: (_, __) => const UpComingDrawPage(),
      ),
      GoRoute(
        path: Routes.signup,
        builder: (_, __) => const SignUpPage(),
      ),      GoRoute(
        path: Routes.signupWithEmail,
        builder: (_, __) => const SignUpWithEmailPage(),
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
