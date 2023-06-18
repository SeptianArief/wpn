import 'package:dashboard_wpn/app/auth/service/auth_service.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterPage extends StatefulWidget {
  final Function(bool) onPageChange;
  const RegisterPage({Key? key, required this.onPageChange}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
                            Text('Sign Up',
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
                            controller: nameController,
                            borderType: 'border',
                            onChanged: (value) {},
                            hintText: 'Nama Lengkap'),
                        SizedBox(
                          height: 20,
                        ),
                        InputField(
                            controller: emailController,
                            obscureText: true,
                            borderType: 'border',
                            onChanged: (value) {},
                            hintText: 'Password'),
                        SizedBox(
                          height: 20,
                        ),
                        InputField(
                            borderType: 'border',
                            controller: pwdcontroller,
                            obscureText: true,
                            onChanged: (value) {},
                            hintText: 'Konfirmasi Password'),
                        SizedBox(
                          height: 30,
                        ),
                        CustomButton(
                            onTap: () async {
                              if (controller.text.isNotEmpty &&
                                  emailController.text.isNotEmpty &&
                                  pwdcontroller.text.isNotEmpty &&
                                  nameController.text.isNotEmpty) {
                                if (emailController.text !=
                                    pwdcontroller.text) {
                                  showSnackbar(context,
                                      title:
                                          'Password dan Konfirmasi Password Tidak Sama',
                                      customColor: Colors.orange);
                                } else {
                                  EasyLoading.show(status: 'Mohon Tunggu');
                                  AuthService.registyer(
                                          username: controller.text,
                                          name: nameController.text,
                                          password: pwdcontroller.text)
                                      .then((value) {
                                    EasyLoading.dismiss();
                                    if (value.status ==
                                        RequestStatus.successRequest) {
                                      showSnackbar(context,
                                          title:
                                              'Pendaftaran Berhasil Silahkan Menunggu akun Anda diaktifkan Admin',
                                          customColor: Colors.green);
                                      widget.onPageChange(false);
                                    } else {
                                      showSnackbar(context,
                                          title: 'Gagal melakukan register',
                                          customColor: Colors.orange);
                                    }
                                  });
                                }
                              } else {
                                showSnackbar(context,
                                    title:
                                        'Mohon Mengisi Semua Form Pendaftaran',
                                    customColor: Colors.orange);
                              }
                            },
                            text: 'Daftar',
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
                                  text: 'Sudah memiliki akun? ',
                                ),
                                TextSpan(
                                    text: 'Masuk',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        widget.onPageChange(false);
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
