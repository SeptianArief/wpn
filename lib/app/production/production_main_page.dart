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

class ProductionMainPage extends StatefulWidget {
  ProductionMainPage({Key? key}) : super(key: key);

  @override
  _ProductionMainPageState createState() => _ProductionMainPageState();
}

class _ProductionMainPageState extends State<ProductionMainPage> {
  ValueNotifier<bool> showForm = ValueNotifier(false);
  ValueNotifier<bool> isDetail = ValueNotifier(false);
  ValueNotifier<Production?> userBringData = ValueNotifier(null);
  ValueNotifier<ProductionFilter> productionFilter =
      ValueNotifier(ProductionFilter());
  ValueNotifier<int?> userBringDataIndex = ValueNotifier(null);
  FetchCubit fetchCubit = FetchCubit();

  // ValueNotifier<UserModel?> userBringData = ValueNotifier(null);

  @override
  void initState() {
    fetchCubit.fetchProduction();
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
        valueListenable: productionFilter,
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
                            : ProductionFormPage(
                                showForm: showForm,
                                user: userBringData.value,
                                onAdd: () {
                                  fetchCubit.fetchProduction();
                                },
                                onEdit: () {
                                  fetchCubit.fetchProduction();
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
                                      productionFilter.value = result;
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
                                        '+ Tambah Data Produksi',
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
                                          productionFilter.value =
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 50),
                                    alignment: Alignment.center,
                                    child: const CircularProgressIndicator(),
                                  );
                                } else if (state is ListProductionLoaded) {
                                  List<Production> dataFinal = state.data;
                                  dataFinal.sort((a, b) => b.tanggalLocal!
                                      .compareTo(a.tanggalLocal!));

                                  List<Production> dataAfterFilter = [];

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
                                      ? const Center(
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
                                                                      'Total Produksi',
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
                                                                      dataAfterFilter[
                                                                              index]
                                                                          .produksi,
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
                                                                      'Total Gagal (Tidak Layak)',
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
                                                                      dataAfterFilter[
                                                                              index]
                                                                          .gagal,
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
                                                                      'Total Lahan (m2)',
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
                                                                      dataAfterFilter[
                                                                              index]
                                                                          .lahan,
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
                                                            ProductionService.deleteProduksi(
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
                                                                        'Berhasil Menghapus Data Produksi',
                                                                    customColor:
                                                                        Colors
                                                                            .green);
                                                                fetchCubit
                                                                    .fetchProduction();
                                                              } else {
                                                                showSnackbar(
                                                                    context,
                                                                    title:
                                                                        'Gagal Menghapus Data Produksi',
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
