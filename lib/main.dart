import 'package:dashboard_wpn/app/auth/pages/auth_main_page.dart';
import 'package:dashboard_wpn/app/auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

void configLoading(BuildContext context) {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 20.0
    ..progressColor = Theme.of(context).primaryColor
    ..backgroundColor = Theme.of(context).primaryColor
    ..indicatorColor = Theme.of(context).primaryColor
    ..textColor = Theme.of(context).primaryColor
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    configLoading(context);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Wanapotensi Nusa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthMainPage(),
        builder: EasyLoading.init(),
      );
    });
  }
}
