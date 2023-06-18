import 'package:dashboard_wpn/app/karyawan/karyawan_detail_page.dart';
import 'package:dashboard_wpn/app/karyawan/karyawan_filter_dialog.dart';
import 'package:dashboard_wpn/app/karyawan/karyawan_form_page.dart';
import 'package:dashboard_wpn/app/karyawan/karyawan_model.dart';
import 'package:dashboard_wpn/app/karyawan/karyawan_service.dart';
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
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

class KaryawanMainPage extends StatefulWidget {
  KaryawanMainPage({Key? key}) : super(key: key);

  @override
  _KaryawanMainPageState createState() => _KaryawanMainPageState();
}

class _KaryawanMainPageState extends State<KaryawanMainPage> {
  ValueNotifier<bool> showForm = ValueNotifier(false);
  ValueNotifier<bool> isDetail = ValueNotifier(false);
  ValueNotifier<KaryawanModel?> userBringData = ValueNotifier(null);
  ValueNotifier<int?> userBringDataIndex = ValueNotifier(null);
  ValueNotifier<String> searchValue = ValueNotifier('');
  ValueNotifier<int?> filterMonth = ValueNotifier(null);

  FetchCubit fetchCubit = FetchCubit();

  // ValueNotifier<UserModel?> userBringData = ValueNotifier(null);

  bool isLolosFilter(int? filter, String date) {
    if (filter != null) {
      DateTime dateDB = DateFormat('dd/MM/yyyy').parse(date);

      LocalDate a = LocalDate.today();
      LocalDate b = LocalDate.dateTime(dateDB);
      Period diff = a.periodSince(b);

      int totalDiff = (diff.years * 12) + diff.months;

      return totalDiff >= filter;
    } else {
      return true;
    }
  }

  String getLamaBekerja(String value) {
    DateTime dateDB = DateFormat('dd/MM/yyyy').parse(value);

    LocalDate a = LocalDate.today();
    LocalDate b = LocalDate.dateTime(dateDB);
    Period diff = a.periodSince(b);

    return "${diff.years} Tahun ${diff.months} Bulan";
  }

