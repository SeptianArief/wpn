import 'package:dashboard_wpn/app/pengeluaran/pengeluaran_model.dart';
import 'package:dashboard_wpn/app/production/production_model.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_cubit.dart';
import 'package:dashboard_wpn/shared/util_cubit/fetch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:webviewx/webviewx.dart';

class MainDashboardPage extends StatefulWidget {
  const MainDashboardPage({Key? key}) : super(key: key);

  @override
  State<MainDashboardPage> createState() => _MainDashboardPageState();
}

class _MainDashboardPageState extends State<MainDashboardPage> {
  FetchCubit productionCubit = FetchCubit();
  FetchCubit pengeluaranCubit = FetchCubit();
  FetchCubit penjualanCubit = FetchCubit();

  TooltipBehavior? _tooltipBehavior;
  List<_ChartData> chartData = <_ChartData>[
    _ChartData(2005, 21, 28),
    _ChartData(2006, 24, 44),
    _ChartData(2007, 36, 48),
    _ChartData(2008, 38, 50),
    _ChartData(2009, 54, 66),
    _ChartData(2010, 57, 78),
    _ChartData(2011, 70, 84)
  ];

  @override
  void initState() {
    productionCubit.fetchProduction();
    pengeluaranCubit.fetchPengeluaran();
    penjualanCubit.fetchPenjualan();
    _tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: false);
    super.initState();
  }

  List<ColumnSeries<ChartSampleData, String>> _getDefaultColumnSeries() {
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
        dataSource: <ChartSampleData>[
          ChartSampleData(x: 'Januari', y: 0.541),
          ChartSampleData(x: 'Februari', y: 0.818),
          ChartSampleData(x: 'Maret', y: 1.51),
          ChartSampleData(x: 'April', y: 1.302),
          ChartSampleData(x: 'Mei', y: 2.017),
          ChartSampleData(x: 'Juni', y: 1.683),
        ],
        xValueMapper: (ChartSampleData sales, _) => sales.x as String,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        dataLabelSettings: const DataLabelSettings(
            isVisible: true, textStyle: TextStyle(fontSize: 10)),
      )
    ];
  }

  List<LineSeries<_ChartData, num>> getDataProduction(
      List<_ChartData> data1, List<_ChartData> data2) {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: data1,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Data Produksi',
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: data2,
          width: 2,
          name: 'Tidak Layak',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }

  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Produk A',
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData,
          width: 2,
          name: 'Produk B',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }

  List<PieSeries<ChartSampleData, String>> _getDefaultPieSeries() {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
          explode: true,
          explodeIndex: 0,
          explodeOffset: '10%',
          dataSource: <ChartSampleData>[
            ChartSampleData(x: 'Produk A', y: 13, text: 'Produk A \n 13%'),
            ChartSampleData(x: 'Produk B', y: 24, text: 'Produk B \n 24%'),
            ChartSampleData(x: 'Produk C', y: 25, text: 'Produk C \n 25%'),
            ChartSampleData(x: 'Produk D', y: 38, text: 'Produk D \n 38%'),
          ],
          xValueMapper: (ChartSampleData data, _) => data.x as String,
          yValueMapper: (ChartSampleData data, _) => data.y,
          dataLabelMapper: (ChartSampleData data, _) => data.text,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: const DataLabelSettings(isVisible: true)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: double.infinity,
    //   height: double.infinity,
    //   child: WebViewX(
    //     width: 1140,
    //     height: 800,
    //     initialContent:
    //         "<iframe width='1140' height='800' src='https://datastudio.google.com/embed/reporting/68fb09d5-9191-4c36-be33-17f38dd7e05d/page/OMGBD' frameborder='0' style='border:0' allowfullscreen></iframe>",
    //     initialSourceType: SourceType.html,
    //     onWebViewCreated: (controller) {},
    //   ),
    // );

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "Dashboard PT Wanapotensi Nusa",
            style: TextStyle(
                fontSize: 20,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // Wrap(
        //   alignment: WrapAlignment.spaceEvenly,
        //   children: List.generate(4, (index) {
        //     return FractionallySizedBox(
        //       widthFactor: 0.24,
        //       child: Card(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(10)),
        //         child: Stack(
        //           children: [
        //             Container(
        //               width: double.infinity,
        //               padding: EdgeInsets.all(20),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'Produksi',
        //                     style:
        //                         TextStyle(fontSize: 13, color: Colors.black54),
        //                   ),
        //                   SizedBox(
        //                     height: 3,
        //                   ),
        //                   Row(
        //                     children: [
        //                       Icon(
        //                         Icons.keyboard_arrow_up,
        //                         color: Colors.green,
        //                       ),
        //                       SizedBox(width: 10),
        //                       Text(
        //                         '100%',
        //                         style: TextStyle(
        //                             fontSize: 25,
        //                             fontWeight: FontWeight.bold,
        //                             color: Colors.black87),
        //                       )
        //                     ],
        //                   )
        //                 ],
        //               ),
        //             ),
        //             //        Positioned(
        //             //   bottom: 0,
        //             //   left: 0,
        //             //   right: 0,
        //             //   child: Container(
        //             //     width: double.infinity,
        //             //     height: 3,
        //             //     decoration: BoxDecoration(
        //             //         color: Colors.blue,
        //             //         borderRadius: BorderRadius.only(
        //             //             bottomLeft: Radius.circular(10),
        //             //             bottomRight: Radius.circular(10))),
        //             //   ),
        //             // )
        //           ],
        //         ),
        //       ),
        //     );
        //   }),
        // ),
        SizedBox(
          height: 20,
        ),
        BlocBuilder<FetchCubit, FetchState>(
            bloc: penjualanCubit,
            builder: (context, state) {
              if (state is ListPenjualanLoaded) {
                ProduksiTahunan penjualanTahunan =
                    ProduksiTahunan.initialState(DateTime.now().year);

                for (var i = 0; i < state.data.length; i++) {
                  int dataMonth =
                      int.parse(state.data[i].tanggal.substring(3, 5)) - 1;

                  penjualanTahunan.data[dataMonth].y =
                      penjualanTahunan.data[dataMonth].y +
                          double.parse(state.data[i].total);
                }

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        title: ChartTitle(text: 'Penjualan Tahun Ini'),
                        primaryXAxis: CategoryAxis(
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        series: <ColumnSeries<ChartSampleData, String>>[
                          ColumnSeries<ChartSampleData, String>(
                            dataSource: List.generate(
                                penjualanTahunan.data.length, (index) {
                              return ChartSampleData(
                                  x: penjualanTahunan.data[index].bulan,
                                  y: penjualanTahunan.data[index].y);
                            }),
                            xValueMapper: (ChartSampleData sales, _) =>
                                sales.x as String,
                            yValueMapper: (ChartSampleData sales, _) => sales.y,
                            dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(fontSize: 10)),
                          )
                        ],
                        tooltipBehavior: _tooltipBehavior,
                      )),
                );
              }

              return Text('hmm');
            }),
        SizedBox(
          height: 20,
        ),
        BlocBuilder<FetchCubit, FetchState>(
            bloc: productionCubit,
            builder: (context, state) {
              if (state is ListProductionLoaded) {
                final int totalData = DateUtils.getDaysInMonth(
                    DateTime.now().year, DateTime.now().month);
                List<_ChartData> dataProduction = [];
                List<_ChartData> dataFailed = [];
                List<_ChartData> dataLahan = [];
                ProduksiTahunan produksiTahunan =
                    ProduksiTahunan.initialState(DateTime.now().year);

                for (var i = 0; i < state.data.length; i++) {
                  int dataMonth =
                      int.parse(state.data[i].tanggal.substring(3, 5)) - 1;

                  produksiTahunan.data[dataMonth].y =
                      produksiTahunan.data[dataMonth].y +
                          double.parse(state.data[i].produksi);
                }

                for (var i = 0; i < totalData; i++) {
                  String paramValue =
                      '${(i + 1).toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year.toString()}';

                  Production? dataFound;

                  for (var j = 0; j < state.data.length; j++) {
                    if (state.data[j].tanggal == paramValue) {
                      dataFound = state.data[j];
                    }
                  }

                  if (dataFound != null) {
                    dataProduction.add(_ChartData((i + 1).toDouble(),
                        double.parse(dataFound.produksi), 0));
                    dataLahan.add(_ChartData(
                        (i + 1).toDouble(), double.parse(dataFound.lahan), 0));
                    dataFailed.add(_ChartData(
                        (i + 1).toDouble(), double.parse(dataFound.gagal), 0));
                  } else {
                    dataProduction.add(_ChartData((i + 1).toDouble(), 0, 0));
                    dataFailed.add(_ChartData((i + 1).toDouble(), 0, 0));
                    dataLahan.add(_ChartData((i + 1).toDouble(), 0, 0));
                  }
                }

                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            title: ChartTitle(text: 'Produksi Tahun Ini'),
                            primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            series: <ColumnSeries<ChartSampleData, String>>[
                              ColumnSeries<ChartSampleData, String>(
                                dataSource: List.generate(
                                    produksiTahunan.data.length, (index) {
                                  return ChartSampleData(
                                      x: produksiTahunan.data[index].bulan,
                                      y: produksiTahunan.data[index].y);
                                }),
                                xValueMapper: (ChartSampleData sales, _) =>
                                    sales.x as String,
                                yValueMapper: (ChartSampleData sales, _) =>
                                    sales.y,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(fontSize: 10)),
                              )
                            ],
                            tooltipBehavior: _tooltipBehavior,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            title: ChartTitle(text: 'Produksi Bulan Ini'),
                            legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            primaryXAxis: NumericAxis(
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                interval: 2,
                                majorGridLines: const MajorGridLines(width: 0)),
                            primaryYAxis: NumericAxis(
                                // labelFormat: '{value} Jt',
                                axisLine: const AxisLine(width: 0),
                                majorTickLines: const MajorTickLines(
                                    color: Colors.transparent)),
                            series:
                                getDataProduction(dataProduction, dataFailed),
                            tooltipBehavior: TooltipBehavior(enable: true),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            title:
                                ChartTitle(text: 'Penggunaan Lahan Bulan Ini'),
                            legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            primaryXAxis: NumericAxis(
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                interval: 2,
                                majorGridLines: const MajorGridLines(width: 0)),
                            primaryYAxis: NumericAxis(
                                // labelFormat: '{value} Jt',
                                axisLine: const AxisLine(width: 0),
                                majorTickLines: const MajorTickLines(
                                    color: Colors.transparent)),
                            series: <LineSeries<_ChartData, num>>[
                              LineSeries<_ChartData, num>(
                                  animationDuration: 2500,
                                  dataSource: dataLahan,
                                  xValueMapper: (_ChartData sales, _) =>
                                      sales.x,
                                  yValueMapper: (_ChartData sales, _) =>
                                      sales.y,
                                  width: 2,
                                  name: 'Data Lahan (m2)',
                                  markerSettings:
                                      const MarkerSettings(isVisible: true)),
                            ],
                            tooltipBehavior: TooltipBehavior(enable: true),
                          )),
                    ),
                  ],
                );
              }

              return Container();
            }),
        SizedBox(
          height: 20,
        ),
        BlocBuilder<FetchCubit, FetchState>(
            bloc: pengeluaranCubit,
            builder: (context, state) {
              if (state is ListPengeluaranLoaded) {
                final int totalData = DateUtils.getDaysInMonth(
                    DateTime.now().year, DateTime.now().month);
                List<_ChartData> dataUpah = [];
                List<_ChartData> dataSparepart = [];
                List<_ChartData> dataOli = [];
                List<_ChartData> dataBensin = [];
                List<_ChartData> dataLainnya = [];

                List<_ChartData> dataTotalPengeluaran = [];

                for (var i = 0; i < totalData; i++) {
                  String paramValue =
                      '${(i + 1).toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year.toString()}';

                  double totalPengeluaran = 0;
                  _ChartData emptyData = _ChartData((i + 1).toDouble(), 0, 0);
                  bool dataFound = false;

                  for (var j = 0; j < state.data.length; j++) {
                    if (state.data[j].tanggal == paramValue) {
                      Pengeluaran data = state.data[j];
                      dataFound = true;
                      totalPengeluaran =
                          totalPengeluaran + double.parse(data.jumlah);
                      _ChartData dataChart = _ChartData(
                          (i + 1).toDouble(), double.parse(data.jumlah), 0);
                      if (data.type == 0) {
                        dataUpah.add(dataChart);
                        dataSparepart.add(emptyData);
                        dataOli.add(emptyData);
                        dataBensin.add(emptyData);
                        dataLainnya.add(emptyData);
                      } else if (data.type == 1) {
                        dataUpah.add(emptyData);
                        dataSparepart.add(dataChart);
                        dataOli.add(emptyData);
                        dataBensin.add(emptyData);
                        dataLainnya.add(emptyData);
                      } else if (data.type == 2) {
                        dataUpah.add(emptyData);
                        dataSparepart.add(emptyData);
                        dataOli.add(dataChart);
                        dataBensin.add(emptyData);
                        dataLainnya.add(emptyData);
                      } else if (data.type == 3) {
                        dataUpah.add(emptyData);
                        dataSparepart.add(emptyData);
                        dataOli.add(emptyData);
                        dataBensin.add(dataChart);
                        dataLainnya.add(emptyData);
                      } else {
                        dataUpah.add(emptyData);
                        dataSparepart.add(emptyData);
                        dataOli.add(emptyData);
                        dataBensin.add(emptyData);
                        dataLainnya.add(dataChart);
                      }
                    }
                  }

                  if (!dataFound) {
                    dataUpah.add(emptyData);
                    dataSparepart.add(emptyData);
                    dataOli.add(emptyData);
                    dataBensin.add(emptyData);
                    dataLainnya.add(emptyData);
                  }

                  dataTotalPengeluaran
                      .add(_ChartData((i + 1).toDouble(), totalPengeluaran, 0));
                }

                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            title: ChartTitle(text: 'Pengeluaran Bulan Ini'),
                            legend: Legend(
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap),
                            primaryXAxis: NumericAxis(
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                interval: 2,
                                majorGridLines: const MajorGridLines(width: 0)),
                            primaryYAxis: NumericAxis(
                                // labelFormat: '{value} Jt',
                                axisLine: const AxisLine(width: 0),
                                majorTickLines: const MajorTickLines(
                                    color: Colors.transparent)),
                            series: <LineSeries<_ChartData, num>>[
                              LineSeries<_ChartData, num>(
                                  animationDuration: 2500,
                                  dataSource: dataUpah,
                                  xValueMapper: (_ChartData sales, _) =>
                                      sales.x,
                                  yValueMapper: (_ChartData sales, _) =>
                                      sales.y,
                                  width: 2,
                                  name: 'Upah',
                                  markerSettings:
                                      const MarkerSettings(isVisible: true)),
                              LineSeries<_ChartData, num>(
                                  animationDuration: 2500,
                                  dataSource: dataSparepart,
                                  xValueMapper: (_ChartData sales, _) =>
                                      sales.x,
                                  yValueMapper: (_ChartData sales, _) =>
                                      sales.y,
                                  width: 2,
                                  name: 'Sparepart',
                                  markerSettings:
                                      const MarkerSettings(isVisible: true)),
                              LineSeries<_ChartData, num>(
                                  animationDuration: 2500,
                                  dataSource: dataOli,
                                  xValueMapper: (_ChartData sales, _) =>
                                      sales.x,
                                  yValueMapper: (_ChartData sales, _) =>
                                      sales.y,
                                  width: 2,
                                  name: 'Oli',
                                  markerSettings:
                                      const MarkerSettings(isVisible: true)),
                              LineSeries<_ChartData, num>(
                                  animationDuration: 2500,
                                  dataSource: dataBensin,
                                  xValueMapper: (_ChartData sales, _) =>
                                      sales.x,
                                  yValueMapper: (_ChartData sales, _) =>
                                      sales.y,
                                  width: 2,
                                  name: 'Bensin',
                                  markerSettings:
                                      const MarkerSettings(isVisible: true)),
                              LineSeries<_ChartData, num>(
                                  animationDuration: 2500,
                                  dataSource: dataLainnya,
                                  xValueMapper: (_ChartData sales, _) =>
                                      sales.x,
                                  yValueMapper: (_ChartData sales, _) =>
                                      sales.y,
                                  width: 2,
                                  name: 'Lainnya',
                                  markerSettings:
                                      const MarkerSettings(isVisible: true)),
                            ],
                            tooltipBehavior: TooltipBehavior(enable: true),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: SfCartesianChart(
                            plotAreaBorderWidth: 0,
                            title: ChartTitle(text: 'Total Pengeluaran'),
                            primaryXAxis: CategoryAxis(
                              majorGridLines: const MajorGridLines(width: 0),
                            ),
                            series: <ColumnSeries<ChartSampleData, String>>[
                              ColumnSeries<ChartSampleData, String>(
                                dataSource: List.generate(
                                    dataTotalPengeluaran.length, (index) {
                                  return ChartSampleData(
                                      x: dataTotalPengeluaran[index]
                                          .x
                                          .toString(),
                                      y: dataTotalPengeluaran[index].y);
                                }),
                                xValueMapper: (ChartSampleData sales, _) =>
                                    sales.x as String,
                                yValueMapper: (ChartSampleData sales, _) =>
                                    sales.y,
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(fontSize: 10)),
                              )
                            ],
                            tooltipBehavior: _tooltipBehavior,
                          )),
                    ),
                  ],
                );
              }

              return Container();
            }),

        // Row(
        //   children: [
        //     Flexible(
        //       flex: 4,
        //       child: Card(
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10)),
        //           child: Container(
        //               height: 300,
        //               width: double.infinity,
        //               padding: EdgeInsets.all(10),
        //               child: SfCircularChart(
        //                 title: ChartTitle(text: 'Data'),
        //                 legend: Legend(isVisible: true),
        //                 series: _getDefaultPieSeries(),
        //               ))),
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     Flexible(
        //       flex: 4,
        //       child: Card(
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10)),
        //           child: Container(
        //               height: 300,
        //               width: double.infinity,
        //               padding: EdgeInsets.all(10),
        //               child: SfCircularChart(
        //                 title: ChartTitle(text: 'Data'),
        //                 legend: Legend(isVisible: true),
        //                 series: _getDefaultPieSeries(),
        //               ))),
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     Flexible(
        //       flex: 3,
        //       child: Card(
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(10)),
        //           child: Container(
        //               width: double.infinity,
        //               height: 300,
        //               padding: EdgeInsets.all(10),
        //               child: Column(
        //                 children: [
        //                   Text(
        //                     'Data Karyawan',
        //                     style: TextStyle(
        //                         fontSize: 12,
        //                         fontWeight: FontWeight.bold,
        //                         color: Colors.black87),
        //                   ),
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Expanded(
        //                       child: ListView(
        //                     children: List.generate(10, (index) {
        //                       return Container(
        //                         margin:
        //                             EdgeInsets.only(top: index == 0 ? 0 : 8),
        //                         child: Row(
        //                           children: [
        //                             Container(
        //                               width: 30,
        //                               height: 30,
        //                               decoration: BoxDecoration(
        //                                   shape: BoxShape.circle,
        //                                   color: Colors.blue),
        //                             ),
        //                             SizedBox(
        //                               width: 8,
        //                             ),
        //                             Expanded(
        //                                 child: Column(
        //                               crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                               children: [
        //                                 Text(
        //                                   'Nama User',
        //                                   style: TextStyle(
        //                                       fontSize: 12,
        //                                       fontWeight: FontWeight.bold,
        //                                       color: Colors.black87),
        //                                 ),
        //                                 Text(
        //                                   'Jabatan',
        //                                   style: TextStyle(
        //                                       fontSize: 12,
        //                                       color: Colors.black87),
        //                                 )
        //                               ],
        //                             ))
        //                           ],
        //                         ),
        //                       );
        //                     }),
        //                   ))
        //                 ],
        //               ))),
        //     ),
        //   ],
        // ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class ChartSampleData {
  late String x;
  late double y;
  late String text;
  ChartSampleData({required this.x, required this.y, this.text = ''});
}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}

