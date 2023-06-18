import 'package:dashboard_wpn/app/karyawan/karyawan_form_page.dart';
import 'package:dashboard_wpn/app/karyawan/karyawan_model.dart';
import 'package:dashboard_wpn/app/kpi/kpi_form_page.dart';
import 'package:dashboard_wpn/app/kpi/kpi_model.dart';
import 'package:dashboard_wpn/app/kpi/kpi_service.dart';
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

class KPIMainPage extends StatefulWidget {
  KPIMainPage({Key? key}) : super(key: key);

  @override
  _KPIMainPageState createState() => _KPIMainPageState();
}

class _KPIMainPageState extends State<KPIMainPage> {
  ValueNotifier<bool> showForm = ValueNotifier(false);
  ValueNotifier<KPI?> userBringData = ValueNotifier(null);
  ValueNotifier<int?> userBringDataIndex = ValueNotifier(null);
  FetchCubit fetchCubit = FetchCubit();
  ValueNotifier<String> searchValue = ValueNotifier('');
  // ValueNotifier<UserModel?> userBringData = ValueNotifier(null);

  @override
  void initState() {
    fetchCubit.fetchKPI();
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
    Widget buildDataSummary({required String title, required String desc}) {
      return Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 7,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  desc,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return ValueListenableBuilder(
      valueListenable: showForm,
      builder: (BuildContext context, bool value, Widget? child) {
        return value
            ? KPIFormPage(
                showForm: showForm,
                onAdd: () {
                  fetchCubit.fetchKPI();
                },
                user: userBringData.value,
                onEdit: (value) {},
              )
            : Container(
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
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            )),
                            SizedBox(
                              width: 10,
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
                                    '+ Tambah KPI',
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
                        } else if (state is ListKPILoaded) {
                          return ValueListenableBuilder(
                              valueListenable: searchValue,
                              builder: (context, String val, _) {
                                return Column(
                                  children:
                                      List.generate(state.data.length, (index) {
                                    bool isShow = state.data[index].karyawanName
                                        .contains(val);
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
                                                        Text(
                                                          state.data[index]
                                                              .karyawanName,
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
                                                          'Tanggal KPI : ${state.data[index].kpiDate}',
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        buildDataSummary(
                                                            title:
                                                                'Waktu Rekruitmen',
                                                            desc:
                                                                '${state.data[index].reqruitmentTime} Hari'),
                                                        buildDataSummary(
                                                            title:
                                                                'Nilai Evaluasi Setelah 3 Bulan',
                                                            desc:
                                                                '${state.data[index].evaluationValue}/100'),
                                                        buildDataSummary(
                                                            title:
                                                                'Total Jam Pelatihan',
                                                            desc:
                                                                '${state.data[index].pelatihanTime} Jam'),
                                                        buildDataSummary(
                                                            title:
                                                                'Kenaikan Produktivitas Setelah Pelatihan',
                                                            desc:
                                                                '${state.data[index].kenaikanProduktivitas} %'),
                                                        buildDataSummary(
                                                            title:
                                                                'Skor Kepuasaan Pelatihan',
                                                            desc:
                                                                '${state.data[index].kepuasan}/5'),
                                                        buildDataSummary(
                                                            title:
                                                                'Pegawai Telah Menyiapkan IDP',
                                                            desc: state
                                                                        .data[
                                                                            index]
                                                                        .idpReady ==
                                                                    1
                                                                ? 'Ya'
                                                                : 'Tidak'),
                                                        buildDataSummary(
                                                            title:
                                                                'Pelaksanaan IDP',
                                                            desc: state
                                                                        .data[
                                                                            index]
                                                                        .idpStart ==
                                                                    1
                                                                ? 'Ya'
                                                                : 'Tidak'),
                                                      ],
                                                    )),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        userBringData.value =
                                                            state.data[index];
                                                        userBringDataIndex
                                                            .value = index;
                                                        showForm.value = true;
                                                      },
                                                      child: Container(
                                                        width: 40,
                                                        height: 40,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.orange,
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
                                                        KPIService.deleteKPI(
                                                                id: state
                                                                    .data[index]
                                                                    .id
                                                                    .toString())
                                                            .then((value) {
                                                          EasyLoading.dismiss();
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
                                                                .fetchKPI();
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
                                                                  .circular(10),
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
                      },
                    )
                  ],
                ));
      },
    );
  }
}
