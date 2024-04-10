import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hap_winner_project/app/router.dart';
import 'package:hap_winner_project/app/theme.dart';
import '../utils/MyCustomScrollBehavior.dart';

Locale locale = const Locale('en');

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final _appKey = GlobalKey();
  final _router = buildRouter();

  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(


          /// Set the app's current locale
          scrollBehavior: MyCustomScrollBehavior(),
          key: _appKey,
          title: 'kmschool',
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          theme: mainTheme,

          debugShowCheckedModeBanner: false,
        );
  }


}
