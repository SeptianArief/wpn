import 'package:dashboard_wpn/app/pendapatan/pendapatan_form_page.dart';
import 'package:dashboard_wpn/app/pendapatan/pendapatan_model.dart';
import 'package:dashboard_wpn/app/pendapatan/pendapatan_service.dart';
import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_form_page.dart';
import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_model.dart';
import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_service.dart';
import 'package:dashboard_wpn/app/production/production_filter_dialog.dart';
import 'package:dashboard_wpn/app/production/production_form_page.dart';
import 'package:dashboard_wpn/app/production/production_model.dart';
import 'package:dashboard_wpn/app/production/production_service.dart';
import 'package:dashboard_wpn/app/user/user_form_page.dart';
import 'package:dashboard_wpn/app/user/user_model.dart';
import 'package:dashboard_wpn/shared/api_return_helper.dart';
import 'package:dashboard_wpn/shared/const_value.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_cubit.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_state.dart';
import 'package:dashboard_wpn/wigdets/custom_dialog.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PendapatanMainPage extends StatefulWidget {
  PendapatanMainPage({Key? key}) : super(key: key);

  @override
  _PendapatanMainPageState createState() => _PendapatanMainPageState();
}

class _PendapatanMainPageState extends State<PendapatanMainPage> {
  ValueNotifier<bool> showForm = ValueNotifier(false);
  ValueNotifier<bool> isDetail = ValueNotifier(false);
  ValueNotifier<Penjualan?> userBringData = ValueNotifier(null);
  ValueNotifier<int?> userBringDataIndex = ValueNotifier(null);
  FetchCubit fetchCubit = FetchCubit();
  ValueNotifier<ProductionFilter> pengeluaranFilter =
      ValueNotifier(ProductionFilter());

  // ValueNotifier<UserModel?> userBringData = ValueNotifier(null);

  @override
  void initState() {
    fetchCubit.fetchPenjualan();
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
        valueListenable: pengeluaranFilter,
        builder: (context, ProductionFilter valueFilter, Widget? child) {
          return ValueListenableBuilder(
            valueListenable: showForm,
            builder: (BuildContext context, bool value, Widget? child) {
              return value
                  ? ValueListenableBuilder(
                      valueListenable: isDetail,
                      builder: (context, bool val2, _) {
                        return val2
                            ? Container()
                            : PendapatanFormPage(
                                showForm: showForm,
                                user: userBringData.value,
                                onAdd: () {
                                  fetchCubit.fetchPenjualan();
                                },
                                onEdit: () {
                                  fetchCubit.fetchPenjualan();
                                },
                              );
                      })
                  : Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: ListView(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    ProductionFilter? result = await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const ProductionFilterDialog();
                                        });

                                    if (result != null) {
                                      pengeluaranFilter.value = result;
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          color: Colors.white),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Filter',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    // userBringData.value = null;
                                    showForm.value = true;
                                    isDetail.value = false;
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color:
                                              Theme.of(context).primaryColor),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        '+ Tambah Data Penjualan',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ],
                            ),
                          ),
                          valueFilter.month == null
                              ? Container()
                              : Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, left: 20, right: 5),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Text(
                                          '${bulanData[valueFilter.month!]} ${valueFilter.year!}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          pengeluaranFilter.value =
                                              ProductionFilter();
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      )
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
                                } else if (state is ListPenjualanLoaded) {
                                  List<Penjualan> dataFinal = state.data;
                                  dataFinal.sort((a, b) => b.tanggalLocal!
                                      .compareTo(a.tanggalLocal!));

                                  List<Penjualan> dataAfterFilter = [];

                                  for (var i = 0; i < dataFinal.length; i++) {
                                    if (valueFilter.month != null) {
                                      if (dataFinal[i].tanggal.substring(3) ==
                                          '${(valueFilter.month! + 1).toString().padLeft(2, '0')}/${valueFilter.year}') {
                                        dataAfterFilter.add(dataFinal[i]);
                                      }
                                    } else {
                                      dataAfterFilter.add(dataFinal[i]);
                                    }
                                  }

                                  return dataAfterFilter.isEmpty
                                      ? Center(
                                          child: Text(
                                            'Data Tidak Ditemukan',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black),
                                          ),
                                        )
                                      : Column(
                                          children: List.generate(
                                              dataAfterFilter.length, (index) {
                                            return Container(
                                                margin: EdgeInsets.only(
                                                    left: 20,
                                                    right: 20,
                                                    bottom: index ==
                                                            dataAfterFilter
                                                                    .length -
                                                                1
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
                                                              dataAfterFilter[
                                                                      index]
                                                                  .tanggal,
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Flexible(
                                                                  flex: 3,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Text(
                                                                      'Total Penjualan',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                  flex: 7,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Text(
                                                                      moneyChanger(
                                                                        double.parse(state
                                                                            .data[index]
                                                                            .total),
                                                                      ),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black87),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Flexible(
                                                                  flex: 3,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Text(
                                                                      'Jumlah Kayu terjual',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                  flex: 7,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Text(
                                                                      moneyChanger(
                                                                          double.parse(state
                                                                              .data[
                                                                                  index]
                                                                              .jumlah),
                                                                          customLabel:
                                                                              ''),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black87),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Flexible(
                                                                  flex: 3,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Text(
                                                                      'Pembeli',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                  flex: 7,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Text(
                                                                      state
                                                                          .data[
                                                                              index]
                                                                          .nama,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black87),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Flexible(
                                                                  flex: 3,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Text(
                                                                      'Catatan',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Flexible(
                                                                  flex: 7,
                                                                  child:
                                                                      SizedBox(
                                                                    width: double
                                                                        .infinity,
                                                                    child: Text(
                                                                      state.data[index].catatan.isEmpty
                                                                          ? '-'
                                                                          : state
                                                                              .data[index]
                                                                              .catatan,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.black87),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
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
                                                                dataAfterFilter[
                                                                    index];
                                                            userBringDataIndex
                                                                .value = index;
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
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Icon(
                                                              Icons.edit,
                                                              color:
                                                                  Colors.white,
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
                                                            PendapatanService.deletePendapatan(
                                                                    id: state
                                                                        .data[
                                                                            index]
                                                                        .id
                                                                        .toString())
                                                                .then((value) {
                                                              EasyLoading
                                                                  .dismiss();
                                                              if (value
                                                                      .status ==
                                                                  RequestStatus
                                                                      .successRequest) {
                                                                showSnackbar(
                                                                    context,
                                                                    title:
                                                                        'Berhasil Menghapus Data Penjualan',
                                                                    customColor:
                                                                        Colors
                                                                            .green);
                                                                fetchCubit
                                                                    .fetchPenjualan();
                                                              } else {
                                                                showSnackbar(
                                                                    context,
                                                                    title:
                                                                        'Gagal Menghapus Data Penjualan',
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
                                                            alignment: Alignment
                                                                .center,
                                                            child: Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                          }),
                                        );
                                } else {
                                  return Container();
                                }
                              })
                        ],
                      ));
            },
          );
        });
  }
}
