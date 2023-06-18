import 'package:dashboard_wpn/app/auth/pages/register_page.dart';
import 'package:dashboard_wpn/app/auth/service/auth_service.dart';
import 'package:dashboard_wpn/app/dashboard/pages/dashboard_main_page.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final Function(bool) onPageChange;
  const LoginPage({Key? key, required this.onPageChange}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController pwdcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Center(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 100),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text('Dashboard PT Wanapotensi Nusa',
                                  style: TextStyle(
                                      fontSize: 21,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Text('Sign In',
                                style: TextStyle(
                                  fontSize: 21,
                                  color: Colors.black87,
                                )),
                          ],
                        ),
                        SizedBox(height: 40),
                        InputField(
                            controller: controller,
                            borderType: 'border',
                            onChanged: (value) {},
                            hintText: 'Username'),
                        SizedBox(
                          height: 20,
                        ),
                        InputField(
                            borderType: 'border',
                            controller: pwdcontroller,
                            obscureText: true,
                            onChanged: (value) {},
                            hintText: 'Password'),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Row(
                        //       children: [
                        //         Checkbox(
                        //             value: false,
                        //             shape: RoundedRectangleBorder(
                        //                 borderRadius: BorderRadius.circular(4)),
                        //             onChanged: (value) {}),
                        //         Text('Ingat Saya',
                        //             style: TextStyle(
                        //               fontSize: 15,
                        //               color: Colors.black87,
                        //             )),
                        //       ],
                        //     ),
                        //     InkWell(
                        //       onTap: () {},
                        //       hoverColor: Colors.transparent,
                        //       child: Text('Lupa Password?',
                        //           style: TextStyle(
                        //             fontSize: 15,
                        //             color: Colors.black87,
                        //           )),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                            onTap: () async {
                              if (controller.text.isEmpty ||
                                  pwdcontroller.text.isEmpty) {
                                showSnackbar(context,
                                    title: 'Mohon Mengisi Semua Form Login',
                                    customColor: Colors.orange);
                              } else {
                                EasyLoading.show(status: 'Mohon Tunggu');
                                AuthService.login(
                                        username: controller.text,
                                        password: pwdcontroller.text)
                                    .then((value) async {
                                  EasyLoading.dismiss();
                                  if (value.status ==
                                      RequestStatus.successRequest) {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('login', controller.text);
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                DashboardMainPage()));
                                  } else {
                                    showSnackbar(context,
                                        title:
                                            'Username/Password Salah Silahkan coba lagi',
                                        customColor: Colors.orange);
                                  }
                                });
                              }
                            },
                            text: 'Masuk',
                            pressAble: true),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Belum memiliki akun? ',
                                ),
                                TextSpan(
                                    text: 'Daftar',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        widget.onPageChange(true);
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue)),
                              ]),
                        ))
                      ],
                    )))));
  }
}
