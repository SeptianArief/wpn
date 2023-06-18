import 'package:dashboard_wpn/app/auth/service/auth_service.dart';
import 'package:dashboard_wpn/app/user/user_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';

class UserFormPage extends StatefulWidget {
  final UserModel? user;
  final ValueNotifier<bool> showForm;
  final Function() onAdd;
  final Function(UserModel) onEdit;
  UserFormPage(
      {Key? key,
      this.user,
      required this.showForm,
      required this.onAdd,
      required this.onEdit})
      : super(key: key);

  @override
  _UserFormPageState createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  // final picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  bool showPassword = false;
  bool showPreLoadedImage = false;
  // Uint8List? _image;
  // Uint8List? _preloadImage;
  int selectedStatus = 0;
  int selectedLevel = 1;

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      nameController.text = widget.user!.name;
      usernameController.text = widget.user!.username;
      selectedStatus = int.parse(widget.user!.status);

      // AuthAPI.userDetail(id: widget.user!.id.toString()).then((value) {
      //   if (value!.status == RequestStatus.suceess_request) {
      //     setState(() {
      //       nameController.text = widget.user!.name;
      //       usernameController.text = widget.user!.username!;
      //       passwordController.text = widget.user!.password!;
      //       selectedLevel = widget.user!.level;
      //       selectedStatus = int.parse(widget.user!.status);
      //       _preloadImage = value.data!.profilePicture;
      //       showPreLoadedImage = true;
      //     });
      //   }
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    widget.showForm.value = false;
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'User Form',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Nama',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: 'Masukkan Nama Lengkap',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Username',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: usernameController,
              enabled: widget.user == null,
              decoration: InputDecoration(
                  hintText: 'Masukkan Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Password',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            TextField(
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                  hintText: 'Masukkan Password',
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: Icon(
                          showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: showPassword
                              ? Theme.of(context).primaryColor
                              : Colors.grey)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Text(
              'Status Pengguna',
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black45, width: 0.1.w)),
              child: DropdownButton(
                  hint: Text('Status Pengguna'),
                  underline: Container(),
                  value: selectedStatus,
                  isExpanded: true,
                  onChanged: (int? value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Aktif'),
                    ),
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Non-Aktif'),
                    ),
                  ]),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      widget.showForm.value = false;
                    },
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red),
                        alignment: Alignment.center,
                        child: Text(
                          'Batal',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (widget.user == null) {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        AuthService.registyer(
                                username: usernameController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                isActive: selectedStatus.toString())
                            .then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                title: 'Berhasil Menambah Data User',
                                customColor: Colors.green);
                            widget.showForm.value = false;
                            widget.onAdd();
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menyimpan Data User',
                                customColor: Colors.orange);
                          }
                        });
                      } else {
                        EasyLoading.show(status: 'Mohon Tunggu');
                        AuthService.udpateUser(
                                username: usernameController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                id: widget.user!.id!.toString(),
                                isActive: selectedStatus.toString())
                            .then((value) {
                          EasyLoading.dismiss();
                          if (value.status == RequestStatus.successRequest) {
                            showSnackbar(context,
                                title: 'Berhasil Menyimpan Data User',
                                customColor: Colors.green);
                            widget.showForm.value = false;
                            widget.onAdd();
                          } else {
                            showSnackbar(context,
                                title: 'Gagal Menyimpan Data User',
                                customColor: Colors.orange);
                          }
                        });
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        alignment: Alignment.center,
                        child: Text(
                          'Simpan',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0.w),
          ],
        ));
  }
}