class ProduksiTahunan {
  late int tahun;
  List<DateProduksiTahunan> data = [];

  ProduksiTahunan.initialState(int year) {
    tahun = year;
    data = [
      DateProduksiTahunan(bulan: 'Januari', x: 1, y: 0),
      DateProduksiTahunan(bulan: 'Februari', x: 2, y: 0),
      DateProduksiTahunan(bulan: 'Maret', x: 3, y: 0),
      DateProduksiTahunan(bulan: 'April', x: 4, y: 0),
      DateProduksiTahunan(bulan: 'Mei', x: 5, y: 0),
      DateProduksiTahunan(bulan: 'Juni', x: 6, y: 0),
      DateProduksiTahunan(bulan: 'Juli', x: 7, y: 0),
      DateProduksiTahunan(bulan: 'Agustus', x: 8, y: 0),
      DateProduksiTahunan(bulan: 'September', x: 9, y: 0),
      DateProduksiTahunan(bulan: 'Oktober', x: 10, y: 0),
      DateProduksiTahunan(bulan: 'November', x: 11, y: 0),
      DateProduksiTahunan(bulan: 'Desember', x: 12, y: 0),
    ];
  }
}

class DateProduksiTahunan {
  late double x;
  late String bulan;
  late double y;

  DateProduksiTahunan({required this.x, required this.bulan, required this.y});
}
