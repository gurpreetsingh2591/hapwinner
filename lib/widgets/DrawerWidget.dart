import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';


import '../app/router.dart';
import '../data/api/ApiService.dart';
import '../model/CommonResponse.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/toast.dart';

final Uri _url = Uri.parse('https://flutter.dev');

class DrawerWidget extends StatelessWidget {
  final BuildContext contexts;

  const DrawerWidget({
    Key? key,
    required this.contexts,
  }) : super(key: key);


   Future<void> yesClick(BuildContext context)  async {
     Navigator.of(context, rootNavigator: true).pop();

   //  showVerifyEmailLoader(context,true);

     dynamic getUserData =  await ApiService().getDeleteUserData(SharedPrefs().getParentId().toString());

    // Ensure listener fires
    var deleteUser = CommonResponse.fromJson(getUserData);
    dynamic status = deleteUser.status;
    String message = deleteUser.message;



    if (status == 200) {
     toast(message, false);
      SharedPrefs().setIsLogin(false);
      SharedPrefs().reset();
      context.go(Routes.signIn);

   }
    // Navigator.pop(context);

  }
   cancelClick(BuildContext context){
    Navigator.pop(context);
  }

  showDeleteAccountAlertDialog(BuildContext context, String title, String msg,
      ) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        yesClick(contexts);
      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        //Navigator.pop(contexts);

        Navigator.of(contexts, rootNavigator: true).pop();
        },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title:
      Text(title, style: textStyle(Colors.black, 14, 0, FontWeight.normal)),
      content: Text(
        msg,
        style: textStyle(Colors.black, 14, 0, FontWeight.normal),
      ),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  showVerifyEmailLoader(BuildContext context, bool isLoading) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Visibility(
              visible: isLoading,
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(20),
                      decoration: kDialogBgDecorationSecondary,
                      child: const SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
                ),
              ));
        });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxImageDrawerBgDecoration(),
      child: ListView(
        padding: const EdgeInsets.only(top: 40, left: 10),
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15, bottom: 7),
            alignment: Alignment.topLeft,
            child: Image.asset(
              'assets/icons/app_logo.png',
              scale: 4,
            ),
          ),
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/home.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Home',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.mainHome);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/menu_list.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Lunch Menu',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.lunchMenu);
                },
              )),
          7.height,
          SizedBox(
            height: 40,
            child: ListTile(
              leading: Image.asset(
                'assets/icons/food.png',
                scale: 12,
              ),
              title: Transform(
                transform: Matrix4.translationValues(-10, 0.0, 0.0),
                child: Text(
                  'Snacks Menu',
                  style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                context.pushReplacement(Routes.snackMenu);
              },
            ),
          ),
          7.height,
          SizedBox(
            height: 40,
            child: ListTile(
              leading: Image.asset(
                'assets/icons/calender.png',
                scale: 12,
              ),
              title: Transform(
                transform: Matrix4.translationValues(-10, 0.0, 0.0),
                child: Text(
                  'School Calender',
                  style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                context.pushReplacement(Routes.schoolCalender);
              },
            ),
          ),
          7.height,
          SizedBox(
            height: 40,
            child: ListTile(
              leading: Image.asset(
                'assets/icons/message_from_school.png',
                scale: 12,
              ),
              title: Transform(
                transform: Matrix4.translationValues(-10, 0.0, 0.0),
                child: Text(
                  'Message From School',
                  style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                context.pushReplacement(Routes.messageFromSchool);
              },
            ),
          ),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/meeting_with_teacher.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Meeting With Teacher',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.meetingWithTeacher);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/meeting_with_office.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Meeting With Office',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.meetingWithOffice);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/message_to_teacher.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Message To Teacher',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.messageToTeacher);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/message_to_office.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Message To Office',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.messageToOffice);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/user.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Work in Progress',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.lessonProgress);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/user.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Photos',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.studentPhotos);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/user.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Settings',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.setReminder);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/user.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Profile',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.accountInfo);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/user.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Change Password',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  context.pushReplacement(Routes.changePassword);
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/remove.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Delete Account',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () async {
                  Navigator.pop(context);

                  showDeleteAccountAlertDialog(context,"Delete Account","Are you sure to delete account permanently?");
                },
              )),
          7.height,
          SizedBox(
              height: 40,
              child: ListTile(
                leading: Image.asset(
                  'assets/icons/logout.png',
                  scale: 12,
                ),
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Logout',
                    style: textStyle(Colors.black, 14, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  SharedPrefs().setIsLogin(false);
                  SharedPrefs().reset();

                  context.go(Routes.signIn);
                },
              )),
          7.height,
        ],
      ),
    );
  }

/* Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }*/
}
