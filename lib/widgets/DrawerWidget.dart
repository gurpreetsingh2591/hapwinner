import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hap_winner_project/bloc/event/login_event.dart';
import 'package:hap_winner_project/bloc/logic_bloc/home_bloc.dart';
import 'package:hap_winner_project/bloc/logic_bloc/login_bloc.dart';
import 'package:hap_winner_project/utils/extensions/extensions.dart';

import '../app/router.dart';
import '../bloc/event/home_event.dart';
import '../data/api/ApiService.dart';
import '../model/CommonResponse.dart';
import '../utils/constant.dart';
import '../utils/shared_prefs.dart';
import '../utils/toast.dart';

class DrawerWidget extends StatelessWidget {
  final BuildContext contexts;
  final HomeBloc homeBloc;

  const DrawerWidget({
    Key? key,
    required this.contexts,
    required this.homeBloc,
  }) : super(key: key);

  cancelClick(BuildContext context) {
    Navigator.pop(context);
  }

  showDeleteAccountAlertDialog(
    BuildContext context,
    String title,
    String msg,
  ) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("Yes"),
      onPressed: () {
        Navigator.of(contexts, rootNavigator: true).pop();
        homeBloc.add(GetDeleteAccountData(id: SharedPrefs().getStudentId().toString()));
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

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 150,
              padding: const EdgeInsets.all(10),
              decoration: kButtonBgDecoration,
              margin: const EdgeInsets.only(bottom: 7),
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/logo.png',
              ),
            ),
            10.height,
            SizedBox(
                height: 50,
                child: ListTile(
                  title: Transform(
                    transform: Matrix4.translationValues(-10, 0.0, 0.0),
                    child: Text(
                      'Home',
                      style: textStyle(Colors.black, 16, 0, FontWeight.normal),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Future.delayed(Duration.zero, () {
                      context.pushReplacement(Routes.mainHome);
                    });
                  },
                )),
            7.height,
            SizedBox(
              height: 50,
              child: ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Privacy Policy',
                    style: textStyle(Colors.black, 16, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(Duration.zero, () {
                    context.push(Routes.privacy);
                  });
                  // context.pushReplacement(Routes.snackMenu);
                },
              ),
            ),
            7.height,
            SizedBox(
              height: 50,
              child: ListTile(
                title: Transform(
                  transform: Matrix4.translationValues(-10, 0.0, 0.0),
                  child: Text(
                    'Contact Us',
                    style: textStyle(Colors.black, 16, 0, FontWeight.normal),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Future.delayed(Duration.zero, () {
                    context.push(Routes.contactUs);
                  });
                  // context.pushReplacement(Routes.schoolCalender);
                },
              ),
            ),
            7.height,
            SizedBox(
                height: 50,
                child: ListTile(
                  title: Transform(
                    transform: Matrix4.translationValues(-10, 0.0, 0.0),
                    child: Text(
                      'Delete Account',
                      style: textStyle(Colors.black, 16, 0, FontWeight.normal),
                    ),
                  ),
                  onTap: () async {
                    Navigator.pop(context);

                    showDeleteAccountAlertDialog(context, "Delete Account",
                        "Are you sure to delete account permanently?");
                  },
                )),
            7.height,
            SizedBox(
                height: 50,
                child: ListTile(
                  title: Transform(
                    transform: Matrix4.translationValues(-10, 0.0, 0.0),
                    child: Text(
                      'Logout',
                      style: textStyle(Colors.black, 16, 0, FontWeight.normal),
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
        ));
  }

/* Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }*/
}
