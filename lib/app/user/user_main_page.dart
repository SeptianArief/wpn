import 'package:dashboard_wpn/app/auth/service/auth_service.dart';
import 'package:dashboard_wpn/app/user/user_form_page.dart';
import 'package:dashboard_wpn/app/user/user_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_cubit.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_state.dart';
import 'package:dashboard_wpn/wigdets/custom_dialog.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class UserMainPage extends StatefulWidget {
  UserMainPage({Key? key}) : super(key: key);

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

List<UserModel> dataTempUser = [
  UserModel(level: 1, name: 'Admin', status: '1', username: 'test')
];

class _UserMainPageState extends State<UserMainPage> {
  ValueNotifier<bool> showForm = ValueNotifier(false);
  ValueNotifier<String> searchValue = ValueNotifier('');
  ValueNotifier<UserModel?> userBringData = ValueNotifier(null);
  ValueNotifier<int?> userBringDataIndex = ValueNotifier(null);
  FetchCubit fetchCubit = FetchCubit();

  @override
  void initState() {
    fetchCubit.fetchUser();
    super.initState();
    // user.listUserDashboard();
  }

  Widget buildDataTable(
      {required String title,
      required Widget data,
      Alignment? titleAlignment}) {
    return IntrinsicWidth(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Colors.black12,
            alignment: titleAlignment ?? Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black87),
            ),
          ),
          data
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: showForm,
      builder: (BuildContext context, bool value, Widget? child) {
        return value
            ? UserFormPage(
                showForm: showForm,
                onAdd: () {
                  fetchCubit.fetchUser();
                },
                user: userBringData.value,
                onEdit: (value) {
                  setState(() {
                    dataTempUser[userBringDataIndex.value!] = value;
                  });
                },
              )
            : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              onChanged: (value) {
                                searchValue.value = value;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Cari User..',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                // userBringData.value = null;
                                showForm.value = true;
                              },
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '+ Tambah Akun',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<FetchCubit, FetchState>(
                        bloc: fetchCubit,
                        builder: (context, state) {
                          if (state is FetchLoading) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 50),
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            );
                          } else if (state is ListUserLoaded) {
                            return ValueListenableBuilder(
                                valueListenable: searchValue,
                                builder: (context, String val, _) {
                                  return Column(
                                    children: List.generate(state.data.length,
                                        (index) {
                                      bool isShow =
                                          state.data[index].name.contains(val);
                                      return !isShow
                                          ? Container()
                                          : Container(
                                              margin: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: index ==
                                                          state.data.length - 1
                                                      ? 30
                                                      : 10),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Container(
                                                  padding: EdgeInsets.all(20),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        15),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color: state
                                                                            .data[
                                                                                index]
                                                                            .status ==
                                                                        '0'
                                                                    ? Colors.red
                                                                        .withOpacity(
                                                                            0.3)
                                                                    : Colors
                                                                        .green
                                                                        .withOpacity(
                                                                            0.3)),
                                                            child: Text(
                                                              state.data[index]
                                                                          .status ==
                                                                      '0'
                                                                  ? 'Non-Aktif'
                                                                  : "Aktif",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: state.data[index].status ==
                                                                          '0'
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .green),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            state.data[index]
                                                                .name,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            state.data[index]
                                                                .username,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          userBringData.value =
                                                              state.data[index];
                                                          showForm.value = true;
                                                          userBringDataIndex
                                                              .value = index;
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.orange,
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          EasyLoading.show(
                                                              status:
                                                                  'Mohon Tunggu');
                                                          AuthService.deleteUser(
                                                                  id: state
                                                                      .data[
                                                                          index]
                                                                      .id!
                                                                      .toString())
                                                              .then((value) {
                                                            EasyLoading
                                                                .dismiss();
                                                            if (value.status ==
                                                                RequestStatus
                                                                    .successRequest) {
                                                              showSnackbar(
                                                                  context,
                                                                  title:
                                                                      'Berhasil Menghapus Data User',
                                                                  customColor:
                                                                      Colors
                                                                          .green);
                                                              fetchCubit
                                                                  .fetchUser();
                                                            } else {
                                                              showSnackbar(
                                                                  context,
                                                                  title:
                                                                      'Gagal Menghapus Data User',
                                                                  customColor:
                                                                      Colors
                                                                          .orange);
                                                            }
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 40,
                                                          height: 40,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color: Colors.red,
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                    }),
                                  );
                                });
                          } else {
                            return Container();
                          }
                        })
                  ],
                ));
      },
    );
  }
}
