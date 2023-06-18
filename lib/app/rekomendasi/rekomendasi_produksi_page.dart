import 'dart:math';

import 'package:dashboard_wpn/app/dashboard/pages/main_dashboard_page.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_cubit.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_state.dart';
import 'package:dashboard_wpn/wigdets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RekomendasiProduksiPage extends StatefulWidget {
  const RekomendasiProduksiPage({super.key});

  @override
  State<RekomendasiProduksiPage> createState() =>
      _RekomendasiProduksiPageState();
}

class _RekomendasiProduksiPageState extends State<RekomendasiProduksiPage> {
  FetchCubit productionCubit = FetchCubit();
  FetchCubit pengeluaranCubit = FetchCubit();
  FetchCubit penjualanCubit = FetchCubit();

  @override
  void initState() {
    productionCubit.fetchProduction();
    pengeluaranCubit.fetchPengeluaran();
    penjualanCubit.fetchPenjualan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<FetchCubit, FetchState>(
          bloc: penjualanCubit,
          builder: (context, statePenjualan) {
            return BlocBuilder<FetchCubit, FetchState>(
                bloc: pengeluaranCubit,
                builder: (context, statePengeluaran) {
                  return BlocBuilder<FetchCubit, FetchState>(
                      bloc: productionCubit,
                      builder: (context, stateProduction) {
                        if (stateProduction is ListProductionLoaded &&
                            statePengeluaran is ListPengeluaranLoaded &&
                            statePenjualan is ListPenjualanLoaded) {
                          ProduksiTahunan produksiTahunan =
                              ProduksiTahunan.initialState(DateTime.now().year);
                          ProduksiTahunan pengeluaranTahunan =
                              ProduksiTahunan.initialState(DateTime.now().year);
                          ProduksiTahunan penjualanTahunan =
                              ProduksiTahunan.initialState(DateTime.now().year);

                          for (var i = 0;
                              i < statePengeluaran.data.length;
                              i++) {
                            if (stateProduction.data[i].tanggal
                                .contains(DateTime.now().year.toString())) {
                              if (statePengeluaran.data[i].type == 3) {
                                int dataMonth = int.parse(stateProduction
                                        .data[i].tanggal
                                        .substring(3, 5)) -
                                    1;
                                pengeluaranTahunan.data[dataMonth].y =
                                    pengeluaranTahunan.data[dataMonth].y +
                                        double.parse(
                                            statePengeluaran.data[i].jumlah);
                              }
                            }
                          }

                          for (var i = 0;
                              i < stateProduction.data.length;
                              i++) {
                            if (stateProduction.data[i].tanggal
                                .contains(DateTime.now().year.toString())) {
                              int dataMonth = int.parse(stateProduction
                                      .data[i].tanggal
                                      .substring(3, 5)) -
                                  1;
                              produksiTahunan.data[dataMonth].y =
                                  produksiTahunan.data[dataMonth].y +
                                      double.parse(
                                          stateProduction.data[i].produksi);
                            }
                          }

                          for (var i = 0; i < statePenjualan.data.length; i++) {
                            if (statePenjualan.data[i].tanggal
                                .contains(DateTime.now().year.toString())) {
                              int dataMonth = int.parse(statePenjualan
                                      .data[i].tanggal
                                      .substring(3, 5)) -
                                  1;
                              penjualanTahunan
                                  .data[dataMonth].y = penjualanTahunan
                                      .data[dataMonth].y +
                                  double.parse(statePenjualan.data[i].jumlah);
                            }
                          }

                          String getRecommendEPQ(double penjualanQty,
                              double biayaPerPcs, double production) {
                            return moneyChanger(
                                sqrt(((2 *
                                        penjualanQty *
                                        (biayaPerPcs * production)) /
                                    ((1 - (penjualanQty / production)) *
                                        (biayaPerPcs *
                                            ((penjualanQty / production) *
                                                40))))),
                                customLabel: '');
                          }

                          return ListView(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: Text(
                                  'Rekomendasi Produksi Tahun Ini',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Berikut merupakan data hasil Economic Production Quantity terhadap data-data tahun ini',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black87),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Bulan',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Produksi',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Penjualan',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Biaya Produksi/Pcs',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Rekomendasi EPQ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: List.generate(
                                    produksiTahunan.data.length, (index) {
                                  return Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            produksiTahunan.data[index].bulan,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            moneyChanger(
                                                produksiTahunan.data[index].y,
                                                customLabel: ''),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            moneyChanger(
                                                penjualanTahunan.data[index].y,
                                                customLabel: ''),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            produksiTahunan.data[index].y == 0
                                                ? 'Rp0'
                                                : moneyChanger(
                                                    pengeluaranTahunan
                                                            .data[index].y /
                                                        produksiTahunan
                                                            .data[index].y),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          alignment: Alignment.center,
                                          child: Text(
                                            penjualanTahunan.data[index].y >=
                                                    produksiTahunan
                                                        .data[index].y
                                                ? '-'
                                                : produksiTahunan
                                                            .data[index].y ==
                                                        0
                                                    ? '0'
                                                    : getRecommendEPQ(
                                                        penjualanTahunan
                                                            .data[index].y,
                                                        (pengeluaranTahunan
                                                                .data[index].y /
                                                            produksiTahunan
                                                                .data[index].y),
                                                        produksiTahunan
                                                            .data[index].y),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              )
                            ],
                          );
                        }

                        return Container();
                      });
                });
          }),
    );
  }
}
