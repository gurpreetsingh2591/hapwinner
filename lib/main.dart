import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hap_winner_project/utils/shared_prefs.dart';
import 'package:hap_winner_project/utils/themes/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Upgrader.clearSavedSettings();
  try {


    SharedPrefs.init(await SharedPreferences.getInstance());
  } catch (e) {
    if (kDebugMode) {
      print("Firebase initialization error: $e");
    }
  }



  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: appBaseColor),
          dialogBackgroundColor: Colors.black54,
          // Set the background color for dialogs
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                color: Colors.white), // Set the text color for dialogs
            // Customize other text styles as needed
          ),
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.primary, // Set button text color
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: UpgradeAlert(
              dialogStyle: UpgradeDialogStyle.cupertino,
              child: const Scaffold(
                body: MyApp(),
              )),


      )));


}



