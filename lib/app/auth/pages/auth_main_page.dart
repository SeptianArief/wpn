import 'package:dashboard_wpn/app/auth/pages/login_page.dart';
import 'package:dashboard_wpn/app/auth/pages/register_page.dart';
import 'package:dashboard_wpn/app/dashboard/pages/dashboard_main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthMainPage extends StatefulWidget {
  const AuthMainPage({Key? key}) : super(key: key);

  @override
  State<AuthMainPage> createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage> {
  bool isRegister = false;

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('login') != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => DashboardMainPage()));
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isRegister
        ? RegisterPage(
            onPageChange: (value) {
              setState(() {
                isRegister = value;
              });
            },
          )
        : LoginPage(
            onPageChange: (value) {
              setState(() {
                isRegister = value;
              });
            },
          );
  }
}
