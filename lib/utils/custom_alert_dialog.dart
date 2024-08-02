import 'package:flutter/material.dart';
import 'package:hap_winner_project/utils/themes/colors.dart';

import 'constant.dart';



class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return showAlertDialog(context, "");
  }

  Future errorDialog(String title, BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(title),
        backgroundColor: kTransBaseNew,
        actions: [
          TextButton(
            child: const Text(
              "OK",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }



  showAlertDialog(BuildContext context, String title) {
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            color: Colors.white),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Buy Subscription",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
              color: Colors.white)),
      onPressed: () {

        Navigator.of(context, rootNavigator: true).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text(title),
      backgroundColor: kTransBaseNew,
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
        Navigator.of(context, rootNavigator: true).pop();

      },
    );
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);

        //Navigator.of(context, rootNavigator: true).pop();
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

}