  @override
  void initState() {
    fetchCubit.fetchKaryawan();
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
            ? ValueListenableBuilder(
                valueListenable: isDetail,
                builder: (context, bool isDetail, _) {
                  return isDetail
                      ? KaryawanDetailPage(
                          showForm: showForm,
                          data: userBringData.value!,
                        )
                      : KaryawanFormPage(
                          data: userBringData.value,
                          showForm: showForm,
                          onAdd: () {
                            fetchCubit.fetchKaryawan();
                          },
                          onEdit: (value) {},
                        );
                })
            : ValueListenableBuilder(
                valueListenable: filterMonth,
                builder: (context, int? filter, _) {
                  return Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: ListView(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: TextField(
                                    onChanged: (value) {
                                      searchValue.value = value;
                                    },
                                    decoration: InputDecoration(
                                        hintText: 'Cari Pegawai..',
                                        prefixIcon: Icon(Icons.search),
                                        suffixIcon: InkWell(
                                          onTap: () async {
                                            int? monthValue = await showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return KaryawanFilterDialog();
                                                });

                                            if (monthValue != null) {
                                              filterMonth.value = monthValue;
                                            }
                                          },
                                          child: const Icon(
                                            Icons.filter_alt_rounded,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  )),

                                  // SizedBox(
                                  //   width: 10,
                                  // ),
                                  // InkWell(
                                  //   onTap: () {
                                  //     // userBringData.value = null;
                                  //     showForm.value = true;
                                  //   },
                                  //   child: Container(
                                  //       padding: EdgeInsets.symmetric(horizontal: 20),
                                  //       height: double.infinity,
                                  //       decoration: BoxDecoration(
                                  //           borderRadius: BorderRadius.circular(10),
                                  //           border: Border.all(color: Colors.orange),
                                  //           color: Colors.transparent),
                                  //       alignment: Alignment.center,
                                  //       child: Row(
                                  //         children: [
                                  //           Icon(
                                  //             Icons.filter_alt_rounded,
                                  //             color: Colors.orange,
                                  //           ),
                                  //           Text(
                                  //             'Filter',
                                  //             style: TextStyle(
                                  //                 color: Colors.orange,
                                  //                 fontWeight: FontWeight.bold),
                                  //           ),
                                  //         ],
                                  //       )),
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // userBringData.value = null;
                                      showForm.value = true;
                                      isDetail.value = false;
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Theme.of(context).primaryColor),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '+ Tambah Pegawai',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          filter == null
                              ? SizedBox()
                              : Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 20, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.blue),
                                        child: Text(
                                          'Lama Kerja Minimal ${filter ~/ 12} Tahun ${filter % 12} Bulan',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          filterMonth.value = null;
                                        },
                                        child: Text(
                                          'Reset Filter',
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.blue),
                                        ),
                                      ),
                                    ],
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
                                } else if (state is ListKaryawanLoaded) {
                                  return Column(
                                    children: List.generate(state.data.length,
                                        (index) {
                                      return ValueListenableBuilder(
                                          valueListenable: searchValue,
                                          builder: (context, String val, _) {
                                            bool isShow = state.data[index].name
                                                .contains(val);

                                            if (!isLolosFilter(filter,
                                                state.data[index].startWork)) {
                                              isShow = false;
                                            }

                                            return !isShow
                                                ? Container()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        bottom: index ==
                                                                state.data
                                                                        .length -
                                                                    1
                                                            ? 30
                                                            : 10),
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.all(20),
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
                                                                          vertical:
                                                                              5,
                                                                          horizontal:
                                                                              15),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: state.data[index].status ==
                                                                              1
                                                                          ? Colors.orange.withOpacity(
                                                                              0.3)
                                                                          : Colors
                                                                              .green
                                                                              .withOpacity(0.3)),
                                                                  child: Text(
                                                                    state.data[index].status ==
                                                                            1
                                                                        ? 'Borongan'
                                                                        : "Bulanan",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: state.data[index].status ==
                                                                                1
                                                                            ? Colors.orange
                                                                            : Colors.green),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  state
                                                                      .data[
                                                                          index]
                                                                      .name,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                const SizedBox(
                                                                  height: 2,
                                                                ),
                                                                Text(
                                                                  '${divisionData[state.data[index].division]} (${positionData[state.data[index].division][state.data[index].position]})',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black87,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  'Lama Bekerja : ${getLamaBekerja(state.data[index].startWork)}',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      color: Colors
                                                                          .black54),
                                                                )
                                                              ],
                                                            )),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                userBringData
                                                                        .value =
                                                                    state.data[
                                                                        index];
                                                                showForm.value =
                                                                    true;
                                                                isDetail.value =
                                                                    true;
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
                                                                  color: Colors
                                                                      .blue,
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons
                                                                      .visibility,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                userBringData
                                                                        .value =
                                                                    state.data[
                                                                        index];
                                                                userBringDataIndex
                                                                        .value =
                                                                    index;
                                                                showForm.value =
                                                                    true;
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
                                                                  color: Colors
                                                                      .orange,
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .white,
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
                                                                KaryawanService.deleteKaryawan(
                                                                        id: state
                                                                            .data[
                                                                                index]
                                                                            .id
                                                                            .toString())
                                                                    .then(
                                                                        (value) {
                                                                  EasyLoading
                                                                      .dismiss();
                                                                  if (value
                                                                          .status ==
                                                                      RequestStatus
                                                                          .successRequest) {
                                                                    showSnackbar(
                                                                        context,
                                                                        title:
                                                                            'Berhasil Menghapus Data User',
                                                                        customColor:
                                                                            Colors.green);
                                                                    fetchCubit
                                                                        .fetchKaryawan();
                                                                  } else {
                                                                    showSnackbar(
                                                                        context,
                                                                        title:
                                                                            'Gagal Menghapus Data User',
                                                                        customColor:
                                                                            Colors.orange);
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
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ));
                                          });
                                    }),
                                  );
                                } else {
                                  return Container();
                                }
                              })
                        ],
                      ));
                });
      },
    );
  }
}
